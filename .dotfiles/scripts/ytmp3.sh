#!/bin/sh
# Helper script for youtube-dl / yt-dlp to download as mp3
# ytmp3.sh [URL]
# ytmp3.sh [URL] [PLAYLIST_NAME] [PLAYLIST_START]
url="$1"
playlist_name="$2"
playlist_start="$3"

if [ -n "$playlist_start" ] && [ -n "$playlist_name" ]; then
	playlist_location="/tmp/music/$playlist_name/%(playlist_index)s - %(title)s.%(ext)s"
	set -- -x --audio-format mp3 --prefer-ffmpeg --no-mtime --playlist-start "$playlist_start" -o "$playlist_location" "$url"
	yt-dlp -x "$@" || youtube-dl "$@"
else
	set -- -x --audio-format mp3 --prefer-ffmpeg --no-mtime -o "/tmp/music/%(title)s.%(ext)s" "$url"
	yt-dlp "$@" || youtube-dl "$@"
fi
