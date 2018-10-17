from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
import PyQt5.QtWebEngine

 
if __name__ == "__main__":
    import sys

    # Create an instance of the application
    app = QGuiApplication(sys.argv)

    # Create QML engine
    engine = QQmlApplicationEngine()
    # Create a calculator object

    # Load the qml file into the engine
    engine.load("ui/main.qml")

    engine.quit.connect(app.quit)
    sys.exit(app.exec_())