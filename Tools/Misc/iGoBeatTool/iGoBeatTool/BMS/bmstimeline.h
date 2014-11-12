#ifndef BMSTIMELINE_H
#define BMSTIMELINE_H
#include "BMS/bmsdata.h"

struct BMSTimeLineElement
{
    double      start_time;
    double      start_measure_value;
    double      bpm_value;
    double      measure_value_unit;
};

class BMSTimeLine
{
public:
    BMSTimeLine(const BMSData& bms_data);

private: //create BMSTimeLineElement
    bool    CreateBMSTimeLine();
    bool    CreateTempBMSTimeLine();
//    double  ConvertMeasureValueToMilliSecond(double measure_value);
//    double  GetBpmValueWithMeasureValue(double measure_value);
//    /**
//      @function:    GetMaxMeasureNumber
//      @return:      返回最大的小节编号
//      @note:        e.g. bms文件中的小节编号为000-019,则返回20.
//    */
//    int     GetMaxMeasureNumber(const BMSFileContent& bms_file_content);
//    bool    CreateMeasureTimeMap(int max_measure_number);

    /**
      @variable:    measure_time_map_
      @key:         measure_number(小节编号,为整数)
      @value:       该小节对应的起始时间
    */
    QMap<int,double>   measure_time_map_;

    /**
      @variable:    measure_time_map_
      @key:         measure_number(小节编号,为整数)
      @value:       该小节对应的起始时间
    */
    QMap<double,double>   bpmnote_time_map_;

    typedef QMap<double,BMSTimeLineElement> TimeLineElementMap;
    typedef TimeLineElementMap::Iterator TimeLineElementMapIter;
    /**
      @variable:    measurevalue_timelineelement_map_
      @key:         measure_value(小节值,为分数)
      @value:       该小节值对应的TimeLineElement
    */
    TimeLineElementMap   measurevalue_timelineelement_map_;

    BMSData bms_data_;
};

#endif // BMSTIMELINE_H
