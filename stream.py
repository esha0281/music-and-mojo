import csv
# from tqdm import tqdm
import time
from pylsl import StreamInfo, StreamOutlet

csv_path = './data/UnicornRecorder_04_07_2025_17_43_410.csv'
stream_name = 'SpoofedEEG'
n_channels = 8
sample_rate = 250

info = StreamInfo(stream_name, 'EEG', n_channels, sample_rate,
                  'float32', 'spoofed001')
outlet = StreamOutlet(info)

try:
    with open(csv_path, 'r') as f:
        reader = csv.reader(f)
        header = next(reader) # skip header if present
        for row in reader:
            sample = [float(x) for x in row[:n_channels]]
            outlet.push_sample(sample)
            time.sleep(1.0 / sample_rate)

except KeyboardInterrupt:
    print("\nStream stopped by user.")
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    print("Exiting.")