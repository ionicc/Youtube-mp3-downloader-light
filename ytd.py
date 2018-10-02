import re, urllib, os, sys
import urllib.request
import urllib.parse

user_input = input
encode = urllib.parse.urlencode
retrieve = urllib.request.urlretrieve
cleanup = urllib.request.urlcleanup()
urlopen = urllib.request.urlopen

def get_title(url):
    website = urlopen(url).read()
    title = str(website).split('<title>')[1].split('</title>')[0]
    return title

def init_message():
    print("Enter the name of the song or the URL (^^):")

def download(song=None):
    if not song:
        song = user_input('Enter the name of the song or the URL')

    if "youtube.com/" not in song:

        try:
            query = encode({"search_query" : song})
            web_content = urlopen("http://www.youtube.com/results?" + query)
            results = re.findall(r'href=\"\/watch\?v=(.{11})', web_content.read().decode())
        except:
            print("There's some problem in your network")
            return none

        command = 'youtube-dl --embed-thumbnail --no-warnings --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" ' + search_results[0]
