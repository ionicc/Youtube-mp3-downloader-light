# Youtube-Downloader-Light

**YTDL is a python script to download songs from Youtube :heart: , It has been written in under 70 lines of code! :triumph:**

### Disclaimer

This project has been made for educational purposes using python language and does not support or encourage pirating activities.

## Usage

### Linux and MacOS:

1. Get the youtube-dl package

   ```
   $ sudo apt-get install youtube-dl
   ```

2. Clone and extract the repository

3. Run the ytd.py file

   ```
   ./ytd.py
   ```

### Windows:

1. Clone this Repository.

2. Set the folder as an environment path variable.

3. Make a folder in the location you want to download the songs in.

4. Open PowerShell in that location.

   1. Click on the path of the folder.
   2. Type in **`ytd.py -o --playlist PLAYLIST_LINK`** to download the entire playlist.

5. **To download individual songs**

   1. Open CMD at the Repository's location.
      1. Type **`python ydl.py`**  - This will run the script.
   2. Paste the link of the song. It will download it. 

**To download the songs, follow these commands :-**

| Command                                                                                                 | Function                                                                                           |
| ------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `ytd.py -o --playlist PLAYLIST_LINK`                                                                    | Downloads the entire playlist in the cwd.                                                          |
| `ytd.py -o --playlist PLAYLIST_LINK --playlist-start song_Number`                                       | Downloads the entire playlist in the cwd from the specified song serial number in the playlist.    |
| `ytd.py -o --playlist PLAYLIST_LINK --playlist-end Song_Number`                                         | Downloads the playlist in the cwd and stops downloading when it reaches the mentioned song number. |
| `ytd.py -o --playlist PLAYLIST_LINK --playlist-items  song_Number-1, Song_Number-2, ..., Song_Number-x` | Downloads the songs at the positions of the mentioned serial numbers.                              |
| `ytd.py -o --playlist PLAYLIST_LINK --default`                                                          | Downloads the playlist at the default location, the Downloads folder initially.                    |
| `ytd.py -o --playlist PLAYLIST_LINK --default/Folder_Name`                                              | Sets a new download location and downloads the playlist there.                                     |

#### You can use multiple arguments as well, for example, :-

| Command                                                                                                                | Function                                                                                                      |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `ytd.py -o --playlist PLAYLIST_LINK --playlist-end Song_Number --playlist-start song_Number --default/Folder_Location` | Downloads the playlist from the start song number to the end song number at the newly assigned download path. |

#### **Argument Explanation :-**

1. ytd.py :- The name of the python script. It is used to call the script in PowerShell.

2. -o :- prints the output for the iteration of the current shell.

3. PLAYLIST_LINK :- It is the link to the playlist you want to download.

4. --playlist-start :- It defines the starting point of the playlist.

5. --ps :- Shortform for --playlist-start.

6. --playlist-end :- It defines the end point of the playlist.

7. --pe :- Shortform for --playlist-end.

8. --playlist-items no1,no2,no3 :- This command downloads the songs at the mentioned serial numbers.

9. --pi :- Shortform for --playlist-items.

10. --default :- Downloads at the default download location. Usually the **downloads** folder.

11. --default/Folder_Location :- Changes the default download path. Downloads at that path if a playlist is queued.

#### Errors :-

**For Windows :-**

If you encounter Couldn't find FF Probe or AV Probe error, try to download [FFmpeg](https://ffmpeg.zeranoe.com/builds/). Traverse to the file location and open the **bin** folder and set that location as an environment path. That should solve the issue.
