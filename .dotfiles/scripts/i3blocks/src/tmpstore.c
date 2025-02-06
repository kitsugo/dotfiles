// Copyright 2024 Jirou Hayashi <hayashi.jiro@kitsugo.com>
// Licensed under the terms of the GNU GPL v3, or any later version.
#define _GNU_SOURCE
#include <dirent.h>
#include <stdio.h>
#include <string.h>

/**
 * Notifies if a volatile directory has contents
 */
int main() {
	const char arr[3][64] = {"/tmp/music", "/tmp/firefox/downloads",
							 "/tmp/youtube-dl"};

	for (int i = 0; i < 3; i++) {
		DIR *dir_stream;
		struct dirent *dir;
		int count = 0;

		dir_stream = opendir(arr[i]);
		if (dir_stream) {
			while ((dir = readdir(dir_stream)) != NULL) {
				if (++count > 2)
					break;
			}
		}
		closedir(dir_stream);

		// Directory includes nodes besides "./" and "../"
		if (count > 2) {
			printf("%s\n", basename(arr[i]));
			return 0;
		}
	}
}
