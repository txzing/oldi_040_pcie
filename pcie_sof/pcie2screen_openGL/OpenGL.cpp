#include "OpenGL.h"
#include <sys/time.h>

OpenGL::OpenGL(QWidget *parent)
    : QOpenGLWidget(parent),
      m_program(0)
{
    setMouseTracking(true);
    // W_size  = 3840;
    // H_size  = 2160;

    W_size  = 1920;
    H_size  = 1080;

    // W_size  = 1920;
    // H_size  = 720;

    save_count = 1;
    // pRGB  = (unsigned char *)malloc(W_size*H_size*3);
    pthread_mutex_init(&optnotice, NULL);
}

OpenGL::~OpenGL()
{
    makeCurrent();
    delete m_program;
    doneCurrent();
    if(pRGB)
    {
        free(pRGB);
    }
}

void OpenGL::initializeGL()
{
    initializeOpenGLFunctions();
    if (!m_program)
    {
        m_program = new QOpenGLShaderProgram();
        QString vertexStr =
                "attribute highp vec4 vertexIn;"
                "attribute highp vec2 textureIn;"
                "varying vec2 textureOut;"
                "void main(void) "
                "{"
                "gl_Position = vertexIn;"
                "textureOut = textureIn;"
                "}";
        QString fragmentStr =
                "varying vec2 textureOut;"
                "uniform sampler2D tex_rgb;"
                "void main(void)"
                "{"
                "vec3 rgb;"
                "rgb.x = texture2D(tex_rgb, textureOut).b;"
                "rgb.y = texture2D(tex_rgb, textureOut).g;"
                "rgb.z = texture2D(tex_rgb, textureOut).r;"
                "gl_FragColor = vec4(rgb, 1);"
                "}";
        m_program->addShaderFromSourceCode(QOpenGLShader::Vertex, vertexStr);
        if(!m_program->addShaderFromSourceCode(QOpenGLShader::Fragment, fragmentStr))
        {
            fragmentStr.insert(0, "precision mediump float;");
            m_program->addShaderFromSourceCode(QOpenGLShader::Fragment, fragmentStr);
        }
        m_program->bindAttributeLocation("vertexIn",  ATTRIB_VERTEX);
        m_program->bindAttributeLocation("textureIn", ATTRIB_TEXTURE);
        m_program->link();
    }
    m_program->bind();
    static const GLfloat vertexVertices[] =
    {
        -1.0f, -1.0f,
        +1.0f, -1.0f,
        -1.0f, +1.0f,
        +1.0f, +1.0f,
    };
    static const GLfloat textureVertices[] =
    {
        0.0f,  1.0f,
        1.0f,  1.0f,
        0.0f,  0.0f,
        1.0f,  0.0f,
    };
    m_program->setAttributeArray(ATTRIB_VERTEX, GL_FLOAT, vertexVertices, 2);
    m_program->enableAttributeArray(ATTRIB_VERTEX);
    m_program->setAttributeArray(ATTRIB_TEXTURE, GL_FLOAT, textureVertices, 2);
    m_program->enableAttributeArray(ATTRIB_TEXTURE);
    TextureID0 = m_program->uniformLocation("tex_rgb");
    glGenTextures(1, &textureRGB);
    glBindTexture(GL_TEXTURE_2D, textureRGB);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, (GLfloat)GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, (GLfloat)GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    gettimeofday(&last_time, NULL);
}

void OpenGL::paintGL()
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, textureRGB);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, W_size, H_size, 0, GL_RGB, GL_UNSIGNED_BYTE, pRGB);
    m_program->setUniformValue(TextureID0, 0);

    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

    pthread_mutex_unlock(&optnotice);
    frameCot++;
    gettimeofday(&curr_time, NULL);
    a = curr_time.tv_sec*1000000+curr_time.tv_usec;
    a -= last_time.tv_sec*1000000;
    a -= last_time.tv_usec;
    if(a >= 500000)
    {
        a = 100000000*frameCot/a;
        last_time.tv_sec = curr_time.tv_sec;
        last_time.tv_usec = curr_time.tv_usec;
        frameCot = 0;
        emit flushFps(a);
    }
}

void OpenGL::ScreenShot()
{
    qDebug("save picture %d\n",save_count);
    QImage(pRGB,W_size,H_size, QImage::Format_BGR888,nullptr,nullptr).save(QString("pictures/output-%1.bmp").arg(save_count++),"BMP",100);

}

void OpenGL::mousePressEvent(QMouseEvent *)
{
    // qDebug("mouseDoubleClickNotice(0)\n");
    emit mouseDoubleClickNotice(0);
}

void OpenGL::mouseReleaseEvent(QMouseEvent *)
{
    // qDebug("mouseDoubleClickNotice(1)\n");
    emit mouseDoubleClickNotice(1);
}

void OpenGL::mouseDoubleClickEvent(QMouseEvent *)
{
    // qDebug("mouseDoubleClickNotice(2)\n");
    emit mouseDoubleClickNotice(2);
}

void OpenGL::mouseMoveEvent(QMouseEvent *)
{
    // qDebug("mouseDoubleClickNotice(3)\n");
    emit mouseDoubleClickNotice(3);
}








