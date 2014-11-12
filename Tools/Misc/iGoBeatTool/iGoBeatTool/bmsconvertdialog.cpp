#include "bmsconvertdialog.h"
#include "ui_bmsconvertdialog.h"
#include <QtGui>
#include "BMS/bmsfileparser.h"
#include "BMS/bmsdata.h"
#include "iGoBeat/igobeatsonginfo.h"
//#include "quazip/JlCompress.h"
#include "Utility/utiliy.h"

BmsConvertDialog::BmsConvertDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::BmsConvertDialog)
{
    ui->setupUi(this);
    setFixedSize(geometry().width(),geometry().height());
    ui->userInfoTextBrowser->setDocument(&information_for_user_);
    ui->selectAllCheckBox->setChecked(false);
}

BmsConvertDialog::~BmsConvertDialog()
{
    delete ui;
}

void BmsConvertDialog::on_selectBmsButton_clicked()
{
    //QString file_path = QFileDialog::getOpenFileName(this,"Select Bms File",QDir::currentPath(),"BMS File(*.bms *.bmse)");
    QString file_path = QFileDialog::getExistingDirectory(this,"Select Root Path",QDir::currentPath());
    if(!file_path.isEmpty())
    {
        bms_convert_root_workpath_ = file_path;
        bms_dir_path_list_ = QDir(file_path).entryList(QDir::AllDirs | QDir::NoDotAndDotDot);
        UpdateInformationForUser();
        UpdateListViewContent();
    }
}

void BmsConvertDialog::on_convertButton_clicked()
{
    bool is_test = false;
    //is_test = true;
    if(is_test)
    {
        //Test Code
        CompressIGoBeatDir("/Users/guodong/Desktop/iGB1_0073/iGB1_0073");
        //CopySongMeadiaFile("/Users/guodong/Desktop/iGB1_0073/iGB1_0073");
        return;
    }

    int size = ui->opernDirListWidget->count();
    if(size == 0) return;
    for(int i=0; i<size; i++)
    {
        QListWidgetItem* item = ui->opernDirListWidget->item(i);
        if(item->checkState() == Qt::Checked)
        {
            QString temp_bms_file_dir_path = bms_convert_root_workpath_ + "/";
            temp_bms_file_dir_path += bms_dir_path_list_.at(i);
            qDebug() << temp_bms_file_dir_path;
            ConvertBMSFile(temp_bms_file_dir_path);
            QDir bms_dir = QDir(temp_bms_file_dir_path);
            QString igobeat_file_path = temp_bms_file_dir_path;
            igobeat_file_path += "/";
            igobeat_file_path += bms_dir.dirName();
            CopySongMeadiaFile(igobeat_file_path);
            //CompressIGoBeatDir(igobeat_file_path);
            //Utiliy::RemoveDirectory(igobeat_file_path);
        }
    }
    QMessageBox::information(this,"ConvertCompleted","Convert Bms File To iGoBeat File Completed!",QMessageBox::Ok);
}

void BmsConvertDialog::onSelectAll(int state)
{
    int size = ui->opernDirListWidget->count();
    for(int i = 0; i < size; ++i)
    {
        QListWidgetItem* item = ui->opernDirListWidget->item(i);
        item->setCheckState((Qt::CheckState)state);
    }
}

void BmsConvertDialog::UpdateInformationForUser()
{
    QString info_for_user;
    if(!bms_convert_root_workpath_.isEmpty())
    {
        info_for_user = "Bms Convert Root Work Path : ";
        info_for_user += bms_convert_root_workpath_;
        info_for_user += "\n";

        information_for_user_.clear();
        information_for_user_.setPlainText(info_for_user);
    }

    information_for_user_.setPlainText(info_for_user);
}

void BmsConvertDialog::UpdateListViewContent()
{
    ui->opernDirListWidget->clear();
    ui->opernDirListWidget->addItems(bms_dir_path_list_);
    ui->selectAllCheckBox->setChecked(true);
    onSelectAll(Qt::Checked);
}

