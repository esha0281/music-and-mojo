# What changed and how it works (POC → demo branch `present-202661019`)

These notes are for the team and for questions at the demo. The pipeline is the same as the POC: **Python reads one EEG channel and sends it to Max, and Max turns it into notes.** Two things changed:

1. The Python scripts got sturdier (steady timing, clear messages, automatic range).
2. The Max device got knobs, so nobody has to open the patch during a set.

File names below are the ones in your branch:
- `stream2.py` is the kit's `stream.py`.
- `bridge3.py` is the kit's `bridge2.py`.
- `README.md` and the docs still say `stream.py` / `bridge2.py`. Rename those mentions, or rename the files back.

---

## The 30-second version (for the demo)

> "The headset (or a recording of Alex's session) streams 8 channels of EEG at 250 samples a second over LSL. A small Python bridge picks one channel and sends each value to Ableton over OSC. It also works out the signal's normal range over the last 10 seconds. Inside Ableton, a Max for Live device maps that value onto a range of notes, at a tempo we set with a knob. Before, we had to open the patch and retype numbers whenever the signal drifted. Now the range follows the signal by itself, and every setting is a knob you can map to a MIDI controller."

Avoid saying it "reads emotions", "measures focus", or anything medical. It's an instrument driven by a brain signal.

---

## 1. `stream2.py` (replay a recording as a live stream)

**POC:** read the CSV, push one row, then `time.sleep(1/250)`, and stop at the end of the file.

**Now:**

| Change | Why | Lines |
|---|---|---|
| **Deadline pacing.** It keeps a running target time (`next_t += 1/250`) and sleeps only for what's left until then. | A plain `sleep(0.004)` oversleeps. Every sleep adds a little delay, and the delays add up. We measured **35 Hz instead of 250 Hz** on a busy machine, and 246–250 Hz with deadline pacing. The replay was running up to 7× slow, which also slowed the notes, because the POC patch counted samples. | `next_t = time.perf_counter()` … `delay = next_t - time.perf_counter()` |
| **`LOOP = True`.** At the end of the file it starts again. | A demo should never run out of data. | the `while True:` around the file |
| **A rate print every 5 s:** `streaming 250 Hz from …` | You can see at a glance that the source is alive and at the right speed. | `if time.time() - t0 >= 5:` |
| `csv_path = './data/Alex_Jam_2026-06-27.csv'` | Matches the file in your data folder. | top |

The rest is unchanged: the stream name `SpoofedEEG`, 8 channels and the float32 format.

## 2. `bridge3.py` (LSL → OSC)

**POC:** take the first stream it finds, wait forever for each sample, and send `sample[7]` as `/eeg/processed`.

**Now:**

| Change | Why |
|---|---|
| `resolve_byprop('name', STREAM_NAME, timeout=10)` | Connects to the stream **by name**. `resolve_streams()` took whichever stream answered first, which could be the wrong device. |
| `pull_sample(timeout=2.0)` and `if sample is None: print(...)` | Without a timeout the call waits forever, so the "No samples" message could never print. Now a stopped source says so within 2 s. |
| `CHANNEL = 7` | The same channel as before (the 8th, 0-based index 7), as a named setting. |
| **Status line once a second:** `sent 250 msgs/s to 127.0.0.1:8000, last …, range …` | It proves data is leaving Python. It costs **0.04 µs per message**: we measured about 70,000 msgs/s with and without it, and the stream only needs 250. |
| **Auto range:** every value also goes into a 10-second buffer (`recent = deque(maxlen=2500)`). Once a second the bridge computes the **5th and 95th percentile** of that buffer and sends `/eeg/range <low> <high>`. | This replaces retyping `scale` min/max. Percentiles rather than min/max mean one blink or cable bump doesn't stretch the range. The old device ignores this message, so it's backward compatible. Switch it off with `SEND_RANGE = False`. |

The main message is still `/eeg/processed <value>` on 127.0.0.1:8000, sent for every sample, exactly as before.

## 3. The Max device: `max/EEG-MIDI-Controls.amxd`

### Old vs new, object by object

