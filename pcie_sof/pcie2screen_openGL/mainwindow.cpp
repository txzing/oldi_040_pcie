#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "xdma_programe.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    titleName = "丰柯电子(FIGKEY) PCIE采集卡上位机（made by TX）";
    setWindowTitle(titleName);

    pPlayState = new QLabel(this);
    pPlayState->setStyleSheet("QLabel{"
                              "background-color:rgba(0, 0, 0, 160);"
                              "border-style: outset;"
                              "border-width: 2px;"
                              "border-radius: 5px;"
                              "border-color: #8B7355;"
                              "font: bold 28px;"
                              "min-width:200px;max-width:200px;"
                              "min-height:40px;max-height:40px;"
                              "color:white;"
                              "font-family:华文新魏;"
                              "}");
    pPlayState->setAlignment(Qt::AlignCenter);
    QHBoxLayout *pHBox = new QHBoxLayout(ui->openGLWidget);
    pHBox->addWidget(pPlayState);
    ui->comboBox->setCurrentIndex(0);
    //QObject::connect(pPlayState, SIGNAL(clicked(bool)), this, SLOT(startCapture()));

    xdma_programe *pXdma = new xdma_programe;
    if(pXdma->getDevice())
    {
        ui->openGLWidget->pRGB = (unsigned char *)malloc(4000*3000*3);
        ui->openGLWidget->W_size = 1920;
        ui->openGLWidget->H_size = 1080;
        // ui->openGLWidget->pRGB = (unsigned char *)malloc(ui->openGLWidget->W_size*ui->openGLWidget->H_size*3);
        pXdmaGetImg = new xdma_getImg(pXdma, (unsigned char *)ui->openGLWidget->pRGB, &ui->openGLWidget->optnotice);
        pXdmaGetImg->W_size = 1920;
        pXdmaGetImg->H_size = 1080;
        pXdmaGetImg->stride = 1920;
        pPlayState->setText(tr("播放暂停中"));
        QObject::connect(pXdmaGetImg, SIGNAL(flushImg()), ui->openGLWidget, SLOT(update()));
    }
    else
    {
        pXdmaGetImg = NULL;
        pPlayState->setText(tr("设备未就绪"));
    }
    pTimer = new QTimer;
    QObject::connect(ui->openGLWidget, SIGNAL(mouseDoubleClickNotice(int)), this, SLOT(changeWindows(int)));
    QObject::connect(ui->openGLWidget, SIGNAL(flushFps(int)), this, SLOT(flushFps(int)));
    QObject::connect(pTimer, SIGNAL(timeout()), this, SLOT(timeDelay()));
    // fps_timer = new QTimer;
    // QObject::connect(fps_timer, SIGNAL(timeout()), this, SLOT(fps_timer_func()));
    resize(640, 480);
    isPressed = false;
    isRelease = false;


}

MainWindow::~MainWindow()
{
    free(ui->openGLWidget->pRGB);//释放指针
}

void MainWindow::startCapture()
{
    if(!pXdmaGetImg)
    {
        return;
    }

    if(pPlayState->isVisible())
    {
        pPlayState->hide();
        pXdmaGetImg->setstart(true);
        // fps_timer->start(1000);
    }
    else
    {
        pPlayState->show();
        setWindowTitle(titleName);
        pXdmaGetImg->setstart(false);
        // fps_timer->stop();
    }
}



void MainWindow::changeWindows(int index)
{
    switch(index)
    {
    case 0:
        isPressed = true;
        break;
    case 1:
        pTimer->start(200);
        isRelease = true;
        break;
    case 2:
        // if(ui->openGLWidget->isFullScreen())
        if(isMaximized())
        {
            // qDebug("showNormal()");
            // ui->openGLWidget->setWindowFlags(Qt::SubWindow);
            // ui->verticalLayout_t->addWidget(ui->openGLWidget);
            // ui->openGLWidget->showNormal();//全屏显示
            showNormal();

        }
        else
        {
            // qDebug("showFullScreen()");

            // showFullScreen();
            // ui->openGLWidget->setWindowFlags(Qt::Window);
            // setCentralWidget(ui->openGLWidget);
            // ui->openGLWidget->showFullScreen();//全屏显示
            // showFullScreen();
            showMaximized(); // Qt最大化显示函数


        }
        isPressed = false;
        isRelease = false;
        break;
    case 3:
        isPressed = false;
        isRelease = false;
        break;
    }
}

