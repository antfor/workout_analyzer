import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/graphs/abstract_bucket.dart';
import 'package:test_flutter/domain/info/graphs/abstract_graph.dart';
import 'package:test_flutter/domain/info/graphs/bucket_graphs.dart';
import 'package:test_flutter/domain/info/graphs/graphs.dart';
import 'package:test_flutter/ui/chart/histogram.dart';
import 'package:test_flutter/ui/chart/line_chart.dart';

//TODO dela upp  filer

abstract class ChartSettings{

  final int xLabelFixed;
  final int yLabelFixed;
  final List<num> data;

  ChartSettings(this.data,{this.xLabelFixed = 0, this.yLabelFixed=2});
}

class LineChartSettings extends ChartSettings {

  LineChartSettings(super.data, {super.xLabelFixed = 0, super.yLabelFixed=2});

  factory LineChartSettings.orm(Graphs graphs){
    return LineChartSettings(graphs.ormOverTime);
  }

  factory LineChartSettings.weight(Graphs graphs){
    return LineChartSettings(graphs.weightOverTime);
  }

  factory LineChartSettings.volume(Graphs graphs){
    return LineChartSettings(graphs.volumeOverTime, yLabelFixed:0);
  }

}

class BucketChartSettings extends ChartSettings {
  
  final double? bucketSize;
  final double? start;
  final double? end;
  final bool over;
  final bool under;
  final bool xPer;

  BucketChartSettings(super.data, {super.xLabelFixed = 0, super.yLabelFixed=2,this.bucketSize, this.start, this.end, this.xPer=false, this.over=true, this.under=true});

  factory BucketChartSettings.reps(BucketGraphs graphs){
    return BucketChartSettings(graphs.repsOverTime, over: true);
  }

  factory BucketChartSettings.sets(BucketGraphs graphs){
    return BucketChartSettings(graphs.setsOverTime, over: true);
  }

  factory BucketChartSettings.perWeight(BucketGraphs graphs){
    return BucketChartSettings(graphs.perWeightOverTime, xPer: true, bucketSize: 0.1, start: 0.5, end: 1, xLabelFixed:0, over:false);
  }

  factory BucketChartSettings.perVolume(BucketGraphs graphs){
    return BucketChartSettings(graphs.perVolumeOverTime, xPer: true, bucketSize: 0.1, start: 0.4, end: 1, xLabelFixed:0, over:false);
  }

  factory BucketChartSettings.duration(BucketGraphs graphs){
    final minutes = graphs.duration.map((d) => d.inMinutes).toList();
    return BucketChartSettings(minutes, over: true, under:true);
  }
}

abstract class ChartBuilder<T extends ChartSettings>{

  final T settings;

  ChartBuilder(this.settings);

  Widget build({History? history, AggregationLevel? level, bool currentTime = true, int days = 0, int months = 0, int years = 0});

}


class BucketChartBuilder extends ChartBuilder<BucketChartSettings>{

  final BucketGraphs graphs;

  BucketChartBuilder._(this.graphs, super.settings);

  factory BucketChartBuilder.reps(BucketGraphs graphs){
    return BucketChartBuilder._(graphs, BucketChartSettings.reps(graphs));
  }

  factory BucketChartBuilder.sets(BucketGraphs graphs){
    return BucketChartBuilder._(graphs, BucketChartSettings.sets(graphs));
  }

  factory BucketChartBuilder.duration(BucketGraphs graphs){
    return BucketChartBuilder._(graphs, BucketChartSettings.duration(graphs));
  }

  factory BucketChartBuilder.perVolume(BucketGraphs graphs){
    return BucketChartBuilder._(graphs, BucketChartSettings.perVolume(graphs));
  }

  factory BucketChartBuilder.perWeight(BucketGraphs graphs){
    return BucketChartBuilder._(graphs, BucketChartSettings.perWeight(graphs));
  }

  @override
  Widget build({History? history, AggregationLevel? level,bool currentTime = true, int days = 0, int months = 0, int years = 0}) {
    level = level ?? AggregationLevel.workout;
    final histogram = graphs.getLatestHistogram(settings.data, start: settings.start, end: settings.end ,bin: settings.bucketSize, level:level, currentTime:currentTime, percentage: settings.xPer, xPrecision: settings.xLabelFixed, days: days, months: months, years: years);
    final xy = histogram.getData(under:settings.under, over: settings.over, percentage: true);
    return HistogramChart(xy.x, xy.y.toList(), fixedX: settings.xLabelFixed, percentage: settings.xPer);
  }

}

class LineChartBuilder extends ChartBuilder<LineChartSettings> {

  final Graphs graphs;

  LineChartBuilder._(this.graphs, super.settings);

  factory LineChartBuilder.orm(Graphs graphs){
    return LineChartBuilder._(graphs, LineChartSettings.orm(graphs));
  }

  factory LineChartBuilder.weight(Graphs graphs){
    return LineChartBuilder._(graphs, LineChartSettings.weight(graphs));
  }

  factory LineChartBuilder.volume(Graphs graphs){
    return LineChartBuilder._(graphs, LineChartSettings.volume(graphs));
  }

  @override
  Widget build({History? history, AggregationLevel? level, bool currentTime = true, int days = 0, int months = 0, int years = 0}) {
    history = history ?? History.individual;
    final data = settings.data;
    final xy = graphs.getLatestGraphData(data, history, currentTime:currentTime, days: days, months: months, years: years);
    return BasicLineChart(xy.keys.toList(), xy.values.toList());
  }

}
