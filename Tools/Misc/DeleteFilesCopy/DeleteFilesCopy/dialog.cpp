#include "dialog.h"
#include "ui_dialog.h"
#include "myutility.h"

Dialog::Dialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Dialog)
{
    ui->setupUi(this);
    setFixedSize(geometry().width(),geometry().height());

    connect(ui->selectRootButton,
            SIGNAL(clicked()),
            this,
            SLOT(SelectRootPath()));
    connect(ui->selectSubButton,
            SIGNAL(clicked()),
            this,
            SLOT(SelectSubPath()));
    connect(ui->deleteCopyButton,
            SIGNAL(clicked()),
            this,
            SLOT(DeleteCopy()));

    information_for_user_.clear();
    ui->pathTextBrowser->setDocument(&information_for_user_);
}

Dialog::~Dialog()
{
    delete ui;
}

void Dialog::SelectRootPath()
{
    QString root_directory_path = QFileDialog::getExistingDirectory(this,
                                                             "Get Root Path",
                                                             QDir::homePath());
    if(!root_directory_path.isEmpty())
    {
        root_directory_path_ = root_directory_path;
        UpdateInfomationForUser();
    }
}

void Dialog::SelectSubPath()
{
    if(root_directory_path_.isEmpty())
    {
        QMessageBox::information(this,"Warning","Please Choose Root Path");
        return;
    }
    else
    {
        QString sub_directory_path = QFileDialog::getExistingDirectory(this,
                                                                "Get Root Path",
                                                                root_directory_path_);
        if( !sub_directory_path.isEmpty() &&
            sub_directory_path.contains(root_directory_path_) )
        {
            sub_directory_path_ = sub_directory_path;
            UpdateInfomationForUser();
        }
    }
}

void Dialog::DeleteCopy()
{
    if(root_directory_path_.isEmpty() || sub_directory_path_.isEmpty())
    {
        QMessageBox::information(this,"Warning","Please choose rootPath and subPath");
        return;
    }
    QStringList file_path_list;
    MyUtility::GetFilesInfo(root_directory_path_,file_path_list,kFileAbsolutePathInfo);

    QMap<QString, QStringList> name_path_map_for_root;
    foreach(const QString& file_path,file_path_list)
    {
        QFileInfo file_info(file_path);
        QString   file_name = file_info.fileName();
        QMap<QString, QStringList>::Iterator iter;
        iter = name_path_map_for_root.find(file_name);
        if(iter != name_path_map_for_root.end())
        {
            iter.value().append(file_path);
        }
        else
        {
            QStringList temp_file_path_list;
            temp_file_path_list.append(file_path);
            name_path_map_for_root.insert(file_name,temp_file_path_list);
        }
    }

    QStringList name_list_for_sub;
    MyUtility::GetFilesInfo(sub_directory_path_,name_list_for_sub,kFileNameInfo);
    foreach(const QString& file_name, name_list_for_sub)
    {
        QMap<QString, QStringList>::Iterator iter;
        iter = name_path_map_for_root.find(file_name);
        if(iter != name_path_map_for_root.end())
        {
            QStringList& temp_path_list = iter.value();
            if(temp_path_list.count() > 1)
            {
                int file_count = 0;
                foreach(const QString& path, temp_path_list)
                {
                    QDir dir(path);
                    if(path.contains(sub_directory_path_))
                    {
                        file_count++;
                        if(file_count > 1)
                        {
                            dir.remove(path);
                            qDebug() << path;
                        }
                    }
                    else
                    {
                        dir.remove(path);
                        qDebug() << path;
                    }
                }
            }
        }
    }
}

void Dialog::UpdateInfomationForUser()
{
    QString info_for_user;
    if(!root_directory_path_.isEmpty())
    {
        info_for_user = "Root Path : ";
        info_for_user += root_directory_path_;
        info_for_user += "\n";

        if(!sub_directory_path_.isEmpty())
        {
            info_for_user += "Sub  Path : ";
            info_for_user += sub_directory_path_;
        }

        information_for_user_.clear();
        information_for_user_.setPlainText(info_for_user);
    }

    information_for_user_.setPlainText(info_for_user);
}




