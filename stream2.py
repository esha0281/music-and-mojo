import csv
# from tqdm import tqdm
import time
from pylsl import StreamInfo, StreamOutlet

# Replays a recorded EEG CSV as a live LSL stream ("SpoofedEEG"), so the rest of
# the pipeline (bridge2.py -> Max -> Ableton) runs without a headset.
csv_path = './data/Alex_Jam_2026-06-27.csv'
stream_name = 'SpoofedEEG'
n_channels = 8
sample_rate = 250
LOOP = True  # start the CSV again at the end, so a demo never runs dry

info = StreamInfo(stream_name, 'EEG', n_channels, sample_rate,
                  'float32', 'spoofed001')
outlet = StreamOutlet(info)

try:
    # Pace by a running deadline, not a plain sleep(1/250): a plain sleep
    # oversleeps (we measured 35 Hz instead of 250 on a busy Mac), which slows
    # the replay and changes the note tempo in Max.
    next_t = time.perf_counter()
    sent, t0 = 0, time.time()
    while True:
        with open(csv_path, 'r') as f:
            reader = csv.reader(f)
            header = next(reader) # skip header if present
            for row in reader:
                sample = [float(x) for x in row[:n_channels]]
                outlet.push_sample(sample)
                sent += 1
                next_t += 1.0 / sample_rate
                delay = next_t - time.perf_counter()
                if delay > 0:
                    time.sleep(delay)
                if time.time() - t0 >= 5:
                    print(f"streaming {sent / (time.time() - t0):.0f} Hz from {csv_path}")
                    sent, t0 = 0, time.time()
        if not LOOP:
            break
        print("End of CSV, starting again.")

except KeyboardInterrupt:
    print("\nStream stopped by user.")
except Exception as e:
    print(f"An error occurred: {e}")
finally:
    print("Exiting.")
