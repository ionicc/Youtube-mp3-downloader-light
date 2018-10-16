#!/usr/bin/env python3

import re, urllib, os, sys
import urllib.request
import urllib.parse
import argparse
import os, json
from youtube_dl import YoutubeDL

user_input = input
encode = urllib.parse.urlencode
retrieve = urllib.request.urlretrieve
cleanup = urllib.request.urlcleanup()
urlopen = urllib.request.urlopen
config_file_path = "config.json" # using a JSON file for simplicity, but it can
                                 # easly changed to an .ini file

def config_settings(new_path=None):
    # create a new config file
    if new_path:
        with open(config_file_path, "w") as config_file:
            json.dump({"default": new_path}, config_file)
            print("\033[93mDefault path changed to", new_path + "\033[0m") # remove ANSI escape to remove warning color
            return new_path
    elif os.path.isfile(config_file_path):
        with open(config_file_path, "r") as config_file:
            json_config = json.load(config_file)
            if "default" in json_config:
                return json_config["default"]

def check_args(args=None, default=None):
    parser = argparse.ArgumentParser(description="YOUTUBE MP3 DOWNLOADER LIGHT")
    parser.add_argument('--output', '-o',
                        metavar='PATH',
                        default=default or 'downloads/',
                        help="Path to write downloads to")
    parser.add_argument('--default', '-d',
                        help="Set default download directory")
    parser.add_argument('--video', '-v',
                        help="Directly download video, without further CLI interactions")
    parser.add_argument('--playlist', '-p',
                        help="Donwload an entire playlist")
    parser.add_argument('--playlist-items', '-pi',
                        help="Select items on a list to download (index starts at 1), e.g. -pi '1,2,4'")
    parser.add_argument('--playlist-start', '-ps',
                        default=1,
                        help="Select strating item on a playlist (index starts at 1)")
    parser.add_argument('--playlist-end', '-pe',
                        help="Select ending itam on a playlist (index starts at 1)")
    return parser.parse_args(args)


def get_title(url):
    website = urlopen(url).read()
    title = str(website).split('<title>')[1].split('</title>')[0]
    return title

def screen_clear():
    if os.name == 'nt':
        os.system('cls')
    else:
        os.system('clear')

def init_message():
    print("Built with <3 By Sagar Vakkala (^^) \n")
    print("YOUTUBE MP3 DOWNLOADER LIGHT \n \n")

def exit_message(t):
    print("\n %s Has been downloaded" % t)


def download(song=None, folder_path=None, playlist=False, playlist_items=None, playlist_start=1, playlist_end=None):

    ytdl_options = {
        'format': 'bestaudio/best', # select quality
        'outtmpl': "{}/%(title)s.%(ext)s".format(os.path.normpath(folder_path)),
        'no_warnings': True,
        'noplaylist': not playlist,
        'playlist_items': playlist_items, # str type if used (e.g '1,2,4'), otherwise None value
        'playliststart': playlist_start, # int type if used, otherwise 1 to start from the beginning
        'playlistend': playlist_end, # int type if used, otherwise None value
        'postprocessors': [{
                'key': 'FFmpegExtractAudio',
                'preferredcodec': 'mp3',
                'preferredquality': '192',
            }]
    }

    def ytdl_download(song_url):
        with YoutubeDL(ytdl_options) as ytdl:
            try:
                song_title = get_title(song_url)
                print("Downloading %s" % song_title)
                ytdl.download([song_url])
                exit_message(song_title)
            except:
                print('Error downloading %s' %song_title)
                return None

    if not song:
        song = user_input('Enter the name of the song or the URL: ')

    if "youtube.com/" not in song:

        try:
            query = encode({"search_query" : song})
            web_content = urlopen("http://www.youtube.com/results?" + query)
            results = re.findall(r'href=\"\/watch\?v=(.{11})', web_content.read().decode())
            video_id  = results[0]
            video_url = "https://youtube.com/watch?v=" + video_id
        except:
            print("There's some problem in your network")
            return None

        ytdl_download(video_url)

    else:
        ytdl_download(song)

def main():
    screen_clear()
    init_message()

    default_path = check_args(sys.argv[1:]).default
    config_default = config_settings(new_path=default_path)
    path = check_args(sys.argv[1:], default=config_default).output
    try:
        if check_args(sys.argv[1:]).video:
            download(song=check_args(sys.argv[1:]).video, folder_path=path)
        elif check_args(sys.argv[1:]).playlist:

            #check if --playlist_items format is correct
            if check_args(sys.argv[1:]).playlist_items:
                try:
                    # the following assignment is only to check the format, after that we can turn back to a str value.
                    playlist_items = [int(item) for item in check_args(sys.argv[1:]).playlist_items.split(',')]
                    playlist_items = check_args(sys.argv[1:]).playlist_items
                except ValueError:
                    print("ValueError: --playlist-items must be integers and divided by commas, e.g. -pi '1,2,4'")
            else:
                playlist_items = None
            
            # check if --playlist-start can be converted into an integer, otherwise 1 is assigned
            if check_args(sys.argv[1:]).playlist_start:
                try:
                    playlist_start = int(check_args(sys.argv[1:]).playlist_start)
                except ValueError:
                    print('ValueError: --playlist-start must an integer')
            else:
                playlist_start = 1

            # check if --playlist-start can be converted into an integer, otherwise None value is assigned
            if check_args(sys.argv[1:]).playlist_end:
                try:
                    playlist_end = int(check_args(sys.argv[1:]).playlist_end)
                except ValueError:
                    print('ValueError: --playlist-end must be an integer')
            else:
                playlist_end = None

            print(playlist_items, playlist_start, playlist_end, sep='----\n', end='----\n')
            download(song=check_args(sys.argv[1:]).playlist, folder_path=path, playlist=True,
                    playlist_items=playlist_items, playlist_start=playlist_start, playlist_end=playlist_end)
        else:
            while True:
                download(folder_path=path)
    except KeyboardInterrupt:
        exit(1)


if __name__ == '__main__':
    main()
    exit(0)
