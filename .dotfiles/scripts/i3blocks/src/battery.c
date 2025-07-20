// Copyright 2025 Jirou Hayashi <hayashi.jiro@kitsugo.com>
// Licensed under the terms of the GNU GPL v3, or any later version.
#define _GNU_SOURCE
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_FILE_SIZE 32

// int read_bat_file(char *file_path, char *content) {
// 	FILE *file = fopen(file_path, "r");
// 	if (file == NULL) {
// 		perror("Error opening status file");
// 		return EXIT_FAILURE;
// 	}
// 	char file_content[MAX_FILE_SIZE] = {0};
// 	size_t bytes_read = fread(content, 1, MAX_FILE_SIZE - 1, file);
// 	content[bytes_read] = '\0';
// 	fclose(file);
// 	content = file_content;
// 	return EXIT_SUCCESS;
// }

int main() {
	// Battery status
	FILE *f_status = fopen("/sys/class/power_supply/BAT0/status", "r");
	if (f_status == NULL) {
		perror("Error opening status file");
		return EXIT_FAILURE;
	}
	char status[MAX_FILE_SIZE] = {0};
	size_t bytes_read_status = fread(status, 1, MAX_FILE_SIZE - 1, f_status);
	status[bytes_read_status] = '\0';
	fclose(f_status);

	// Battery capacity in percent
	FILE *f_percent = fopen("/sys/class/power_supply/BAT0/capacity", "r");
	if (f_percent == NULL) {
		perror("Error opening capacity file");
		return EXIT_FAILURE;
	}
	char raw_percent[MAX_FILE_SIZE] = {0};
	size_t bytes_read_percent = fread(raw_percent, 1, MAX_FILE_SIZE - 1, f_percent);
	if (bytes_read_percent == 0 && ferror(f_percent)) {
		perror("Error reading capacity file");
		fclose(f_percent);
		return EXIT_FAILURE;
	}
	raw_percent[bytes_read_percent] = '\0';
	fclose(f_percent);

	int percent = atoi(raw_percent);
	char icon[8];

	if (strstr(status, "Discharging") != NULL) {
		if (percent < 10) {
			sprintf(icon, "󰁺");
		} else if (percent < 20) {
			sprintf(icon, "󰁻");
		} else if (percent < 30) {
			sprintf(icon, "󰁼");
		} else if (percent < 40) {
			sprintf(icon, "󰁽");
		} else if (percent < 50) {
			sprintf(icon, "󰁾");
		} else if (percent < 60) {
			sprintf(icon, "󰁿");
		} else if (percent < 70) {
			sprintf(icon, "󰂀");
		} else if (percent < 80) {
			sprintf(icon, "󰂁");
		} else if (percent < 90) {
			sprintf(icon, "󰂂");
		} else if (percent <= 100) {
			sprintf(icon, "󰁹");
		}
	} else if (strstr(status, "Charging") != NULL) {
		sprintf(icon, "󰚥");
	} else {
		sprintf(icon, "?");
	}

	printf(" %s %d%%\n", icon, percent);
	printf("\n");

	if (strstr(status, "Discharging")) {
		if (percent < 20) {
			char *color_crit = getenv("color3");
			if (color_crit != NULL) {
				printf("%s\n", color_crit);
			}
		} else if (percent < 30) {
			char *color_warn = getenv("color2");
			if (color_warn != NULL) {
				printf("%s\n", color_warn);
			}
		} else {
			char *color_norm = getenv("color");
			if (color_norm != NULL) {
				printf("%s\n", color_norm);
			}
		}
	}

	return 0;
}
