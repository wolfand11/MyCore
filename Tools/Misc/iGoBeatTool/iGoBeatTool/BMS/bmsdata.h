#ifndef BMSDATA_H
#define BMSDATA_H
#include <QString>
#include <QVector>
#include "BMS/bmsfileparser.h"
#include <QObject>

struct BMSSongInfo
{
    BMSSongInfo()
    {
        song_genre_ = "Unknown";
        song_artist_= "Unknown";
        song_title_ = "Unknown";
        media_name_ = "Unknown";
        opern_editor_       = "Unknown";
        game_center_id_     = "0";
        difficulty_level_   = "0";
        song_time_          = "0";
        song_bpm_           = "0.0";

        is_default_value_   = true;
    }
    QString song_genre_;
    QString song_artist_;
    QString song_title_;
    QString media_name_;
    QString opern_editor_;
    QString game_center_id_;
    QString difficulty_level_;
    QString song_time_;
    QString song_bpm_;

    bool    is_default_value_;
};

struct BMSNote
{
    BMSNote()
    {
        measure_value = -1.0;
        channel_value = -1;
    }

    double          measure_value;  // note index
    int             channel_value;  // note type
    QString         data;

    QString ToString() const
    {
        QString temp;
        temp =  " {measure_value=";
        temp += QString::number(measure_value);
        temp += ",";
        temp += "channel_value=";
        temp += QString::number(channel_value);
        temp += ",";
        temp += "data=";
        temp += data;
        temp += "} ";
        return temp;
    }
};

class BMSTimeLine;
class BMSData
{
    friend class BMSTimeLine;
public:
    BMSData(){ is_empty_ = true; }
    BMSData(const BMSFileContent& bms_file_content);
    bool CreateIGoBeatOpernFile(const QString& file_path);
    bool GetBmsSongInfo(BMSSongInfo &bms_song_info);
    void debug_print();

private:
    QString ConvertChannelValueToIGoBeatNotePosition(int channel_value);

private: //parse bms_file_content to BMSNote variable
    bool    FillAllPlayNotesVector(const BMSFileContent& bms_file_content);
    bool    FillAllBeatNotesVector(const BMSFileContent &bms_file_content);
    bool    FillAllBpmNotesVector(const BMSFileContent& bms_file_content);   //TODO: Ver2
    bool    FillAllBgmNotesVector(const BMSFileContent& bms_file_content);   //TODO: Ver2
    bool    IsPlayChannelData(int channel_number);
    bool    IsBeatChannelData(int channel_number);
    bool    IsBpmChannelData(int channel_number);
    bool    IsBgmChannelData(int channel_number);
    int     GetMaxMeasureNumber(const BMSFileContent &bms_file_content);
    bool    GetHeadFieldData(const QString& key,/*out*/QString& value) const;
    BMSNote GetBackgroundMusicNote(QString& music_file_name) const;

    // BMS File Define Field Data
    QMap<QString,QString>           define_field_;

    typedef QMap< int, QVector<BMSNote> > PlayNotesMap;
    typedef PlayNotesMap::Iterator PlayNotesMapIter;
    /**
      @variable:    all_playchannel_notes
      @key:         channel_value (Play通道的编号)
      @value:       Play通道编号为channel_value的所有note
      @note:        该变量中保存了所有的Play通道的数据,其中一个Key对应一个Play通道以及该通道中的所有曲谱note
    */
    PlayNotesMap    all_playchannel_notes_;

    typedef QMap< int, BMSNote > NonPlayNotesMap;
    typedef NonPlayNotesMap::Iterator       NonPlayNotesMapIter;
    typedef NonPlayNotesMap::ConstIterator  NonPlayNotesMapConstIter;
    /**
      @variable:    all_beat_notes_
      @key:         measure_value (节拍note的小节值,可以是小数,小数部分为0)
      @value:       小节编号为measure_value的note(note 数据中保存了 小节的节拍数目)
      @note:        一个小节最多只能对应一个节拍note,这是BMS曲谱的规则
    */
    NonPlayNotesMap    all_beat_notes_;

    //TODO: Ver2 变化的bpm
    /**
      @variable:    all_bpm_notes_
      @key:         measure_value (节拍note的小节值,可以是小数,小数部分表示note在该小节中的偏移量.例如:1.5表示该note处于第一小节的中间)
      @value:       小节编号为measure_value的note(note 数据中保存 bpm数值)
      @note:
    */
    NonPlayNotesMap    all_bpm_notes_;
    //TODO：Ver2 key音支持
    /**
      @variable:    all_bpm_notes_
      @key:         measure_value (节拍note的小节值,可以是小数,小数部分表示note在该小节中的偏移量.例如:1.5表示该note处于第一小节的中间)
      @value:       小节编号为measure_value的note(note 数据中保存 背景音乐文件名)
      @note:
    */
    NonPlayNotesMap    all_bgm_notes_;

    int     max_measure_number_;
    // BMSData is empty
    bool    is_empty_;
};






#endif // BMSDATA_H
