#include "movefilesdialog.h"
#include "ui_movefilesdialog.h"
#include "myutility.h"

MoveFilesDialog::MoveFilesDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::MoveFilesDialog)
{
    ui->setupUi(this);
    setFixedSize(geometry().width(),geometry().height());

    ui->userInfoTextBrowser->setDocument(&information_for_user_);

    connect(ui->selectFileButton,
            SIGNAL(clicked()),
            this,
            SLOT(SelectNamesFile()));
    connect(ui->selectPathButton,
            SIGNAL(clicked()),
            this,
            SLOT(SelectPath()));
    connect(ui->moveFilesButton,
            SIGNAL(clicked()),
            this,
            SLOT(MoveFiles()));
}

MoveFilesDialog::~MoveFilesDialog()
{
    delete ui;
}

void MoveFilesDialog::SelectNamesFile()
{
    QString names_file_path = QFileDialog::getOpenFileName(this,
                                                           "Select Names File",
                                                           QDir::homePath());
    if(!names_file_path.isEmpty())
    {
        names_file_path_ = names_file_path;
        UpdateInfomationForUser();
    }
}

void MoveFilesDialog::SelectPath()
{
    if(names_file_path_.isEmpty())
    {
        QMessageBox::information(this,"Warning","Please Select Names File");
        return;
    }
    else
    {
        QString file_path = QFileDialog::getExistingDirectory(this,
                                                              "Get Root Path",
                                                              QDir::homePath());
        if( !file_path.isEmpty() )
        {
            files_path_ = file_path;
            UpdateInfomationForUser();
        }
    }
}

void MoveFilesDialog::MoveFiles()
{
    if(files_path_.isEmpty() || names_file_path_.isEmpty())
    {
        QMessageBox::information(this,
                                 "Warning",
                                 "path or name is null!");
        return;
    }
    else
    {
        QMap<QString,QString> name_movetopath_map;

        // 1 get files configed full path
        QFile file(names_file_path_);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        {
            qDebug() << "open file failed";
            return;
        }
        QTextStream file_stream(&file);
        QString     line = file_stream.readLine();
        while(!line.isNull())
        {
            QFileInfo file_info(line.remove("\"").trimmed());
            name_movetopath_map.insert(file_info.fileName(),
                                       file_info.absoluteFilePath());

            // loop variable
            line = file_stream.readLine();
        }

        // 2 get files current full path
        QStringList file_current_path_list;
        MyUtility::GetFilesInfo(files_path_,
                                file_current_path_list,
                                kFileAbsolutePathInfo);

        // 3 move current to configed
        foreach(const QString& full_path,file_current_path_list)
        {
            QFileInfo file_info(full_path);
            QMap<QString,QString>::Iterator iter;
            iter = name_movetopath_map.find(file_info.fileName());
            if(iter != name_movetopath_map.end())
            {
                if(full_path != iter.value())
                {
                    QDir::root().rename(full_path,iter.value());
                    qDebug() << full_path << "==>" << iter.value();
                }
            }
        }
    }
}

void MoveFilesDialog::UpdateInfomationForUser()
{
    QString info_for_user;
    if(!names_file_path_.isEmpty())
    {
        info_for_user = "NamesFile : ";
        info_for_user += names_file_path_;

        if(!files_path_.isEmpty())
        {
            info_for_user += "FilesPath : ";
            info_for_user += files_path_;
            info_for_user += "\n";
        }

        information_for_user_.clear();
        information_for_user_.setPlainText(info_for_user);
    }

    information_for_user_.setPlainText(info_for_user);
}
