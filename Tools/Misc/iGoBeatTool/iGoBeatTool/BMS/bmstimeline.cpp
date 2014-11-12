#include "bmstimeline.h"
#include "BMS/bmsdata.h"
#include <QDebug>

BMSTimeLine::BMSTimeLine(const BMSData& bms_data)
{
    bms_data_ = bms_data;
}

//bool BMSTimeLine::CreateBMSTimeLine()
//{
//    BMSTimeLineElement element;
//    foreach(BMSNote note,bms_data_.all_beat_notes_)
//    {
//    }
//}

bool BMSTimeLine::CreateTempBMSTimeLine()
{
    // 1 在时间线上 标注小节起始点
    BMSTimeLineElement element;
    if(bms_data_.max_measure_number_ < 1)
    {
        qDebug() << "Error:max_measure_number is " << bms_data_.max_measure_number_;
        return false;
    }
    for(int i=0; i<=bms_data_.max_measure_number_; i++)
    {
        element.start_time = -1.0;
        element.start_measure_value = i;
        element.bpm_value = -1.0;
        element.measure_value_unit = 1.0;   //默认情况下小节单位长度都为1

        measurevalue_timelineelement_map_.insert(element.start_measure_value,element);
    }

    // 2 修改时间线上 小节点的单位长度值(默认为1)
    BMSData::NonPlayNotesMapIter iter = bms_data_.all_beat_notes_.begin();
    while(iter != bms_data_.all_beat_notes_.end())
    {
        TimeLineElementMapIter element_iter = measurevalue_timelineelement_map_.find(iter.value().measure_value);
        if(element_iter != measurevalue_timelineelement_map_.end())
        {
            element_iter.value().start_time = -1.0;
            //element_iter.value().start_measure_value is setted
            element_iter.value().bpm_value  = -1.0;
            // 修改时间线上 小节的单位长度值(默认为1)
            element_iter.value().measure_value_unit = iter.value().data.toDouble();
        }
        else
        {
            qDebug() << "Error: can't find measure: " << iter.value().measure_value;
            return false;
        }
        iter++;
    }

    // 3 在时间线上 标注BPM开始变化的点
    iter = bms_data_.all_bpm_notes_.begin();
    while(iter != bms_data_.all_bpm_notes_.end())
    {
        TimeLineElementMapIter element_iter = measurevalue_timelineelement_map_.find(iter.value().measure_value);
        if(element_iter != measurevalue_timelineelement_map_.end())
        {
            element_iter.value().start_time = -1.0;
            //element_iter.value().measure_value is setted
            element_iter.value().bpm_value  = iter.value().data.toDouble();
            //element_iter.value().measure_value_unit is setted
        }
        else
        {
            element.start_time = -1.0;
            element.start_measure_value = iter.value().measure_value;
            element.bpm_value = iter.value().data.toDouble();
            element.measure_value_unit = -1.0;
        }
        iter++;
    }

    // 4 修改时间线上 小节点的BPM值
    //double current_bpm_value = bms_data_.

    return true;
}

/*
double BMSData::ConvertMeasureValueToMilliSecond(double measure_value)
{
    double  millisecond = 0.0;

    bool convert_to_double_success = false;
    double  current_measure_bpm_value = define_field_.value(kBpmDefine).toDouble(&convert_to_double_success);
    if(!convert_to_double_success)
    {
        qDebug() << "Convert_To_Double_Failed";
        qApp->exit();
    }
    QList<BMSNote> all_bpm_notes = all_bpm_notes_.values();
    qSort(all_bpm_notes.begin(),all_bpm_notes.end(),MeasureValueIsLessThan);
    foreach(const BMSNote& bpm_note, all_bpm_notes)
    {
        if(bpm_note.measure_value > measure_value)
        {
            break;
        }
    }
    return millisecond;
}



double BMSData::GetBpmValueWithMeasureValue(double measure_value)
{
    bool convert_to_double_success = false;
    double  current_measure_bpm_value = define_field_.value(kBpmDefine).toDouble(&convert_to_double_success);
    if(!convert_to_double_success)
    {
        qDebug() << "Convert_To_Double_Failed";
        qApp->exit();
    }
    QList<BMSNote> all_bpm_notes = all_bpm_notes_.values();
    qSort(all_bpm_notes.begin(),all_bpm_notes.end(),MeasureValueIsLessThan);
    foreach(const BMSNote& bpm_note,all_bpm_notes)
    {
        if(bpm_note.measure_value > measure_value)
        {
            break;
        }
        convert_to_double_success = false;
        current_measure_bpm_value = (bpm_note.data).toDouble(&convert_to_double_success);
        if(!convert_to_double_success)
        {
            qDebug() << "Convert_To_Double_Failed";
            qApp->exit();
        }
    }
    return current_measure_bpm_value;
}


int BMSData::GetMaxMeasureNumber(const BMSFileContent &bms_file_content)
{
    QVector<BMSDataFieldElement> bms_data_fields = bms_file_content.data_field;
    qSort(bms_data_fields.begin(),bms_data_fields.end(),MeasureNumberIsLessThan);
    int max_measure_number = 0;
    int temp_data_count = bms_data_fields.count();
    if(temp_data_count > 0)
    {
        max_measure_number = bms_data_fields.at(temp_data_count-1);
        max_measure_number += 1;
    }
    return max_measure_number;
}

bool BMSData::CreateMeasureTimeMap(int max_measure_number)
{
    for(int i=0; i<max_measure_number; i++)
    {
    }
}
*/
