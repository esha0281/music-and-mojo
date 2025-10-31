# 🎶 Music and Mojo 🔮
Python script converting live EEG data from g.tec Unicorn Hybrid Black into OSC data for use by Max for Live.

## 🧰 Prerequisites 
### 3rd Party Software
* [Unicorn Recorder](https://www.gtec.at/product/unicorn-suite/) - Proprietary software suite for Unicorn Hybrid Black (comes with Unicorn Suite)
* [Ableton Live](https://www.ableton.com/en/trial/) - Digital Audio Workstation (DAW)
* [Max for Live](https://www.ableton.com/en/live/max-for-live/) - DSP Envrionment embedded within ABleton(included with Ableton Live 12)
* `python` v3.13.5
* see `requirements.txt` for others

## 🗂️ Project Structure
```bash
music-and-mojo/
├── data/
│   ├── UnicornRecorder_04_07_2025_17_43_410.csv                  # 5 min sample of EEG data from Unicorn recorder
│   ├── data/UnicornRecorder_04_07_2025_17_43_41.bdf              # same sample in .bdf folder
├── bridge.py                             # basic forwarder from LSL -> OSC -> UDP to Max for Live
├── discover_streams.py                   # LSL script to find active streams
├── stream.py                             # Stream local .csv data via LSL
├── requirements.txt                      # venv requirements
```
## ⚙️ Setup & Development
**1. Create a virtual environment**
  ```bash
  python -m venv mojo
  source mojo/bin/activate  # (on Windows: mojo\Scripts\activate)
  ```
**2. Clone the repository**
  ```bash
  git clone https://github.com/esha0281/music-and-mojo.git
  cd music-and-mojo
  ```

**3. Install dependencies**
  ```bash
  pip install -r requirements.txt
  ```

v0.1.0 - stopping on 2025-10-30
