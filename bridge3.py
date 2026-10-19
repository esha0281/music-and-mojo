
# bridge3.py: LSL EEG stream -> OSC/UDP -> Max for Live device in Ableton
# Sends one raw channel as /eeg/processed (every sample), plus an optional
# /eeg/range <low> <high> once per second so the Max device can set its
# scale range by itself (the "Auto Range" toggle). Older devices ignore it.

# various imports and library calls
from pylsl import StreamInlet, resolve_byprop
from collections import deque
from pythonosc.udp_client import SimpleUDPClient
import numpy as np
import time



# data address configuration and variable setup
# --- Configuration ---
OSC_IP = "127.0.0.1"
OSC_PORT = 8000
# STREAM_NAME = "UN-2024.04.20"
# STREAM_NAME = 'UnicornRecorderLSLStream'
STREAM_NAME = 'SpoofedEEG'
CHANNEL = 7  # 0-based index: 7 = the 8th channel (changed with Alex 2026-01-18)

# Auto range: send the 5th..95th percentile of the last RANGE_WINDOW_S seconds
# as /eeg/range, once a second. Percentiles (not min/max) so one blink or
# cable bump doesn't stretch the range. Set SEND_RANGE = False to turn it off.
SEND_RANGE = True
RANGE_WINDOW_S = 10
RANGE_PERCENTILES = (5, 95)
SAMPLE_RATE = 250  # Hz (Unicorn Hybrid Black is 250 Hz per channel)

# Max Plot for LIVE (Toggle, Scaling Configuration)

# new variables related to embedded EEG range/scaling configuration directly from script, rather than manual control
# utilizing a double-ended array to to convert stream transfer rate, and max/min values for the scale plot trigger
# added by Erik Shamsedeen 12/11/2025 testing for DEV Branch, later exported by Ryan to stable Main development


# data processing variable
recent = deque(maxlen=RANGE_WINDOW_S * SAMPLE_RATE)

# bpm based calculation and tempo formation (UNICORN HYBRID BLACK is 250Hz per EEG channel)
# bpm = (SAMPLE_RATE/BUFFER_SIZE) * 60 # Calculate BPM based on sample rate and buffer size
# print(f"Calculated BPM based on sample rate and buffer size: {bpm} BPM")



# --- LSL Connection ---
print(f"Resolving LSL stream with name '{STREAM_NAME}'...")
streams = resolve_byprop('name', STREAM_NAME, timeout=10)

# In case the stream is not found, streams will be an empty list.
if not streams:
    print(f"No stream named '{STREAM_NAME}'. Is stream.py (or the Unicorn LSL app) running?")
    exit()

inlet = StreamInlet(streams[0])
stream_info = inlet.info()
print(f"Connected to LSL stream: {stream_info.name()} ({stream_info.type()})")

# --- OSC Client Setup ---
osc_client = SimpleUDPClient(OSC_IP, OSC_PORT)
print(f"Sending OSC data to {OSC_IP}:{OSC_PORT}")

# The once-a-second status line costs one clock read per sample; it does not
# slow the stream (measured: >10,000 msgs/s possible, the stream sends 250).
sent, t0 = 0, time.time()
# --- Main Loop ---
try:
    while True:
        # timeout=2.0 so a stopped stream prints a hint instead of hanging silently
        sample, timestamp = inlet.pull_sample(timeout=2.0)
        if sample is None:
            print("No samples for 2 s: did stream.py finish its CSV?")
            continue

        value = float(sample[CHANNEL])
        osc_client.send_message("/eeg/processed", [value])
        recent.append(value)
        sent += 1

        if time.time() - t0 >= 1:
            line = f"sent {sent} msgs/s to {OSC_IP}:{OSC_PORT}, last {value:.2f}"
            if SEND_RANGE and len(recent) >= SAMPLE_RATE:
                low, high = np.percentile(recent, RANGE_PERCENTILES)
                if high > low:
                    osc_client.send_message("/eeg/range", [float(low), float(high)])
                    line += f", range {low:.1f}..{high:.1f}"
            print(line)
            sent, t0 = 0, time.time()

except KeyboardInterrupt:
    print("\nStream stopped by user.")
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    print("Exiting.")
