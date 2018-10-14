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


def download(song=None, folder_path=None):

    ytdl_options = {
        'format': 'bestaudio/best', # select quality
        'outtmpl': "{}/%(title)s.%(ext)s".format(os.path.normpath(folder_path)),
        'embed-thumbnail': True, # doesn't seem to work
        'no-warnings': True,
        'postprocessors': [{
                'key': 'FFmpegExtractAudio',
                'preferredcodec': 'mp3',
                'preferredquality': '192',
            }]
    }

    def ytdl_download(song_url):
        with YoutubeDL(ytdl_options) as ytdl:
            try:
                song_title = get_title(song)
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
        except:
            print("There's some problem in your network")
            return None

        ytdl_download(results[0])

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
        else:
            while True:
                download(folder_path=path)
    except KeyboardInterrupt:
        exit(1)


if __name__ == '__main__':
    main()
    exit(0)
