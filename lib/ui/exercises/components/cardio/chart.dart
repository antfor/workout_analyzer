import 'package:flutter/material.dart';
import 'package:workout_analyzer/domain/info/cardio/cardio_graphs.dart';
import 'package:workout_analyzer/ui/chart/chart.dart';
import '/ui/chart/chart_settings.dart';

class CardioChart extends StatefulWidget {

  final CardioGraphs graphs; 
  //final BucketGraphs histogram; 
  const CardioChart(this.graphs,{super.key});

  @override
  State<CardioChart> createState() => _Chart();
}


enum CharWidget{
  pace(CharType.line),
  duration(CharType.line),
  distance(CharType.line);

  final CharType type;

  const CharWidget(this.type);

  String get label {
    switch(this){
      case CharWidget.pace: return "Pace (min/km)";
      case CharWidget.duration: return "Duration";
      case CharWidget.distance: return "Distance (km)";

    }
  }
}

class _Chart extends State<CardioChart> {

  CharWidget chartWidget = CharWidget.pace;
  double? min;
  double? max;

  @override
  Widget build(BuildContext context) {

    ChartBuilder chartBuilder; 
    switch(chartWidget){
      case CharWidget.pace: chartBuilder = LineChartBuilder.pace(widget.graphs, min:min, max:max); break;
      case CharWidget.duration: chartBuilder = LineChartBuilder.duration(widget.graphs, min:min, max:max); break;
      case CharWidget.distance: chartBuilder = LineChartBuilder.distance(widget.graphs, min:min, max:max); break;
    }
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 10,
      children:[
      Chart(chartBuilder, chartWidget.type),
      chartTypeSelect(chartWidget, (CharWidget t) => setState(() => chartWidget = t)),
      ]);
  }
}

Widget chartTypeSelect(CharWidget type, void Function(CharWidget) onChanged){

  final line = CharWidget.values.where((w)=>w.type == CharType.line);
  final histogram =CharWidget.values.where((w)=>w.type == CharType.histogram);

  SegmentedButton<CharWidget> segmentedButton (Iterable<CharWidget> list) => 
    SegmentedButton<CharWidget>(
      selected: {type},
      onSelectionChanged: (v) => onChanged(v.first),
      showSelectedIcon: false,
      segments: list.map((t) => 
        ButtonSegment<CharWidget>(
          value: t,
          label: Text(t.label, maxLines: 1, overflow: TextOverflow.fade,),
        )).toList(),
    );

  return Column( 
    crossAxisAlignment: CrossAxisAlignment.end,
    spacing: 5,
    children: [
      if(line.isNotEmpty) segmentedButton(line),
      if(histogram.isNotEmpty) segmentedButton(histogram),
    ],
  );
}