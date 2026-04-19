import 'package:flutter/material.dart';
import 'package:workout_analyzer/ui/chart/chart.dart';
import '/domain/info/graphs/bucket_graphs.dart';
import '/domain/info/graphs/graphs.dart';
import '/ui/chart/chart_settings.dart';

class ExrchiseChart extends StatefulWidget {

  final Graphs graphs; 
  final BucketGraphs histogram; 
  const ExrchiseChart(this.graphs,this.histogram,{super.key});

  @override
  State<ExrchiseChart> createState() => _Chart();
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

class _Chart extends State<ExrchiseChart> {

  CharWidget chartWidget = CharWidget.orm;

  @override
  Widget build(BuildContext context) {

    ChartBuilder chartBuilder; 
    switch(chartWidget){
      case CharWidget.orm: chartBuilder = LineChartBuilder.orm(widget.graphs); break;
      case CharWidget.wight: chartBuilder = LineChartBuilder.weight(widget.graphs); break;
      case CharWidget.volume: chartBuilder = LineChartBuilder.volume(widget.graphs); break;

      case CharWidget.perWight: chartBuilder = BucketChartBuilder.perWeight(widget.histogram); break;
      case CharWidget.reps: chartBuilder = BucketChartBuilder.reps(widget.histogram); break;
      case CharWidget.sets: chartBuilder = BucketChartBuilder.sets(widget.histogram); break;
      case CharWidget.perVolume: chartBuilder = BucketChartBuilder.perVolume(widget.histogram); break;
      case CharWidget.duration: chartBuilder = BucketChartBuilder.duration(widget.histogram); break;
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

Widget chartTypeSelect(CharWidget type, void Function(CharWidget) onChanged){//TODO duplicate in CardioChart

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
      segmentedButton(line),
      segmentedButton(histogram),
    ],
  );
}