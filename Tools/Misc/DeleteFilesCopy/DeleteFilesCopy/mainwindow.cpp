#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "dialog.h"
#include "movefilesdialog.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    setFixedSize(geometry().width(),geometry().height());

    connect(ui->deleteCopyAction,
            SIGNAL(triggered()),
            this,
            SLOT(DeleteCopy()));
    connect(ui->moveFileAction,
            SIGNAL(triggered()),
            this,
            SLOT(MoveFile()));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::DeleteCopy()
{
    Dialog dialog;
    dialog.exec();
}

void MainWindow::MoveFile()
{
    MoveFilesDialog dialog;
    dialog.exec();
}
