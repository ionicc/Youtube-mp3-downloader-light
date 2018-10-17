from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
import PyQt5.QtWebEngine

import ytd

class DownloadManager(QObject):
    @pyqtSlot(str, str, result=str)
    def downloadMP3(self, url, path):
        ytd.download(song=url, folder_path=path)
        return "Download successfull"

if __name__ == "__main__":
    import sys

    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()
    context = engine.rootContext()
    context.setContextProperty("main", engine)
    engine.load('ui/main.qml')

    downloadManager = DownloadManager()
    context.setContextProperty("downloadManager", downloadManager)

    engine.quit.connect(app.quit)
    sys.exit(app.exec_())