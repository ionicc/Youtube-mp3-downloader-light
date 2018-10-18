from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
import PyQt5.QtWebEngine
import threading as tr

import ytd

def do_download(args):
            ytd.download(song=args['url'],
                         folder_path=args['path'],
                         playlist=args['playlist'],
                         playlist_items=args['playlist_items'],
                         playlist_start=args['playlist_start'],
                         playlist_end=args['playlist_end'])

class DownloadManager(QObject):
    @pyqtSlot(str, str, result=int)
    def downloadSingleVideo(self, url, path):
        args = {
            'url': url,
            'path': path,
            'playlist': False,
            'playlist_items': None,
            'playlist_start': None,
            'playlist_end': None
        }

        t = tr.Thread(target=do_download, args=(args,))
        t.start()

        return 0

    @pyqtSlot(str, str, list, int, int, result=int)
    def downloadPlaylist(self, url, path, playlist_items, playlist_start, playlist_end):
        args = {
            'url': url,
            'path': path,
            'playlist': True,
            'playlist_items': playlist_items,
            'playlist_start': playlist_start,
            'playlist_end': playlist_end
        }

        t = tr.Thread(target=do_download, args=(args,))
        t.start()

        return 0

class ConfigurationManager(QObject):
    @pyqtSlot(result=str)
    def getDefaultPath(self):
        return ytd.config_settings()

    @pyqtSlot(str)
    def setDefaultPath(self, path):
        return ytd.config_settings(new_path=path)

if __name__ == "__main__":
    import sys

    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()
    context = engine.rootContext()
    context.setContextProperty("main", engine)
    engine.load('ui/qml/main.qml')

    downloadManager = DownloadManager()
    context.setContextProperty("downloadManager", downloadManager)

    configurationManager = ConfigurationManager()
    context.setContextProperty("configurationManager", configurationManager)

    engine.quit.connect(app.quit)
    sys.exit(app.exec_())