import 'package:flutter/material.dart';
import '/domain/info/graphs/abstract_bucket.dart';
import '/domain/info/graphs/abstract_graph.dart';
import '/ui/chart/chart_settings.dart';
import '/ui/util.dart';

class Chart extends StatefulWidget {

  final ChartBuilder chartBuilder;

  const Chart(this.chartBuilder, {super.key});

  @override
  State<Chart> createState() => _Chart();
}

enum Span{
  month3(0,3,0),
  month6(0,6,0),
  year(0,0,1),
  all(0,0,0);

  final int days;
  final int months;
  final int years;

  const Span(this.days, this.months, this.years);

  String get  label {
    switch(this){
      case Span.month3: return "last 3 months";
      case Span.month6: return "last 6 months";
      case Span.year: return "last year";
      case Span.all: return "all";
    }}
}

enum CharType{
  histogram(),
  line();
}

enum CharWidget{
  orm(CharType.line),
  wight(CharType.line),
  volume(CharType.line),

  reps(CharType.histogram),
  sets(CharType.histogram),
  perWight(CharType.histogram),
  perVolume(CharType.histogram),
  duration(CharType.histogram);

  final CharType type;

  const CharWidget(this.type);

  String get label {
    switch(this){
      case CharWidget.orm: return "One-Rep-Max";
      case CharWidget.wight: return "Max Weight";
      case CharWidget.volume: return "Max Set Volume";

      case CharWidget.reps: return "Total Reps";
      case CharWidget.sets: return "Total Sets";
      case CharWidget.duration: return "duration";
      case CharWidget.perVolume: return "% Volume";
      case CharWidget.perWight: return "% Weight";
    }
  }
}

class _Chart extends State<Chart> with AutomaticKeepAliveClientMixin<Chart> {

  @override
  bool get wantKeepAlive => true;

  CharWidget chartWidget = CharWidget.orm;

  Span duration = Span.month3;
  History history = History.individual;
  bool currentTime = false;
  AggregationLevel aggregationLevel = AggregationLevel.week;
  //ChartBuilder? chartBuilder; 


  void setChart(ChartBuilder cb){
    //setState(() => chartBuilder = cb);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    //chartBuilder ??= widget.defaultChart;
    Widget? chart = widget.chartBuilder.build(history: history , level:aggregationLevel, currentTime:currentTime, days:duration.days, months: duration.months, years: duration.years);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 10,
      children:[
      Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.end, children: [
          Text("Current Time:"),
          Switch(value: currentTime, onChanged:(t) => setState(() => currentTime = t)),
        ]
      ),
      Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(chartWidget.type == CharType.line)chartHistorySelect(history, (h) => setState(() => history = h )),
          if(chartWidget.type == CharType.histogram)chartAggregationLevel(aggregationLevel, (a) => setState(() => aggregationLevel = a )),
          timeDropDown(duration, (s) => setState(() => duration = s))
        ],
      ),
      chart,
      ]);
  }
}

Widget timeDropDown(Span defaultSpan, void Function(Span) setSpan){

  final entries = Span.values.map((s) => DropdownMenuEntry(
                value: s,
                label: s.label
                )).toList();

  return  dropdown<Span>(
    selection: defaultSpan,
    hintText: 'Set time frame',
    menuHeight: 400,
    onSelected: (v) => setSpan(v??defaultSpan),
    entries:  entries,
    label: (s) => s == null ? defaultSpan.label : s.label,
  );
}

Widget chartAggregationLevel(AggregationLevel level, void Function(AggregationLevel) onChanged ){

  final entries = AggregationLevel.values.map((s) => DropdownMenuEntry(
                value: s,
                label: s.label
                )).toList();

  return  dropdown<AggregationLevel>(
    selection: level,
    hintText: 'Set aggregationLevel',
    menuHeight: 400,
    onSelected: (v) => onChanged(v ?? level),
    entries:  entries,
    label: (s) => s == null ? level.label : s.label,
  );

}

SegmentedButton<History> chartHistorySelect(History history, void Function(History) onChanged){

  return SegmentedButton<History>(
    selected: {history},
    onSelectionChanged: (v) => onChanged(v.first),
    segments: [History.individual, History.complete].map((t) => 
      ButtonSegment<History>(
        value: t,
        label: Text(t.label),
      )).toList(),
  );
}