```
POC (ch8VisualMIDI)                           NEW (EEG-MIDI-Controls)
udpreceive 8000                               udpreceive 8000                       (same)
route /eeg/processed                          route /eeg/processed /eeg/range       (+ range input)
unpack f                                      unpack f                              (same)
[number] → zl group 5 → [flonum]              speedlim [Note Every ms]              (tempo by TIME, not sample count)
                                              [flonum] raw display                  (see the value arriving)
scale 119000. 122000. 35 54                   scale …  ← In Low/In High or Auto Range, Note Low/High
                                              clip [Note Low..Note High]            (never outside the note range)
                                              i                                     (whole note numbers)
zl group 35                                   makenote [Velocity] [Length]          (note-on AND note-off)
noteout  ← live.dial velocity, [2] channel    noteout  ← [MIDI ch]
midiin → midiout                              midiin → midiout                      (same pass-through)
```

### The four new ideas in the patch

1. **Tempo from a clock, not a count.** `speedlim 700` lets at most one value through every 700 ms, whatever the sample rate. The **Note Every** dial goes to `speedlim`'s right inlet, which sets that time. `expr 1000./$f1` turns it into the notes/s display.
   - The POC's `zl group 5` → `zl group 35` meant one note per 175 samples, so tempo changed whenever the sample rate changed (CSV vs headset).
   - `zl group 35` also sent a 35-number list into `noteout`. Max reads a list there as pitch, velocity, channel, so your data was probably setting velocity, not the dial.
2. **Range switch (Auto Range).** Two gates feed the `scale` in-low/in-high inlets (inlets 2 and 3):
   - `gate 1 1` (opens when Auto is on) passes `/eeg/range lo hi` from Python;
   - `gate 1 0` (opens when Auto is off) passes the **In Low / In High** boxes through `pak`.

   The toggle goes through `t b i`. First it opens or closes the gates (`i`, and `== 0` for the opposite gate). Then it bangs `pak`, so turning Auto off restores your manual numbers at once.
3. **Note limits.** **Note Low / Note High** set both `scale`'s output range (inlets 4 and 5) and `clip`, so a spike can't play a note outside the range.
4. **Real notes.** `makenote` sends a note-on, and after **Length** ms the matching note-off. **Velocity** goes to its middle inlet and **MIDI ch** to `noteout`'s right inlet.

When the device loads, `live.thisdevice` → `t b b b b b b b b b` bangs every control once, so the patch starts with the values shown on the face.

All controls are `live.*` objects with *parameter* turned on. That makes them Live parameters: they're saved with the set, you can automate them, and you can map them with Ctrl+M.

### How the file was made

I didn't build it by clicking in Max. A Python script read your `ch8VisualMIDI.amxd`, kept its device settings, and wrote a new box list and connection list. It then wrote the `.amxd`, which is the patch JSON behind a small binary header that stores its length. The script checked that every connection points at a real inlet or outlet and that the length in the header is right. It was **not opened in Max or Live before you tried it**, so treat it as a first version. `.maxpat` is the same patch as plain JSON, so the diff is readable in review.

---

## Why you heard a single tone and couldn't change the knobs (most likely cause)

**While Auto Range is on, In Low / In High do nothing.** That's how I built it: the manual gate is closed. So when you turned those boxes in Live, nothing happened. And if `/eeg/range` isn't arriving, the scale keeps its default range of 119000–122000. Any signal outside that range clips to one note: 35 when the signal is below it, 54 when above. That's the single tone.

Check, in this order:
1. **Bridge terminal.** Does the status line end with `, range 119…..121…`?
   - **No range part:** it isn't sending. Is `SEND_RANGE = True` in `bridge3.py`, and are you running `bridge3.py`, not the old `bridge2.py`?
   - **Range numbers far from 119000–122000** (for example the live Unicorn in µV, around ±100): the default range is the problem. Turn Auto Range **off**, then set In Low / In High to the printed numbers.
2. **Device face.** Does the **raw** box move? Does the **note** box change? If the raw box moves but the note box stays at 35 or 54, it's the range.
3. **Knobs not responding at all in Live:** close the Max editor window first. While "Edit in Max" is open, the device face in Live may not respond. Then click the device and turn the dial, or double-click a number box and type a value.

**For the demo if there's no time to fix it:** use `max/ch8VisualMIDI.amxd` (the POC device, unchanged). Set its `scale` min/max to the `range` numbers `bridge3.py` prints, before the set starts.

**Fix for after the demo (v1.1, not built yet):** touching In Low / In High switches Auto Range off by itself. Add a `range` display on the face. Show "no range yet" until the first `/eeg/range` arrives.
