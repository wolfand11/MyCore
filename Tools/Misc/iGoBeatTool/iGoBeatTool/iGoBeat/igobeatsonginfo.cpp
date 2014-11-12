#include <QString>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include "igobeatsonginfo.h"
#include "qigobeatnode.h"
#include "BMS/defineforbmsfile.h"
#include "BMS/bmsdata.h"

iGoBeatSongInfo::iGoBeatSongInfo()
{
    song_genre_     ="unknown genre";
    song_artist_    ="unknown artist";
    song_title_     ="unknown title";
    media_name_     ="unknown media";
    game_center_id_ ="0";
    easy_level_     ="0";
    normal_level_   ="0";
    hard_level_     ="0";
    song_time_      ="0";
    opern_editor_   ="unknown editor";
    song_bpm_       ="120";
}

bool iGoBeatSongInfo::LoadBmsSongInfo( BMSSongInfo easy_song_info,
                                       BMSSongInfo normal_song_info,
                                       BMSSongInfo hard_song_info )
{
    if(!easy_song_info.is_default_value_)
    {
        song_genre_     = easy_song_info.song_genre_;
        song_artist_    = easy_song_info.song_artist_;
        song_title_     = easy_song_info.song_title_;
        media_name_     = easy_song_info.media_name_;
        easy_level_     = easy_song_info.difficulty_level_;
        song_bpm_       = easy_song_info.song_bpm_;
        song_time_      = easy_song_info.song_time_;
    }
    if(!normal_song_info.is_default_value_)
    {
        song_genre_     = normal_song_info.song_genre_;
        song_artist_    = normal_song_info.song_artist_;
        song_title_     = normal_song_info.song_title_;
        media_name_     = normal_song_info.media_name_;
        normal_level_   = normal_song_info.difficulty_level_;
        song_bpm_       = normal_song_info.song_bpm_;
        song_time_      = normal_song_info.song_time_;
    }
    if(!hard_song_info.is_default_value_)
    {
        song_genre_     = hard_song_info.song_genre_;
        song_artist_    = hard_song_info.song_artist_;
        song_title_     = hard_song_info.song_title_;
        media_name_     = hard_song_info.media_name_;
        hard_level_     = hard_song_info.difficulty_level_;
        song_bpm_       = hard_song_info.song_bpm_;
        song_time_      = hard_song_info.song_time_;
    }
    return true;
}

QString iGoBeatSongInfo::CreateSongInfoContent() const
{
    QString str;
    str += "<dict>\n";
    str += "	<key>Artist</key>\n";
    str += QString("	<string>%1</string>\n").arg(song_artist_);
    str += "	<key>Easy</key>\n";
    str += QString("	<string>%1</string>\n").arg(easy_level_);
    str += "	<key>Normal</key>\n";
    str += QString("	<string>%1</string>\n").arg(normal_level_);
    str += "	<key>Hard</key>\n";
    str += QString("	<string>%1</string>\n").arg(hard_level_);
    str += "	<key>GameCenterID</key>\n";
    str += QString("	<string>%1</string>\n").arg(game_center_id_);
    str += "	<key>Genre</key>\n";
    str += QString("	<string>%1</string>\n").arg(song_genre_);
    str += "	<key>MediaName</key>\n";
    str += QString("	<string>%1</string>\n").arg(media_name_);
    str += "	<key>SongName</key>\n";
    str += QString("	<string>%1</string>\n").arg(song_title_);
    str += "	<key>Time</key>\n";
    str += QString("	<string>%1</string>\n").arg(song_time_);
    str += "	<key>iGB_Editor</key>\n";
    str += QString("	<string>%1</string>\n").arg(opern_editor_);
    str += "	<key>BPM</key>\n";
    str += QString("	<string>%1</string>\n").arg(song_bpm_);
    str += "</dict>\n";
    return str;
}

void iGoBeatSongInfoFile::CreateSongInfoPlistFile(const QString& file_path,const iGoBeatSongInfo& data)
{
    QFile file(file_path);
    if(file.open(QIODevice::WriteOnly) == false)
    {
        qDebug() << QString("Open File Failed:") << file_path;
        return;
    }

    QTextStream out(&file);
    out.setCodec("UTF-8");
    out<<QiGoBeatNodeFile::plistHeader();
    out<<data.CreateSongInfoContent();
    out<<QString("</plist>\n");
    file.close();
}
