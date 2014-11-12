#include <QStringList>
#include <QDebug>
#include <QApplication>
#include "BMS/bmsdata.h"
#include "Utility/utiliy.h"
#include "iGoBeat/qigobeatnode.h"
#include "BMS/defineforbmsfile.h"

bool MeasureValueIsLessThan(const BMSNote& note1,const BMSNote& note2)
{
    return (note1.measure_value < note2.measure_value);
}

bool MeasureNumberIsLessThan(const BMSDataFieldElement& data_field1,const BMSDataFieldElement& data_field2)
{
    return (data_field1.measure_number < data_field2.measure_number);
}

bool IGoBeatNoteStartTimeIsLessThan(const QiGoBeatNodeData& node_1,const QiGoBeatNodeData& node_2)
{
    return (node_1.m_nodeStartTime < node_2.m_nodeStartTime);
}

BMSData::BMSData(const BMSFileContent& bms_file_content)
{
    define_field_ = bms_file_content.define_field;
    FillAllBeatNotesVector(bms_file_content);
    FillAllBgmNotesVector(bms_file_content);
    FillAllPlayNotesVector(bms_file_content);
    FillAllBpmNotesVector(bms_file_content);

    max_measure_number_ = GetMaxMeasureNumber(bms_file_content);
    is_empty_ = false;
    debug_print();
}

bool BMSData::CreateIGoBeatOpernFile(const QString &file_path)
{
    if(is_empty_)
    {
        qDebug() << "Error :[BMSData::CreateIGoBeatOpernFile] BMSData is empty!";
        return false;
    }

    QString bpm_value_str;
    GetHeadFieldData("BPM",bpm_value_str);
    double bpm_value = bpm_value_str.toDouble();
    // 一个节拍的时间
    double time_of_a_beat = 60 * 1000 / bpm_value;
    // 背景音乐开始的小节编号
    double bgm_start_measure = 0.0;
    QString background_music_file_name;
    const BMSNote& bms_note = GetBackgroundMusicNote(background_music_file_name);
    if(bms_note.measure_value > 0)
    {
        bgm_start_measure = bms_note.measure_value;
    }

    QList<QiGoBeatNodeData> i_go_beat_node_list;
    QiGoBeatNodeData i_go_beat_node;
    PlayNotesMapIter play_notes_map_iter = all_playchannel_notes_.begin();
    while(play_notes_map_iter != all_playchannel_notes_.end())
    {
        const QVector<BMSNote>& play_notes = play_notes_map_iter.value();
        QiGoBeatNodeData* pre_long_node = 0;
        foreach(const BMSNote& play_note,play_notes)
        {
            i_go_beat_node.m_isIGoBeatPosition = true;
            i_go_beat_node.m_nodeExtraNumber = 0;
            i_go_beat_node.m_nodeIndex = -1;
            i_go_beat_node.m_nodePositionStr = ConvertChannelValueToIGoBeatNotePosition(play_note.channel_value);
            i_go_beat_node.m_nodeStartTime = (play_note.measure_value-bgm_start_measure) * 4 * time_of_a_beat;
            if(i_go_beat_node.m_nodePositionStr.contains("L"))
            {
                i_go_beat_node.m_nodeType = IGOBEATNODETYPE_LONG;
                i_go_beat_node.m_nodeEndTime = -1.0f;
            }
            else
            {
                i_go_beat_node.m_nodeType = IGOBEATNODETYPE_NORMAL;
                i_go_beat_node.m_nodeEndTime = 0.0;
            }
            i_go_beat_node_list.append(i_go_beat_node);
            if(i_go_beat_node.m_nodeType == IGOBEATNODETYPE_LONG)
            {
                if(pre_long_node == 0)
                {
                    pre_long_node = &(i_go_beat_node_list.last());
                }
                else
                {
                    pre_long_node->m_nodeEndTime = i_go_beat_node.m_nodeStartTime;
                    pre_long_node = 0;
                    i_go_beat_node_list.pop_back();
                }
            }
        }
        if(pre_long_node != 0)
        {
            qDebug() << "Error pre_long_node isn't NULL";
        }

        play_notes_map_iter++;
    }

    qSort(i_go_beat_node_list.begin(),i_go_beat_node_list.end(),IGoBeatNoteStartTimeIsLessThan);
    for(int i=0; i<i_go_beat_node_list.count(); i++)
    {
        i_go_beat_node_list[i].m_nodeIndex = i;
    }
    QiGoBeatNodeFile i_gobeat_node_file;
    i_gobeat_node_file.createPListFile(file_path,i_go_beat_node_list);
}