void BmsConvertDialog::ConvertBMSFile(QString bms_file_dir)
{
    QString igobeat_file_path = bms_file_dir;
    QString file_name_prefix = QDir(bms_file_dir).dirName();
    igobeat_file_path += "/";
    igobeat_file_path += file_name_prefix;
    QDir(bms_file_dir).mkdir(file_name_prefix);

    QStringList filters;
    filters << "*.bms";
    QFileInfoList bms_file_info_list = QDir(bms_file_dir).entryInfoList(filters);
    BMSFileContent easy_bms_file_content;
    BMSFileContent normal_bms_file_content;
    BMSFileContent hard_bms_file_content;
    BMSData easy_bms_data;
    BMSData normal_bms_data;
    BMSData hard_bms_data;
    BMSSongInfo easy_bms_song_info;
    BMSSongInfo normal_bms_song_info;
    BMSSongInfo hard_bms_song_info;
    foreach(const QFileInfo& file_info,bms_file_info_list)
    {
        if(file_info.isFile())
        {
            if( file_info.fileName().contains("E.bms") ||
                file_info.fileName().contains("Easy.bms") )
            {
                BMSFileParser::ParserBmsFile(file_info.filePath(),easy_bms_file_content);
                easy_bms_data = BMSData(easy_bms_file_content);
                QString temp_plist_file_path = igobeat_file_path;
                temp_plist_file_path += "/";
                temp_plist_file_path += file_name_prefix;
                temp_plist_file_path += "_E.plist";
                easy_bms_data.CreateIGoBeatOpernFile(temp_plist_file_path);
                easy_bms_data.GetBmsSongInfo(easy_bms_song_info);
            }
            if( file_info.fileName().contains("N.bms") ||
                file_info.fileName().contains("Normal.bms") )
            {
                BMSFileParser::ParserBmsFile(file_info.filePath(),normal_bms_file_content);
                normal_bms_data = BMSData(normal_bms_file_content);
                QString temp_plist_file_path = igobeat_file_path;
                temp_plist_file_path += "/";
                temp_plist_file_path += file_name_prefix;
                temp_plist_file_path += "_N.plist";
                normal_bms_data.CreateIGoBeatOpernFile(temp_plist_file_path);
                normal_bms_data.GetBmsSongInfo(normal_bms_song_info);
            }
            if( file_info.fileName().contains("H.bms") ||
                file_info.fileName().contains("Hard.bms") )
            {
                BMSFileParser::ParserBmsFile(file_info.filePath(),hard_bms_file_content);
                hard_bms_data = BMSData(hard_bms_file_content);
                QString temp_plist_file_path = igobeat_file_path;
                temp_plist_file_path += "/";
                temp_plist_file_path += file_name_prefix;
                temp_plist_file_path += "_H.plist";
                hard_bms_data.CreateIGoBeatOpernFile(temp_plist_file_path);
                hard_bms_data.GetBmsSongInfo(hard_bms_song_info);
            }
        }
    }
    iGoBeatSongInfo song_info;
    song_info.LoadBmsSongInfo(easy_bms_song_info,normal_bms_song_info,hard_bms_song_info);
    iGoBeatSongInfoFile song_info_file;
    QString song_info_file_path = igobeat_file_path;
    song_info_file_path += "/";
    song_info_file_path += file_name_prefix;
    song_info_file_path += "_Info.plist";
    song_info_file.CreateSongInfoPlistFile(song_info_file_path,song_info);
}

void BmsConvertDialog::CopySongMeadiaFile(const QString &igobeat_files_dir)
{
    QDir dir(igobeat_files_dir);

    // 1 copy song media file
    QStringList entry_list = dir.entryList();
    bool has_song_media_file = false;
    foreach(const QString& name,entry_list)
    {
        if(name.contains(".mp3"))
        {
            has_song_media_file = true;
            break;
        }
    }
    if(!has_song_media_file)
    {
        QDir bms_dir(dir);
        bms_dir.cdUp();
        QStringList entry_list = bms_dir.entryList();
        foreach(const QString& name,entry_list)
        {
            if(name.contains(".mp3"))
            {
                QString source_song_media_path = bms_dir.absoluteFilePath(name);
                QString destination_song_media_path = dir.absoluteFilePath(name);
                QFile::copy(source_song_media_path,destination_song_media_path);
                break;
            }
        }
    }
}

void BmsConvertDialog::CompressIGoBeatDir(const QString &igobeat_files_dir)
{
//    QDir dir(igobeat_files_dir);
//    QString compressed_name = igobeat_files_dir;
//    compressed_name += ".zip";
//    if( !JlCompress::compressDir(compressed_name,dir.absolutePath(),true) )
//    {
//        QMessageBox::warning(this,"Error","Compress igobeatfiles failed",QMessageBox::Ok);
//    }

    QDir dir(igobeat_files_dir);
    QDir work_dir(dir);
    work_dir.cdUp();

    QProcess proc;
    proc.setWorkingDirectory(work_dir.absolutePath());
    QStringList arguments;
    arguments << "-r" << dir.dirName() + ".zip" << dir.dirName();
    proc.start("zip", arguments);

    if (!proc.waitForStarted())
    {
        QMessageBox::warning(this,"Error","Compress igobeatfiles failed",QMessageBox::Ok);
        qDebug()<<"启动失败\n";
    }

    proc.closeWriteChannel();

    while (false == proc.waitForFinished())
    {
       ;
    }
    return;
}


