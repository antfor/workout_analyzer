import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/graphs/abstract_graph.dart';
import 'package:test_flutter/domain/info/graphs/graphs.dart';
import 'package:test_flutter/ui/chart/line_chart.dart';
import 'package:test_flutter/ui/util.dart';

class Chart extends StatefulWidget {

  final Graphs graphs; 
  const Chart(this.graphs,{super.key});

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
  orm,
  wight,
  volume;

  String get label {
    switch(this){
      case CharType.orm: return "One-Rep-Max";
      case CharType.wight: return "Max Weight";
      case CharType.volume: return "Max Set Volume";
    }
  }
}

class _Chart extends State<Chart> {

  Span duration = Span.month3;
  CharType type = CharType.orm;
  History history = History.indevidual;
  bool currentTime = false;

  @override
  Widget build(BuildContext context) {

     
    List<double> data; 

    switch(type){
      case CharType.orm: data=widget.graphs.ormOverTime; break;
      case CharType.wight: data=widget.graphs.weightOverTime; break;
      case CharType.volume: data=widget.graphs.volumeOverTime; break;
    }

    final xy = widget.graphs.getLatestGraphData(data, history, currentTime:currentTime, days:duration.days, months: duration.months, years: duration.years);

    final x = xy.keys.toList();
    final y = xy.values.toList();

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
      BasicLineChart(x, y),
      chartTypeSelect(type, (CharType t) => setState(() => type = t)),
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

SegmentedButton<CharType> chartTypeSelect(CharType type, void Function(CharType) onChanged){

  return SegmentedButton<CharType>(
    selected: {type},
    onSelectionChanged: (v) => onChanged(v.first),
    segments: CharType.values.map((t) => 
      ButtonSegment<CharType>(
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