bool BMSData::GetBmsSongInfo(BMSSongInfo& bms_song_info)
{
    if(is_empty_)
    {
        qDebug() << "Error:(BMSData::GetBmsSongInfo) BMSData is empty!";
        return false;
    }
    QString key = kArtistDefine;
    QString value;
    if(GetHeadFieldData(key,value))
    {
        bms_song_info.song_artist_ = value;
    }
    key = kPlayLevelDefine;
    if(GetHeadFieldData(key,value))
    {
        bms_song_info.difficulty_level_ = value;
    }
    QString bms_song_file_name;
    GetBackgroundMusicNote(bms_song_file_name);
    bms_song_info.media_name_ = bms_song_file_name;
    key = kTitleDefine;
    if(GetHeadFieldData(key,value))
    {
        bms_song_info.song_title_ = value;
    }
    key = kGenreDefine;
    if(GetHeadFieldData(key,value))
    {
        bms_song_info.song_genre_ = value;
    }
    key = kBpmDefine;
    if( GetHeadFieldData(key,value) )
    {
        bms_song_info.song_bpm_ = value;
    }
    key = kTotalDefine;
    if( GetHeadFieldData(key,value) )
    {
        int song_time = value.toInt();
        song_time = song_time * 1000;
        bms_song_info.song_time_ = QString::number(song_time);
    }

    bms_song_info.is_default_value_ = false;
    return true;
}

QString BMSData::ConvertChannelValueToIGoBeatNotePosition(int channel_value)
{
    QMap<int,QString> channelValue_iGoBeatNotePosition_map;
    channelValue_iGoBeatNotePosition_map.insert(16,"A1");
    channelValue_iGoBeatNotePosition_map.insert(11,"A2");
    channelValue_iGoBeatNotePosition_map.insert(12,"A3");
    channelValue_iGoBeatNotePosition_map.insert(13,"A4");
    channelValue_iGoBeatNotePosition_map.insert(14,"B1");
    channelValue_iGoBeatNotePosition_map.insert(15,"B2");
    channelValue_iGoBeatNotePosition_map.insert(18,"B3");
    channelValue_iGoBeatNotePosition_map.insert(19,"B4");
    channelValue_iGoBeatNotePosition_map.insert(21,"C1");
    channelValue_iGoBeatNotePosition_map.insert(22,"C2");
    channelValue_iGoBeatNotePosition_map.insert(23,"C3");
    channelValue_iGoBeatNotePosition_map.insert(24,"C4");
    channelValue_iGoBeatNotePosition_map.insert(25,"D1");
    channelValue_iGoBeatNotePosition_map.insert(28,"D2");
    channelValue_iGoBeatNotePosition_map.insert(29,"D3");
    channelValue_iGoBeatNotePosition_map.insert(26,"D4");

    channelValue_iGoBeatNotePosition_map.insert(56,"AL1");
    channelValue_iGoBeatNotePosition_map.insert(51,"AL2");
    channelValue_iGoBeatNotePosition_map.insert(52,"AL3");
    channelValue_iGoBeatNotePosition_map.insert(53,"AL4");
    channelValue_iGoBeatNotePosition_map.insert(54,"BL1");
    channelValue_iGoBeatNotePosition_map.insert(55,"BL2");
    channelValue_iGoBeatNotePosition_map.insert(58,"BL3");
    channelValue_iGoBeatNotePosition_map.insert(59,"BL4");
    channelValue_iGoBeatNotePosition_map.insert(61,"CL1");
    channelValue_iGoBeatNotePosition_map.insert(62,"CL2");
    channelValue_iGoBeatNotePosition_map.insert(63,"CL3");
    channelValue_iGoBeatNotePosition_map.insert(64,"CL4");
    channelValue_iGoBeatNotePosition_map.insert(65,"DL1");
    channelValue_iGoBeatNotePosition_map.insert(68,"DL2");
    channelValue_iGoBeatNotePosition_map.insert(69,"DL3");
    channelValue_iGoBeatNotePosition_map.insert(66,"DL4");

    if(channelValue_iGoBeatNotePosition_map.count(channel_value) == 1)
    {
        return channelValue_iGoBeatNotePosition_map.value(channel_value);
    }
    else
    {
        qDebug() << "can't convert channel_value:" << channel_value;
        return "";
    }
}

bool BMSData::FillAllBeatNotesVector(const BMSFileContent& bms_file_content)
{
    BMSNote temp_note;
    foreach(const BMSDataFieldElement& element,bms_file_content.data_field)
    {
        if(IsBeatChannelData(element.channel_number))
        {
            temp_note.channel_value = element.channel_number;
            temp_note.measure_value = element.measure_number;
            temp_note.data = element.data;
            all_beat_notes_.insert(temp_note.measure_value,temp_note);
        }
    }
    return true;
}

bool BMSData::FillAllBgmNotesVector(const BMSFileContent &bms_file_content)
{
    BMSNote temp_note;
    foreach(const BMSDataFieldElement& element,bms_file_content.data_field)
    {
        if(IsBgmChannelData(element.channel_number))
        {
            temp_note.channel_value = element.channel_number;
            QStringList temp_string_data_list;
            if( !Utiliy::StringToStringList(element.data,temp_string_data_list,2,kFromLeftToRight) )
            {
                qDebug() << "Error:[BMSData::FillAllBgmNotesVector] split string failed!";
                return false;
            }
            for(int i=0; i<temp_string_data_list.count(); i++)
            {
                // WAV01 --> WAVZZ (36进制)
                if(temp_string_data_list.at(i).toInt(NULL,36) > 0)
                {
                    temp_note.measure_value = element.measure_number + (double)i / temp_string_data_list.count();
                    temp_note.data = temp_string_data_list.at(i);
                    all_bgm_notes_.insert(temp_note.measure_value,temp_note);
                }
            }
        }
    }
    return true;
}

