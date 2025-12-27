import mido 
import rtmidi

print(mido.get_input_names())

input_port_name = mido.get_input_names()[0]

try:
    with mido.open_input(input_port_name) as inport:
        print(f"Listening for MIDI messages on '{input_port_name}'...")
        for msg in inport:
            print(msg)

except KeyboardInterrupt:
    print("\nExiting MIDI listener.")