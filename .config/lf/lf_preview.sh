#!/usr/bin/env bash
file=$1
w=$2
h=$3
x=$4
y=$5

readonly size_limit=50000000
file_size=$(wc -c <"$file")
readonly file_size

if [ "$file_size" -ge "$size_limit" ]; then
	printf "File too large for preview!"
	exit 0
fi

case "${file,,}" in
*.pdf) pdftotext -f 1 -l 3 "$file" - ;;
*.gif) ;&
*.jpg) ;&
*.jpeg) ;&
*.webp) ;&
*.avif) ;&
*.png)
	escaped_file=${file// /\\ }
	readonly escaped_file
	file_name=$(basename "${escaped_file}")
	readonly file_name
	readonly image_location="/tmp/.thumbnails/$file_name.webp"

	if [ ! -f "$image_location" ] && [ "$(dirname "$file")" != "/tmp/.thumbnails" ]; then
		convert "${file}[0]" -resize 300 "$image_location"
	fi

	if [ -f "$image_location" ]; then
		(identify -ping -format "%wx%h" "$file") || echo "No info"
		kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y+2}" "$image_location" </dev/null >/dev/tty
		exit 1
	fi

	printf "Cannot display image."
	;;
*.svg)
	sleep 0.8
	kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" </dev/null >/dev/tty
	exit 1
	;;
*.mp3)
	sleep 0.8
	escaped_file=${file// /\\ }
	readonly escaped_file
	file_name=$(basename "${escaped_file}")
	readonly file_name
	readonly image_location="/tmp/.thumbnails/$file_name.jpg"

	if [ ! -f "$image_location" ]; then
		ffmpeg -i "$file" -an -filter:v scale=300:300 "$image_location"
	fi

	if [ -f "$image_location" ]; then
		eyeD3 "$file"
		kitty +kitten icat --silent --stdin no --transfer-mode file --align right --place "${w}x${h}@${w}x0" "$image_location" </dev/null >/dev/tty
		exit 1
	fi

	eyeD3 "$file"
	exit 0
	;;
*.txt)
	cat "$file"
	;;
*)
	if [[ "$(file -Lb --mime-type "$file")" =~ ^text ]]; then
		cat "$file"
	else
		cat "$HOME/.dotfiles/extra/ascii/no_preview.txt"
	fi
	;;
esac

exit 0
