from pylsl import StreamInlet, resolve_streams
from pythonosc.udp_client import SimpleUDPClient

OSC_IP = "127.0.0.1"
OSC_PORT = 8000
# STREAM_NAME = "UN-2024.04.20"
STREAM_NAME = 'UnicornRecorderLSLStream'

# --- LSL Connection ---
print(f"Resolving LSL stream with name '{STREAM_NAME}'...")
# Use resolve_stream() to find a specific stream by name.
# It's more direct than getting all streams and filtering.
streams = resolve_streams(10)

# In case the stream is not found, streams will be an empty list.
if not streams:
    print(f"Error: Could not find a stream with name '{STREAM_NAME}'.")
    print("Please ensure the Unicorn LSL application is running and broadcasting.")
    exit()

# Select the first EEG stream found
inlet = StreamInlet(streams[0])
stream_info = inlet.info()
print(f"Connected to LSL stream: {stream_info.name()} ({stream_info.type()})")

# --- OSC Client Setup ---
osc_client = SimpleUDPClient(OSC_IP, OSC_PORT)
print(f"Sending OSC data to {OSC_IP}:{OSC_PORT}")

# --- Main Loop ---
try:
    while True:
        # Pull a sample from the 17 channels
        sample, timestamp = inlet.pull_sample()
        if sample:
            # Loop through each of the 17 values in the sample
            for i, val in enumerate(sample):
                # Send each value to a unique OSC address (e.g., /eeg/0, /eeg/1, ...)
                # print(f"/eeg/{i}", val)
                osc_client.send_message(f"/eeg/{i}", val)
except KeyboardInterrupt:
    print("\nStream stopped by user.")
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    print("Exiting.")