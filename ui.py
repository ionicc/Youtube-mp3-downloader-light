from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
import PyQt5.QtWebEngine
import threading as tr

import ytd

def do_download(args):
            ytd.download(song=args['url'], folder_path=args['path'])

class DownloadManager(QObject):
    @pyqtSlot(str, str, result=int)
    def downloadMP3(self, url, path):
        args = {'url': url, 'path': path}

        t = tr.Thread(target=do_download, args=(args,))
        t.start()

        return 0

if __name__ == "__main__":
    import sys

    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()
    context = engine.rootContext()
    context.setContextProperty("main", engine)
    engine.load('ui/qml/main.qml')

    downloadManager = DownloadManager()
    context.setContextProperty("downloadManager", downloadManager)

    engine.quit.connect(app.quit)
    sys.exit(app.exec_())