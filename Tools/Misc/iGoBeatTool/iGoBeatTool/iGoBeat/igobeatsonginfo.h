#ifndef IGOBEATSONGINFO_H
#define IGOBEATSONGINFO_H
#include <QString>
#include "BMS/bmsdata.h"

class iGoBeatSongInfo
{
public:
    iGoBeatSongInfo();
    bool    LoadBmsSongInfo(BMSSongInfo easy_song_info,
                            BMSSongInfo normal_song_info,
                            BMSSongInfo hard_song_info);
    QString CreateSongInfoContent() const;

private:
    QString song_genre_;
    QString song_artist_;
    QString song_title_;
    QString song_bpm_;
    QString media_name_;
    QString game_center_id_;
    QString easy_level_;
    QString normal_level_;
    QString hard_level_;
    QString song_time_;
    QString opern_editor_;
};

class iGoBeatSongInfoFile
{
public:
    static void CreateSongInfoPlistFile(const QString& file_path,const iGoBeatSongInfo& data);
};
#endif // IGOBEATSONGINFO_H
