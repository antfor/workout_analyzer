import 'dart:math' as math;
import 'package:test_flutter/domain/info/graphs/abstract_graph.dart';
import 'package:test_flutter/domain/info/graphs/histogram.dart';


enum {
  workout,
  week,
  month,
  year,
}

//TODO per Month, per week. per year
//now only per workout
//can be done by looking a time, to shorten and taking avrages
abstract class Bucket extends Graph{

  Histogram _getHistogram<T extends num>(Iterable<T> data, double? start, double? end, double? bin){

    final binWidth = bin ?? _scott(data);
    final max = end ?? data.reduce(math.max);
    final min = start ?? data.reduce(math.min);
    if(binWidth == 0 || max < min){
      return Histogram.empty();
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


  Histogram getHistogram<T extends num>(List<T> data, {double? start, double? end, double? bin, DateTime? startDate, DateTime? endDate}){

    //DateTime? startDate, DateTime? endDate
    final low = startDate == null ? 0 : time.indexWhere((d) => 0 <= startDate.compareTo(d));
    final len = math.min(data.length, time.length);
    int high = endDate == null ?  len :  time.indexWhere((d) => d.isAfter(endDate));

    if(low == -1 || high < low){
      return Histogram.empty();
    }
    high = high == -1 ? len : high;

    return _getHistogram(data.getRange(low, high),start,end,bin);
  } 

  Histogram getLatestHistogram<T extends num>(List<T> data, {double? start, double? end, double? bin, bool currentTime=true, int days=0, int months=0,int years=0}){
    final endDate = currentTime ?  DateTime.now() : time.last;

    if([years,months,days].every((p) => 0 == p)){
      return getHistogram(data, start:start, end:end, bin:bin, endDate:endDate);
    }

    final startDate =DateTime(endDate.year - years, endDate.month - months, endDate.day - days);

    return getHistogram(data, start:start, end:end, bin:bin, startDate:startDate, endDate:endDate);
  } 

}

double _scott<T extends num>(Iterable<T> data){
    final sd = _sampleStandardDeviation(data);
    final cbrtN = math.pow(data.length, 1.0/3.0);

    return 3.49 * sd / cbrtN;
}

double _sampleStandardDeviation<T extends num>(Iterable<T> data) {
  if (data.isEmpty) return 0;

  double mean = data.reduce((a, b) => (a + b) as T) / data.length;

  return math.sqrt(data.map((x) => math.pow(x - mean, 2))
            .reduce((a, b) => a + b) / (data.length - 1));

}