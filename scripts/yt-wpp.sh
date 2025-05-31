#!/bin/bash

set -e

show_help() {
  echo "Usage: yt-whatsapp [-o output_name] <video_url>"
  echo
  echo "Downloads a video using yt-dlp and converts it to WhatsApp-compatible format."
  echo
  echo "Options:"
  echo "  -o <name>   Optional output file name (without extension)"
  echo "  -h          Show this help message"
  echo
  echo "Examples:"
  echo "  yt-whatsapp https://www.facebook.com/watch?v=123456789"
  echo "  yt-whatsapp -o my_video https://www.facebook.com/watch?v=123456789"
}

# --- Parse flags ---
OUTPUT_NAME=""
while getopts ":ho:" opt; do
  case ${opt} in
    h )
      show_help
      exit 0
      ;;
    o )
      OUTPUT_NAME="$OPTARG"
      ;;
    \? )
      echo "Invalid option: -$OPTARG" >&2
      show_help
      exit 1
      ;;
    : )
      echo "Option -$OPTARG requires an argument." >&2
      show_help
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

VIDEO_URL="$1"

if [ -z "$VIDEO_URL" ]; then
  echo "❌ Error: No video URL provided."
  show_help
  exit 1
fi

# --- Prepare destination ---
DEST_DIR="$HOME/Downloads/videos"
mkdir -p "$DEST_DIR"

TMP_FILE="$DEST_DIR/downloaded_tmp.mp4"
MAX_TITLE_LENGTH=50

# --- Download video with yt-dlp ---
echo "📥 Downloading video..."
yt-dlp -f "bestvideo[vcodec^=avc1]+bestaudio[acodec^=mp4a]/best[ext=mp4]" \
  --merge-output-format mp4 \
  --progress --no-warnings \
  --restrict-filenames \
  -o "$TMP_FILE" \
  "$VIDEO_URL"

# --- Get title if not set manually ---
if [ -z "$OUTPUT_NAME" ]; then
  VIDEO_TITLE=$(yt-dlp --get-title "$VIDEO_URL" | head -n 1)
  OUTPUT_NAME=$(echo "$VIDEO_TITLE" | cut -c1-"$MAX_TITLE_LENGTH" | tr -cd '[:alnum:]_-')
fi

OUTPUT_FILE="$DEST_DIR/${OUTPUT_NAME}.mp4"

# --- Convert to WhatsApp-compatible format ---
echo "🎞️ Converting to WhatsApp-compatible format..."
ffmpeg -y -i "$TMP_FILE" \
  -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p \
  -c:a aac -b:a 128k -movflags +faststart \
  -loglevel info -stats \
  "$OUTPUT_FILE"

# --- Cleanup ---
rm -f "$TMP_FILE"

echo "✅ Done! Saved as: $OUTPUT_FILE"

##

# you might want to:
# mv yt-whatsapp /usr/local/bin/

