# Max patch: taking the manual work out

## What the current device does (ch8VisualMIDI, read from the file)

```
udpreceive 8000 → route /eeg/processed → unpack f → [number] → zl group 5 → [flonum]
→ scale 119000. 122000. 35 54 → [flonum] → zl group 35 → noteout
live.dial → [number] → noteout velocity      [2] → noteout channel
```

- **Tempo is counted in samples, not time.** `zl group 5` and the number box keep 1 sample in 5, and `zl group 35` makes one output per 35 of those. So you get one note every 175 samples:
  - 1.4 notes/s when the stream really runs at 250 Hz;
  - slower when it doesn't. The old `stream.py` used a plain `sleep`, and on a busy machine we measured 35 Hz instead of 250. Notes then came out 7× slower, and the CSV and the live headset felt different.
- **`zl group 35` sends a 35-number list into noteout's left inlet.** Max reads a list there as *pitch velocity channel*, so the 2nd and 3rd numbers of your data may be overriding the velocity dial and the `2`. This is worth checking in the Max console; if it's true, it explains odd velocities.
- **No note-offs.** Notes end only if the instrument's sound ends by itself.
- **The scale range is fixed.** The raw value of channel 7 drifts (around 119,000–122,000 in your file). That's why In Low/In High needed retuning in every session.

## The new device: max/EEG-MIDI-Controls.amxd

It's the same idea with the controls on the device face, all of them Live parameters (MIDI-mappable, automatable, saved with the set):

```
udpreceive 8000 → route /eeg/processed /eeg/range
  /eeg/processed → unpack f → speedlim [Note Every ms] → (raw display) → scale → clip [Note Low..High] → i → makenote [Velocity, Length] → noteout [Channel]
  /eeg/range lo hi → gate (open while Auto Range is on) → scale in-low / in-high
  In Low / In High → pak → gate (open while Auto Range is off) → scale in-low / in-high
  live.thisdevice → sends every control's value once at load
```

| Manual job before | Now |
|---|---|
| Open the patch and retype `scale` min/max | **Auto Range** on: `bridge2.py` sends the 5th–95th percentile of the last 10 s once a second. Off: two **In Low / In High** boxes on the device face. |
| Edit `zl group 35` to change tempo | The **Note Every** dial, in ms, with notes/s shown under it. It's time-based, so it doesn't change when the sample rate does. |
| Velocity dial wired to a number | **Velocity** dial; it now really sets the velocity. |
| (none) | **Length** dial; `makenote` sends note-offs. |
| `2` message for the channel | **MIDI ch** box. |
| (none) | **Note Low / Note High**, plus a clip, so a spike can't play note 3 or note 120. |

**How it was made:** I generated the patch by script from your device file. A check confirmed that every connection points at a real inlet or outlet and that the device's header length is correct. **I could not open it in Max or Live here, so test it tonight:**
1. Drop it on a MIDI track before an instrument.
2. Run `stream.py` and `bridge2.py`.
3. Check that the raw box moves, the note box changes, Auto Range follows, and Note Every changes the tempo.

If anything is off, use `max/ch8VisualMIDI.amxd` (unchanged) for the demo. It still works with the new `bridge2.py`, because it ignores `/eeg/range`.

**If the device opens with no controls on its face:** the patch uses Presentation mode. Open it in the Max editor and press Cmd/Ctrl+Alt+E to toggle the view.

## If you'd rather change your own patch by hand (about 10 minutes)

1. **Scale min/max from the outside.** `scale` has six inlets: value, in-low, in-high, out-low, out-high, curve. Put a `live.numbox` into each of inlets 2–5 and delete the numbers from the `scale` box's text. In each numbox's Inspector:
   - turn on *Parameter Visibility: Automated and Stored*;
   - set the range (for example 0–1,000,000 for the input, 0–127 for notes);
   - set *Initial Value* and enable it.
2. **Group size on a dial.** Feed a `live.dial` (type Int, range 1–200) into the **right** inlet of `zl group`: an int there sets the group size. (A time-based `speedlim` is steadier; see above.)
3. **Show them on the device.** Select each control, choose *Add to Presentation* (right-click), then turn on *Open in Presentation* in the patcher's Inspector. Arrange the controls within the 169 px device height.
4. **Map to your knob.** In Live, press Ctrl+M (Cmd+M on Mac), click the dial, turn the knob, then press Ctrl+M again. This is the "would like to make this a dial I can control using my MIDI knob" note in the patch.
5. **Auto range inside Max instead of Python** (only if you don't want it in the bridge): route `/eeg/range` with `route /eeg/processed /eeg/range`, then `unpack f f` into scale inlets 2 and 3.

## Tips for the jam

- Turn **Length** up past **Note Every** for overlapping, pad-like notes; down for plucks.
- Put Live's own **Scale** MIDI effect after this device to keep every note in key. **Arpeggiator** and **Random** after it work well too.
- Changing **Note Low/High** while playing moves the register; a narrow range (5–7 notes) sounds most musical.