bool BMSData::FillAllBpmNotesVector(const BMSFileContent &bms_file_content)
{
    //TODO: Ver2
    return false;
}

bool BMSData::FillAllPlayNotesVector(const BMSFileContent &bms_file_content)
{
    BMSNote temp_note;
    foreach(const BMSDataFieldElement& element,bms_file_content.data_field)
    {
        if(IsPlayChannelData(element.channel_number))
        {
            // 1 set channel_value of note
            temp_note.channel_value = element.channel_number;

            // 2 set measure_value & data of note
            QStringList temp_string_data_list;
            if( !Utiliy::StringToStringList(element.data,temp_string_data_list,2) )
            {
                qDebug() << "StringToStringList failed" << endl;
                return false;
            }
            for(int i=0; i<temp_string_data_list.count(); i++)
            {
                // WAV01 --> WAVZZ (36进制)
                if(temp_string_data_list.at(i).toInt(NULL,36) > 0)
                {
                    temp_note.measure_value = element.measure_number + (double)i / (double)temp_string_data_list.count();
                    temp_note.data = temp_string_data_list.at(i);
                    PlayNotesMapIter iter = all_playchannel_notes_.find(temp_note.channel_value);
                    if(iter != all_playchannel_notes_.end())
                    {
                        iter.value().append(temp_note);
                    }
                    else
                    {
                        QVector<BMSNote> temp_notes;
                        temp_notes.append(temp_note);
                        all_playchannel_notes_.insert(temp_note.channel_value,temp_notes);
                    }
                }
            }
        }
    }
    return true;
}

bool BMSData::IsPlayChannelData(int channel_number)
{
    if( channel_number > 10 && channel_number < 30 &&
        channel_number !=17 && channel_number !=27 &&
        channel_number !=20 )
    {
        return true;
    }

    if( channel_number > 50 && channel_number < 70 &&
        channel_number !=57 && channel_number !=67 &&
        channel_number !=60 )
    {
        return true;
    }

    return false;
}

bool BMSData::IsBeatChannelData(int channel_number)
{
    if( channel_number == 2 )
    {
        return true;
    }
    return false;
}

bool BMSData::IsBgmChannelData(int channel_number)
{
    if( channel_number == 1 )
    {
        return true;
    }
    return false;
}

bool BMSData::IsBpmChannelData(int channel_number)
{
    //TODO: Ver2 BMSE don't support bpm changed
    return false;
}

int BMSData::GetMaxMeasureNumber(const BMSFileContent &bms_file_content)
{
    QVector<BMSDataFieldElement> bms_data_fields = bms_file_content.data_field;
    qSort(bms_data_fields.begin(),bms_data_fields.end(),MeasureNumberIsLessThan);
    int max_measure_number = 0;
    int temp_data_count = bms_data_fields.count();
    if(temp_data_count > 0)
    {
        max_measure_number = bms_data_fields.at(temp_data_count-1).measure_number;
        max_measure_number += 1;
    }
    return max_measure_number;
}

bool BMSData::GetHeadFieldData(const QString &key, QString &value) const
{
    QMap<QString,QString>::ConstIterator iter = define_field_.find(key);
    if(iter == define_field_.end())
    {
        value = "";
        return false;
    }
    value = iter.value();
    return true;
}

BMSNote BMSData::GetBackgroundMusicNote(QString& music_file_name) const
{
    NonPlayNotesMapConstIter iter = all_bgm_notes_.begin();
    while(iter != all_bgm_notes_.end())
    {
        const BMSNote& bms_note = iter.value();
        if(!bms_note.data.isEmpty())
        {
            QString bgm_define_name = "WAV";
            bgm_define_name += bms_note.data;
            QString bgm_define_value;
            GetHeadFieldData(bgm_define_name,bgm_define_value);
            if(!bgm_define_value.isEmpty())
            {
                music_file_name = bgm_define_value;
                return bms_note;
            }
        }
        iter++;
    }
    music_file_name = "Unknown";
    return BMSNote();
}

void BMSData::debug_print()
{
    PlayNotesMapIter begin = all_playchannel_notes_.begin();
    while(begin != all_playchannel_notes_.end())
    {
        qDebug() << begin.key() << ":";
        Utiliy::PrintVector(begin.value());

        begin++;
    }
    Utiliy::PrintList(all_beat_notes_.values());
    Utiliy::PrintList(all_bpm_notes_.values());
    Utiliy::PrintList(all_bgm_notes_.values());
}