void MainWindow::timeDelay()
{
    if(isPressed && isRelease)
    {
        startCapture();
    }
    isPressed = false;
    isRelease = false;
    pTimer->stop();
}

void MainWindow::fps_timer_func()
{
    // unsigned int W_size, H_size, fps;
    // pXdmaGetImg->axis_passthrouth_mon(&W_size, &H_size, &fps);
    // // // qDebug("- freq: %d -\r\n", fps);
    // // // qDebug("- res: %dx%d -\r\n", W_size, H_size);

    // if(fps < 40)
    // {
    //     if(ui->comboBox_video_source->currentIndex() == 0)
    //     {
    //         QMessageBox::information(this, "waring", "There is no external input video stream, please check the connection!!!", NULL);
    //         pPlayState->show();
    //         pXdmaGetImg->setstart(false);
    //         fps_timer->stop();
    //         memset(ui->openGLWidget->pRGB, 0xff, pXdmaGetImg->W_size*pXdmaGetImg->H_size*3);
    //         ui->openGLWidget->update();
    //     }
    // }
    // else
    // {
    //     pPlayState->hide();
    // }

}

void MainWindow::flushFps(int speed)
{
    // qDebug("fps:%02d.%02d", speed/100, speed%100);

}

void MainWindow::on_btn_save_clicked()
{
    ui->openGLWidget->ScreenShot();
}



void MainWindow::on_btn_other_clicked()
{
    QMessageBox msgBox(QMessageBox::NoIcon,"使用说明","这里是丰柯电子科技(上海)有限公司，一家专注为汽车电子客户提供高品质测试解决方案的高新科技公司。", QMessageBox::Yes|QMessageBox::No);
    int iResult = msgBox.exec();
    switch (iResult) {
    case QMessageBox::Yes:
        QMessageBox::about(NULL,"提示","您点击Yes按钮");
        break;
    case QMessageBox::No:
        QMessageBox::about(NULL,"提示","您点击No按钮");
        break;
    default:
        break;
    }
}


void MainWindow::on_comboBox_currentIndexChanged(int index)
{
    // qDebug("index %d", index);
    QString text = ui->comboBox->currentText();
    QMessageBox::information(this, "resolution", "your select resolution is " + text, NULL);
    pXdmaGetImg->setstart(false);
    if(index == 0)
    {
        ui->openGLWidget->W_size = 1920;
        ui->openGLWidget->H_size = 1080;
        pXdmaGetImg->W_size = 1920;
        pXdmaGetImg->H_size = 1080;
        pXdmaGetImg->stride = 1920;
    }
    else if(index == 1)
    {
        ui->openGLWidget->W_size = 1920;
        ui->openGLWidget->H_size = 720;
        pXdmaGetImg->W_size = 1920;
        pXdmaGetImg->H_size = 720;
        pXdmaGetImg->stride = 1920;
    }
    else if(index == 2)
    {
        ui->openGLWidget->W_size = 3840;
        ui->openGLWidget->H_size = 2160;
        pXdmaGetImg->W_size = 3840;
        pXdmaGetImg->H_size = 2160;
        pXdmaGetImg->stride = 3840;
    }
    else
    {

    }
    pXdmaGetImg->setstart(true);

}

void MainWindow::on_comboBox_video_source_currentIndexChanged(int index)
{
    QString text = ui->comboBox_video_source->currentText();
    QMessageBox::information(this, "video_source", "your select video_source is " + text, NULL);
    if(index == 0)
    { 
        pXdmaGetImg->video_stream_switch(0,0);
        pXdmaGetImg->clear_display();
    }
    else if(index == 1)
    {

       pXdmaGetImg->video_stream_switch(1,0);
       pXdmaGetImg->clear_display();

    }
    else
    {

    }
}




