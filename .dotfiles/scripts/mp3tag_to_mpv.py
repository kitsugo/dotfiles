#!/usr/bin/env python3
# Copyright 2024 Jirou Hayashi <hayashi.jirou@kitsugo.dev>
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# Custom music database to playlist implementation
# Reads in a list of files and their mp3tags. Allows calling SQL statements to produce a playlist.txt file for mpv to use

import os
import sys
import sqlite3
from tinytag import TinyTag

# CONFIG
location = os.getenv("U_MUSIC_LOCATION", "~/Music/")
db_file = os.getenv("HOME") + "/.local/share/music_db.sqlite"


# SQL
def db_init(cursor):
    cursor.execute("""
            CREATE TABLE mp3(
                filePath CHAR VARYING(400),
                title CHAR VARYING(400),
                artist CHAR VARYING(400),
                album CHAR VARYING(400),
                PRIMARY KEY (filePath)
            );""")

    cursor.execute("""
            CREATE TABLE genre (
                genreName CHAR VARYING(400),
                PRIMARY KEY (genreName)
            );""")

    cursor.execute("""
            CREATE TABLE mp3Genres (
                filePath CHAR VARYING(400) NOT NULL,
                genreName CHAR VARYING(400) NOT NULL,
                PRIMARY KEY (filePath, genreName),
                FOREIGN KEY (filePath) REFERENCES mp3 (filePath),
                FOREIGN KEY (genreName) REFERENCES genre (genreName)
            );""")


def db_insert_replace(cursor):
    mp3_data = []
    genre_data = []
    mp3Genres_data = []
    for subdir, dirs, files in os.walk(location):
        for file in files:
            if file.endswith(".mp3"):
                absolute_path = os.path.join(subdir, file)
                tag = TinyTag.get(absolute_path)

                # Process file
                mp3_data.append(
                    (absolute_path, tag.title, tag.artist, tag.album))

                # Process genres
                if tag.genre is not None:
                    genres = tag.genre.split(";")
                    for genre in genres:
                        genre_data.append((genre,))
                        mp3Genres_data.append((absolute_path, genre))

    cur.executemany("INSERT OR REPLACE INTO mp3 VALUES(?, ?, ?, ?)", mp3_data)
    cur.executemany(
        "INSERT OR IGNORE INTO genre VALUES(?)", genre_data)
    cur.executemany(
        "INSERT OR REPLACE INTO mp3Genres VALUES(?, ?)", mp3Genres_data)


def db_fetch(cursor, sql):
    res = cursor.execute(
        "SELECT m.filePath FROM mp3 AS m LEFT JOIN mp3Genres AS g ON m.filePath = g.filePath WHERE " + sql).fetchall()
    playlist_file = open("/tmp/playlist.txt", "w")
    for row in res:
        playlist_file.write(row[0] + "\n")
    playlist_file.close()


def db_list(cursor, target):
    res = cursor.execute(
        "SELECT DISTINCT " + target + " FROM mp3 AS m LEFT JOIN mp3Genres")
    for row in res:
        print(row[0])


if __name__ == "__main__":
    args = " ".join(sys.argv[1:])
    con = sqlite3.connect(db_file)
    cur = con.cursor()

    if args == "init":
        db_init(cur)
    elif args == "insert":
        db_insert_replace(cur)
        con.commit()
    elif args == "artist" or args == "album" or args == "genreName":
        db_list(cur, args)
    else:
        db_fetch(cur, args)

    con.close()
