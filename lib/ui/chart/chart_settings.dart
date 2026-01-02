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

  LineChartSettings(super.id, super.data, {super.xLabelFixed = 0, super.yLabelFixed=2});

  factory LineChartSettings.orm(Graphs graphs){
    return LineChartSettings("One-Rep-Max", graphs.ormOverTime);
  }

  factory LineChartSettings.weight(Graphs graphs){
    return LineChartSettings("Max Weight", graphs.weightOverTime);
  }

  factory LineChartSettings.volume(Graphs graphs){
    return LineChartSettings("Max Set Volume", graphs.volumeOverTime, yLabelFixed:0);
  }

}

class BucketChartSettings extends ChartSettings {
  
  final double? bucketSize;
  final double? start;
  final double? end;
  final bool over;
  final bool under;
  final bool xPer;

  BucketChartSettings(super.id, super.data, {super.xLabelFixed = 0, super.yLabelFixed=2,this.bucketSize, this.start, this.end, this.xPer=false, this.over=true, this.under=true});

  factory BucketChartSettings.reps(BucketGraphs graphs){
    return BucketChartSettings("Total Reps", graphs.repsOverTime, bucketSize: 1, start: 1, end:12, over: true);
  }

  factory BucketChartSettings.sets(BucketGraphs graphs){
    return BucketChartSettings("sets", graphs.setsOverTime, bucketSize: 2, start: 1, end: 10, over: true);
  }

  factory BucketChartSettings.perWeight(BucketGraphs graphs){
    return BucketChartSettings("% Weight", graphs.perWeightOverTime, xPer: true, bucketSize: 0.1, start: 0, end: 1);
  }

  factory BucketChartSettings.perVolume(BucketGraphs graphs){
    return BucketChartSettings("% Volume", graphs.perVolumeOverTime, xPer: true, bucketSize: 0.1, start: 0, end: 1);
  }

  factory BucketChartSettings.duration(BucketGraphs graphs){
    final minutes = graphs.duration.map((d) => d.inMinutes).toList();
    return BucketChartSettings("% Volume", minutes, xPer: true, start: 30, end: 60*2, over: true, under:true);
  }
}

abstract class ChartBuilder<T extends ChartSettings>{

  final T settings;

  ChartBuilder(this.settings);

  Widget chart({History? history, AggregationLevel? level, bool currentTime = true, int days = 0, int months = 0, int years = 0});

  String get id => settings.id;
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
  Widget chart({History? history, AggregationLevel? level,bool currentTime = true, int days = 0, int months = 0, int years = 0}) {
    level = level ?? AggregationLevel.workout;
    final histogram = graphs.getLatestHistogram(settings.data, start: settings.start, end: settings.end ,level:level, currentTime:currentTime, days: days, months: months, years: years);
    final xy = histogram.getData(under:settings.under, over: settings.over, percentage: settings.xPer);
    return HistogramChart(xy.x, xy.y.toList(), fixedX: settings.xLabelFixed);
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
  Widget chart({History? history, AggregationLevel? level, bool currentTime = true, int days = 0, int months = 0, int years = 0}) {
    history = history ?? History.individual;
    final data = settings.data;
    final xy = graphs.getLatestGraphData(data, history, currentTime:currentTime, days: days, months: months, years: years);
    return BasicLineChart(xy.keys.toList(), xy.values.toList());
  }

}
