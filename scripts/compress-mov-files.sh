#!/bin/zsh

# Directory to process (default: current directory)
DIR=${1:-.}

# Loop over all .mov files in the directory
for f in "$DIR"/*.mov; do
    [ -e "$f" ] || continue  # skip if no .mov files

    # Output file name
    out="${f:r}-min.mp4"   # save as .mp4 (more efficient codec)

    echo "Compressing: $f -> $out"

    # ffmpeg command:
    # -c:v libx264 : use H.264 video codec
    # -crf 28      : quality factor (lower = better quality, bigger file; higher = worse quality, smaller file)
    # -preset fast : speed vs compression trade-off
    # -c:a aac     : use AAC audio codec
    ffmpeg -i "$f" -c:v libx264 -crf 28 -preset fast -c:a aac -b:a 128k "$out"
done

echo "Done!"

