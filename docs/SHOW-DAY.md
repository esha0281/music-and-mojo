# Show day: Oct 19 (one page)

**Tonight (10 min):** follow GIT-STEPS, then do one full run with `max/EEG-MIDI-Controls.amxd`. If it misbehaves, play with `max/ch8VisualMIDI.amxd` (the old device works with the new bridge).

**Start order**
1. Laptop on power, Wi-Fi/Bluetooth on, Live open with the set saved.
2. Terminal 1: `.\venv\Scripts\Activate.ps1`, then **headset**: Unicorn LSL app streaming, or **replay**: `python stream.py` (look for `streaming 250 Hz`).
3. `python discover_streams.py`: the stream name shows up. It must match `STREAM_NAME` in bridge2.py.
4. Terminal 2: activate, then `python bridge2.py` (look for `sent ~250 msgs/s … range …`).
5. In the device: the raw box moves; turn Auto Range on, Note Every about 500–900 ms; sound check.

**If something fails**

| What | Do |
|---|---|
| Headset drops | Ctrl+C the bridge, set `STREAM_NAME = 'SpoofedEEG'`, then run `stream.py` and the bridge (about 30 s). |
| No sound but the raw box moves | Check the track's instrument and monitoring, the note range, and the MIDI ch. |
| Raw box frozen | Look at the bridge's terminal. "No samples" means the source stopped; restart it. |
| Live crashes | Reopen the set. Leave Python running. |
| New device acts up | Swap in `ch8VisualMIDI.amxd` and set scale min/max to the bridge's printed `range` numbers. |

Never run the scripts in WSL (its 127.0.0.1 isn't Windows' 127.0.0.1).
