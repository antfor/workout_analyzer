import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/graphs/abstract_bucket.dart';
import 'package:test_flutter/domain/info/graphs/abstract_graph.dart';
import 'package:test_flutter/domain/info/graphs/bucket_graphs.dart';
import 'package:test_flutter/domain/info/graphs/graphs.dart';
import 'package:test_flutter/ui/chart/histogram.dart';
import 'package:test_flutter/ui/chart/line_chart.dart';
import 'package:test_flutter/ui/util.dart';

class Chart extends StatefulWidget {

  final Graphs graphs; 
  final BucketGraphs histogram; 
  const Chart(this.graphs,this.histogram,{super.key});

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

enum CharData{
  orm(CharType.line),
  wight(CharType.line),
  volume(CharType.line),

  perWight(CharType.histogram),
  reps(CharType.histogram);

  final CharType type;

  const CharData(this.type);

  String get label {
    switch(this){
      case CharData.orm: return "One-Rep-Max";
      case CharData.wight: return "Max Weight";
      case CharData.volume: return "Max Set Volume";

      case CharData.perWight: return "% Weight";
      case CharData.reps: return "Total Reps";
    }
  }
}

class _Chart extends State<Chart> {

  Span duration = Span.month3;
  CharData chartData = CharData.reps;
  History history = History.indevidual;
  bool currentTime = false;
  AggregationLevel histogramBin = AggregationLevel.workout;

  @override
  Widget build(BuildContext context) {

    List<num> data; 
    switch(chartData){
      case CharData.orm: data=widget.graphs.ormOverTime; break;
      case CharData.wight: data=widget.graphs.weightOverTime; break;
      case CharData.volume: data=widget.graphs.volumeOverTime; break;

      case CharData.perWight: data=widget.histogram.perWeightOverTime; break;
      case CharData.reps: data=widget.histogram.repsOverTime; break;
    }
    data.map(print).toList();
    Widget chart;
    switch(chartData.type){
      case CharType.line:
        final xy = widget.graphs.getLatestGraphData(data, history, currentTime:currentTime, days:duration.days, months: duration.months, years: duration.years);
        chart = BasicLineChart(xy);
        break;
      case CharType.histogram: 
        final histogramData = widget.histogram.getLatestHistogram(data,currentTime:currentTime, days:duration.days, months: duration.months, years: duration.years, level:histogramBin);
        chart = HistogramChart(histogramData);
        break;
    }

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
          chartHistorySelect(history, (h) => setState(() => history = h )),
          timeDropDown(duration, (s) => setState(() => duration = s))
        ],
      ),
      chart,
      chartTypeSelect(chartData, (CharData t) => setState(() => chartData = t)),
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

SegmentedButton<CharData> chartTypeSelect(CharData type, void Function(CharData) onChanged){

  return SegmentedButton<CharData>(
    selected: {type},
    onSelectionChanged: (v) => onChanged(v.first),
    segments: CharData.values.map((t) => 
      ButtonSegment<CharData>(
        value: t,
        label: Text(t.label),
      )).toList(),
  );
}

SegmentedButton<History> chartHistorySelect(History history, void Function(History) onChanged){

  return SegmentedButton<History>(
    selected: {history},
    onSelectionChanged: (v) => onChanged(v.first),
    segments: [History.indevidual, History.complete].map((t) => 
      ButtonSegment<History>(
        value: t,
        label: Text(t.label),
      )).toList(),
  );
}

