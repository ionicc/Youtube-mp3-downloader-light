# Youtube-Downloader-Light


**YTDL** is a wrapper around the [youtube_dl](https://github.com/rg3/youtube-dl) package to download **primarily audio** and video from Youtube easily :heart:


### Disclaimer

This project has been made for educational purposes using python language and does not support or encourage pirating activities.

---



## Contributors

Started as a fun project, **YTDL** is at it's current because of contributions from amazing people all over the world.

[![](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/images/0)](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/links/0)[![](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/images/1)](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/links/1)[![](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/images/2)](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/links/2)[![](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/images/3)](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/links/3)[![](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/images/4)](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/links/4)[![](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/images/5)](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/links/5)[![](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/images/6)](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/links/6)[![](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/images/7)](https://sourcerer.io/fame/ionicc/ionicc/Youtube-mp3-downloader-light/links/7)


## Installation

**1. Clone this repository**

```
   $ git clone https://github.com/ionicc/Youtube-mp3-downloader-light
   $ cd Youtube-mp3-downloader-light
```

**2. Setup**

### Linux and MacOS:

```bash
   $ make install
```

   or,

> To install for development:
> 
> ```bash
>    $ make install-dev
> ```

### Windows:

> If you use [make](http://gnuwin32.sourceforge.net/packages/make.htm), follow the steps above. <br/>
> Else, open an admin shell in the project folder, and execute:

```cmd
> .\install.bat
```

After the setup, you'll need to download [ffmpeg](https://ffmpeg.zeranoe.com/builds/) for your system.
Then:

- Unzip the archive to a specified directory. e.g.: ```C:\libs\ffmpeg```.
- Add ffmpeg to your `PATH`

```cmd
> setx path "%PATH%;C:\libs\ffmpeg\bin"
```

## Launch

```bash
   $ ./ytd.py    # launch in interactive mode
```

---

### Launch Options


### **GUI**
### 1. Install pyQt5

**With Conda:**
1. Create new conda environment:  `conda create -n my_new_env python=3.7`
2. Install pyqt:  `conda install -c defaults pyqt=5 qt`

#### With pip
`pip3 install pyqt5`

### 2. Run
1. Follow the steps above for Windows or Linux
2. Go to the folder then run: `python ui.py`

**To download the songs, follow these commands :-**

Supported flags are explained below:



| Command                                                                                                 | Function                                                                                           |
| ------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `ytd.py -o . --playlist PLAYLIST_LINK`                                                                    | Downloads the entire playlist in the cwd.                                                          |
| `ytd.py -o . --playlist PLAYLIST_LINK --playlist-start song_Number`                                       | Downloads the entire playlist in the cwd from the specified song serial number in the playlist.    |
| `ytd.py -o . --playlist PLAYLIST_LINK --playlist-end Song_Number`                                         | Downloads the playlist in the cwd and stops downloading when it reaches the mentioned song number. |
| `ytd.py -o . --playlist PLAYLIST_LINK --playlist-items  song_Number-1, Song_Number-2, ..., Song_Number-x` | Downloads the songs at the positions of the mentioned serial numbers.                              |
| `ytd.py -o . --playlist PLAYLIST_LINK --default`                                                          | Downloads the playlist at the default location, the Downloads folder initially.                    |
| `ytd.py -o . --playlist PLAYLIST_LINK --default /Folder_Name`                                              | Sets a new download location and downloads the playlist there.                                     |


#### You can use multiple arguments as well, for example, :-

| Command                                                                                                                | Function                                                                                                      |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `ytd.py -o . --playlist PLAYLIST_LINK --playlist-end Song_Number --playlist-start song_Number --default/Folder_Location` | Downloads the playlist from the start song number to the end song number at the newly assigned download path. |

#### **Argument Explanation :-**

1. `-o or --output`:-  Define the output location for the current session.

2. `--video or -v` :- Downloads the video.

3. `--playlist` :- Playlist URL.

4. `--playlist-start or -ps` : Define the starting point of the playlist.

5. `--playlist-end or -pe` :- Define the end point of the playlist.

6. `--playlist-items or -pi` :- This command downloads the songs at the mentioned serial numbers.

7. `--default` :- Define the default download location.
