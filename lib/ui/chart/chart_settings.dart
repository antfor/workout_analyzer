import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/graphs/abstract_bucket.dart';
import 'package:test_flutter/domain/info/graphs/abstract_graph.dart';
import 'package:test_flutter/domain/info/graphs/bucket_graphs.dart';
import 'package:test_flutter/domain/info/graphs/graphs.dart';
import 'package:test_flutter/ui/chart/histogram.dart';
import 'package:test_flutter/ui/chart/line_chart.dart';

abstract class ChartSettings{

  final int xLabelFixed;
  final int yLabelFixed;
  final String id; 
  final List<num> data;

  ChartSettings(this.id,this.data,{this.xLabelFixed = 0, this.yLabelFixed=2});
}


class LineChartSettings extends ChartSettings {

  final Graphs graphs;

  LineChartSettings(super.id, super.data, this.graphs, {super.xLabelFixed = 0, super.yLabelFixed=2});

  factory LineChartSettings.orm(Graphs graphs){
    return LineChartSettings("One-Rep-Max", graphs.ormOverTime, graphs);
  }

  factory LineChartSettings.wight(Graphs graphs){
    return LineChartSettings("Max Weight", graphs.weightOverTime, graphs);
  }

  factory LineChartSettings.volume(Graphs graphs){
    return LineChartSettings("Max Set Volume", graphs.volumeOverTime, graphs, yLabelFixed:0);
  }
  
  Widget chart(History history,{bool currentTime = true, int days = 0, int months = 0, int years = 0}) {
    final xy = graphs.getLatestGraphData(data, history, currentTime:currentTime, days: days, months: months, years: years);
    return BasicLineChart(xy);
  }

}

class BucketChartSettings extends ChartSettings {
  
  final double? buckteSize;
  final double? start;
  final double? end;
  final bool over;
  final bool under;
  final bool xPer;
  final BucketGraphs graphs;

  BucketChartSettings(super.id, super.data, this.graphs, {super.xLabelFixed = 0, super.yLabelFixed=2,this.buckteSize, this.start, this.end, this.xPer=false, this.over=true, this.under=true});

  factory BucketChartSettings.reps(BucketGraphs graphs){
    return BucketChartSettings("Total Reps", graphs.repsOverTime, graphs, buckteSize: 1, start: 1, end:12, over: true);
  }

  factory BucketChartSettings.sets(BucketGraphs graphs){
    return BucketChartSettings("sets", graphs.setsOverTime, graphs, buckteSize: 2, start: 1, end: 10, over: true);
  }

  factory BucketChartSettings.perWight(BucketGraphs graphs){
    return BucketChartSettings("% Weight", graphs.perWeightOverTime, graphs, xPer: true, buckteSize: 0.1, start: 0, end: 1);
  }

  factory BucketChartSettings.perVolume(BucketGraphs graphs){
    return BucketChartSettings("% Volume", graphs.perVolumeOverTime, graphs, xPer: true, buckteSize: 0.1, start: 0, end: 1);
  }

  factory BucketChartSettings.duaration(BucketGraphs graphs){
    final minutes = graphs.duration.map((d) => d.inMinutes).toList();
    return BucketChartSettings("% Volume", minutes, graphs, xPer: true, start: 30, end: 60*2, over: true, under:true);
  }
  
  Widget chart(AggregationLevel level,{bool currentTime = true, int days = 0, int months = 0, int years = 0}) {
    final xy = graphs.getLatestHistogram(data, start: start, end: end ,level:level, currentTime:currentTime, days: days, months: months, years: years);
    return HistogramChart(xy);
  }

}