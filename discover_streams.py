from pylsl import resolve_streams

print("Searching for LSL streams on the network (5-second timeout)...")

# 1. Resolve all streams on the network
streams = resolve_streams(5)

# 2. Check if any streams were found and print details
if not streams:
    print("\nNo LSL streams found. Make sure your device is broadcasting.")
else:
    print(f"\nSuccess! Found {len(streams)} stream(s):")
    # Loop through the found streams and print their info
    for i, stream in enumerate(streams):
        print(f"\n--- Stream #{i} ---")
        print(f"  Name: {stream.name()}")
        print(f"  Type: {stream.type()}")
        print(f"  Channels: {stream.channel_count()}")
        print(f"  Sampling Rate: {stream.nominal_srate()}")
        print(f"  Source ID: {stream.source_id()}")

print("\nDiscovery script finished.")