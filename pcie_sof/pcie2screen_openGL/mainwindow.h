#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtWidgets>
#include "set_capture.h"
#include "OpenGL.h"

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public Q_SLOTS:
    void startCapture(void);
    void changeWindows(int);
    void timeDelay();
    void flushFps(int speed);

private slots:
    void on_btn_save_clicked();

    void on_btn_other_clicked();

    void on_comboBox_currentIndexChanged(int index);

    void on_comboBox_video_source_currentIndexChanged(int index);



private:
    Ui::MainWindow *ui;

    xdma_getImg *pXdmaGetImg;
    QLabel *pPlayState;
    QTimer *pTimer;
    bool isPressed;
    bool isRelease;
    QString titleName;

};

#endif // MAINWINDOW_H
