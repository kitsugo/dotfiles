#!/bin/sh
# Copyright 2024 Jirou Hayashi <hayashi.jirou@kitsugo.dev>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Wrapper script for 'pdflatex' to output LaTeX PDF and additional files into a /tmp/ directory
# This allows a clear separation of source and build files for most LaTeX projects

readonly out_dir_name="${PWD##*/}"
readonly out_dir="/tmp/$out_dir_name"
# Create an identical, but empty directory structure in the output directory
find . -type d -exec mkdir -p -- "$out_dir/"{} \;

# Check if bibtex files are present
bib_present=$(find "$PWD/" -type f -name "*.bib" | wc -l)
if [ ! "$bib_present" -eq 0 ]; then
	# Symlink bibtex related files
	ln -s "$PWD"/*.bib "$out_dir/"
	ln -s "$PWD"/*.bst "$out_dir/"
	# Build bibtex
	(
		cd "$out_dir" || exit 0
		for last_arg in "$@"; do :; done
		bibtex "${last_arg%%.*}"
	)
fi
pdflatex -output-directory="$out_dir" "$@"
printf "\n\nIMPORTANT: Some packages may require you to specify a different output directory!\nUse '/tmp/[PROJECT_DIR]' as that output directory\nExamples:\n* usepackage[outputdir=/tmp/[PROJECT_DIR]]{minted}\n"
