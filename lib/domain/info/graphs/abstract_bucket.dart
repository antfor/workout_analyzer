import 'dart:math' as math;
import 'package:test_flutter/domain/info/graphs/abstract_graph.dart';
import 'package:test_flutter/domain/info/graphs/histogram.dart';



//TODO per Month, per week. per year
//now only per workout
// can be done by looking a time, to shorten and taking avrages
abstract class Bucket extends Graph{

  Histogram getHistogram<T extends num>(List<T> data, double? start, double? end, double? bin){

    final binWidth = bin ?? _scott(data);
    final max = end ?? data.reduce(math.max);
    final min = start ?? data.reduce(math.min);
    if(binWidth == 0){
      throw HistogramError('bin width is zero');
    } else if(max < min){
      throw HistogramError('start is bigger then end');
    }
    final k = ((max-min)/binWidth).ceil();

    final bins = List.generate(k, (i) => min + binWidth * i);  
   
    final histogram = bins.map((l) => data.where((d)=> l <= d && d < (l + binWidth) && d <= max).length);

    final over = data.where((d)=> max < d).length;
    final under = data.where((d)=> d < min).length;

    return Histogram(
      histogram: histogram,
      over: over,
      under: under,
      max: max.toDouble(),
      min: min.toDouble(),
      binWidth: binWidth,

    );
  }  

}

double _scott<T extends num>(List<T> data){
    final sd = _sampleStandardDeviation(data.cast<double>());
    final cbrtN = math.pow(data.length, 1.0/3.0);

    return 3.49 * sd / cbrtN;
}

double _sampleStandardDeviation<T extends num>(List<double> data) {
  if (data.isEmpty) return 0;

  double mean = data.reduce((a, b) => a + b) / data.length;

  return math.sqrt(data.map((x) => math.pow(x - mean, 2))
            .reduce((a, b) => a + b) / (data.length - 1));

}

class HistogramError implements Exception {
  final String message;
  HistogramError(this.message);
  @override String toString() => 'HistogramError: $message';
}