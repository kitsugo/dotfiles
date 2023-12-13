#!/usr/bin/env bash
file=$1
w=$2
h=$3
x=$4
y=$5

case "${file,,}" in
*.pdf) pdftotext -f 1 -l 3 "$file" - ;;
*.gif) ;&
*.jpg) ;&
*.jpeg) ;&
*.png)
	(identify -ping -format "%wx%h" "$file") || echo "No info"
	kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y+2}" "$file" </dev/null >/dev/tty
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

exit 1
