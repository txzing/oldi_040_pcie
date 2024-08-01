#ifndef OPENGL_H
#define OPENGL_H

#include <QtWidgets>
#include <QOpenGLWidget>
#include <QOpenGLFunctions>
#include <QOpenGLBuffer>
#include <QOpenGLShaderProgram>
#include <QOpenGLTexture>

#define ATTRIB_VERTEX   3
#define ATTRIB_TEXTURE  4

QT_FORWARD_DECLARE_CLASS(QOpenGLShaderProgram)
QT_FORWARD_DECLARE_CLASS(QOpenGLTexture)


class OpenGL : public QOpenGLWidget, protected QOpenGLFunctions
{
    Q_OBJECT

public:
    explicit OpenGL(QWidget *parent = 0);
    QTreeWidgetItem *pItem;
    ~OpenGL();
    pthread_mutex_t optnotice;

    void ScreenShot(void);

protected:
    void initializeGL() Q_DECL_OVERRIDE;
    void paintGL() Q_DECL_OVERRIDE;
    void mousePressEvent(QMouseEvent *);
    void mouseReleaseEvent(QMouseEvent *);
    void mouseDoubleClickEvent(QMouseEvent *);
    void mouseMoveEvent(QMouseEvent *);

private:
    QOpenGLShaderProgram *m_program;


    unsigned long long a;
    unsigned long long frameCot = 0;
    struct timeval last_time;
    struct timeval curr_time;

public:
    unsigned short W_size, H_size;
    unsigned char *pRGB;

    GLuint textureRGB;
    GLuint TextureID0;

    unsigned char save_count;

Q_SIGNALS:
    void mouseDoubleClickNotice(int);
    void flushFps(int);
};

#endif // OPENGL_H
