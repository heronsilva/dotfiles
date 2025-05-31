# ls list files only
ls -lAh | grep -v '^d'

# ls directories only
ls -lAh | grep '^d'

# Download Best MP4 (Video+Audio) for MacOS / WhatsApp
/opt/homebrew/bin/yt-dlp -f "bestvideo[vcodec^=avc1]+bestaudio[acodec^=mp4a]/best[ext=mp4]" \
	--merge-output-format mp4 \
	-o "%(title).50s.%(ext)s" \
	"VIDEO_URL"

# Download Audio Only
/opt/homebrew/bin/yt-dlp -f "bestaudio" -x --audio-format mp3 \
	-o "%(title).50s.%(ext)s" \
	"VIDEO_URL"

# Download Video Only (no audio)
yt-dlp -f "bestvideo[vcodec^=avc1]" \
	-o "%(title).50s.%(ext)s" \
	"VIDEO_URL"

	# If that fails, fallback to:
	yt-dlp -f bestvideo --merge-output-format mp4 -o "%(title).50s.%(ext)s" "VIDEO_URL"

# Remove Audio from a Video (with ffmpeg)
ffmpeg -i "input.mp4" -an -c:v copy "no-audio.mp4"

# Convert Video to WhatsApp-Compatible MP4
ffmpeg -i "input.mp4" \
	-c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p \
	-c:a aac -b:a 128k -movflags +faststart \
	"whatsapp_ready.mp4"

# Shrink Video for WhatsApp (mobile-friendly)
ffmpeg -i "input.mp4" \
	-vf "scale=iw*min(640/iw\,480/ih):ih*min(640/iw\,480/ih)" \
	-c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p \
	-c:a aac -b:a 96k -crf 28 -movflags +faststart \
	"whatsapp_small.mp4"

# Check File Codec (video & audio)
ffprobe -v error -show_entries stream=index,codec_type,codec_name \
	-of default=noprint_wrappers=1 \
	"yourfile.mp4"
# list node_modules directories (recursively)
find . -name 'node_modules' -type d -prune



# remove node_modules directories (recursively)
find . -name 'node_modules' -type d -prune -exec trash '{}' +



