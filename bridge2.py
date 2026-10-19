
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


# Max Plot for LIVE (Toggle, Scaling Configuration)

# new variables related to embedded EEG range/scaling configuration directly from script, rather than manual control 
# utilizing a double-ended array to to convert stream transfer rate, and max/min values for the scale plot trigger 
# added by Erik Shamsedeen 12/11/2025 testing for DEV Branch, later exported by Ryan to stable Main development 


# data processing variable 

# data_buffer = deque(maxlen=BUFFER_SIZE) 
min_seen = float('inf') # start at positive infinity (thus ensuring a minimum is found)
max_seen = float('-inf') # start at negative infinity (thus ensuring a maximum is found)

# bpm based calculation and tempo formation (UNICORN HYBRID BLACK is 250Hz per EEG channel)
# bpm = (SAMPLE_RATE/BUFFER_SIZE) * 60 # Calculate BPM based on sample rate and buffer size
# print(f"Calculated BPM based on sample rate and buffer size: {bpm} BPM")



# --- LSL Connection ---
print(f"Resolving LSL stream with name '{STREAM_NAME}'...")
# Use resolve_stream() to find a specific stream by name.
# It's more direct than getting all streams and filtering.
streams = resolve_byprop('name', STREAM_NAME, timeout=10)

# In case the stream is not found, streams will be an empty list.
if not streams:
    print(f"No stream named '{STREAM_NAME}'. Is stream.py running?")
    exit()

# Select the first EEG stream found
inlet = StreamInlet(streams[0])
stream_info = inlet.info()
print(f"Connected to LSL stream: {stream_info.name()} ({stream_info.type()})")

# --- OSC Client Setup ---
osc_client = SimpleUDPClient(OSC_IP, OSC_PORT)
print(f"Sending OSC data to {OSC_IP}:{OSC_PORT}")

sent, t0 = 0, time.time()
# --- Main Loop ---
try:
    while True:
        # Pull a sample from the 17 channels
        sample, timestamp = inlet.pull_sample()
        if sample is None:
            print("No samples for 2 s: did stream.py finish its CSV?")
            continue
        
        # raw_value = sample[7] # changed from channel 7 with Alex 2026-01-18

        # min_seen = raw_value - 200
        # max_seen = raw_value + 200
        # osc_client.send_message(f"/eeg/processed", [float(raw_value)])
        # osc_client.send_message(f"/eeg/processed", [float(raw_value), float(min_seen), float(max_seen)])
        
        # more pythonic
        osc_client.send_message("/eeg/processed", [float(sample[7])])
        sent += 1
        if time.time() - t0 >= 1:
            print(f"sent {sent} msgs/s to {OSC_IP}:{OSC_PORT}, last {sample[7]:.2f}")
            sent, t0 = 0, time.time()
        # if sample:
        #     # Loop through each of the 17 values in the sample
        #     for i, val in enumerate(sample):
        #         # Send each value to a unique OSC address (e.g., /eeg/0, /eeg/1, ...)
        #         # print(f"/eeg/{i}", val)
        #         osc_client.send_message(f"/eeg/{i}", val)

except KeyboardInterrupt:
    print("\nStream stopped by user.")
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    print("Exiting.")