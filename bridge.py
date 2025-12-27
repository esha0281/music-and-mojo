
# various imports and library calls
from pylsl import StreamInlet, resolve_streams
from collections import deque
from pythonosc.udp_client import SimpleUDPClient
import numpy as np
import mne



# data address configuration and variable setup
# --- Configuration ---
OSC_IP = "127.0.0.1"
OSC_PORT = 8000
# STREAM_NAME = "UN-2024.04.20"
STREAM_NAME = 'UnicornRecorderLSLStream'
EEG_CHANNEL_INDEX=1 # Index of the EEG channel to process (0-7)

#Sampling Rate for Unicorn EEG Black 
SFREQ = 250 # in Hz, typical Unicorn EEG sample rate

# Max Plot for LIVE (Toggle, Scaling Configuration)

# new variables related to embedded EEG range/scaling configuration directly from script, rather than manual control 
# utilizing a double-ended array to to convert stream transfer rate, and max/min values for the scale plot trigger 
# added by Erik Shamsedeen 12/11/2025 testing for DEV Branch, later exported by Ryan to stable Main development 

BUFFER_SIZE = 250 # in samples, size of the buffer, thus the translation of tempo

# data processing variable 

data_buffer = deque(maxlen=BUFFER_SIZE) 

FREQ_BANDS = {
    "Alpha": [8, 12]
}


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

def get_band_power(data, fs, band):
    # Uses MNE to calculate power in specfic frequency band
    # Calculate Power Spectral Density (PSD) using Welch's method 
    psds, freqs = mne.time_frequency.psd_array_welch(
        data,
        sfreq=fs,
        fmin=band[0],
        fmax=band[1],
        n_fft=125,
        verbose=False
    )

    band_power=np.sum(psds)
    print(freqs)
    return band_power


# --- Main Loop ---
try:
    sample_counter=0
    while True:
        # Pull a sample from the 17 channels
        sample, timestamp = inlet.pull_sample()

        if sample:
            raw_value = sample[EEG_CHANNEL_INDEX]
            # print(f"Raw EEG Value (Channel {EEG_CHANNEL_INDEX}): {raw_value}")
            data_buffer.append(raw_value)
            # 2. Only process if buffer is full AND we want to save CPU
            # (Processing every single sample is unnecessary and slow. Let's process every 10 samples)
            sample_counter += 1
        
            if(len(data_buffer) == BUFFER_SIZE and sample_counter >=10):
                sample_counter=0 
                epoch_data=np.array(data_buffer)
                # print(f"Processing Epoch Data: {epoch_data}")

                alpha_power=get_band_power(epoch_data[np.newaxis, :], SFREQ, FREQ_BANDS["Alpha"])

                scaled_alpha = alpha_power * 1000000
                # Send OSC message with the calculated band power
                osc_client.send_message(f"/eeg/alpha_power", float(alpha_power))
                print(f"Sent Alpha Power: {alpha_power}")

except KeyboardInterrupt:
    print("\nStream stopped by user.")
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    print("Exiting.")