import 'dart:math' as math;
import 'package:intl/intl.dart';
import '/domain/info/graphs/abstract_graph.dart';
import '/domain/info/graphs/histogram.dart';


enum AggregationLevel{
  workout,
  day,
  week ,
  month,
  year;

  String get label {
    switch(this){
      case AggregationLevel.workout: return "Workout";
      case AggregationLevel.day: return "Day";
      case AggregationLevel.week: return "Week";
      case AggregationLevel.month: return "Month";
      case AggregationLevel.year: return "Year";
    }
  }

  int get days {
    switch(this){
      case AggregationLevel.workout: return 1;
      case AggregationLevel.day: return 1;
      case AggregationLevel.week: return 7;
      case AggregationLevel.month: return 30;
      case AggregationLevel.year: return 365;
    }
  }
}

abstract class Bucket extends Graph{

  Histogram _getHistogram(List<(DateTime,num)>xy, double? start, double? end, double? bin, int? xPrecision, bool barChart){

    final data = xy.map((xy) => xy.$2);
    final max = end ?? data.fold<num>(-double.maxFinite,math.max);
    final min = start ?? data.fold<num>(double.maxFinite,math.min);

    if(max < min){
      return Histogram.empty();
    }

    if(barChart){
      return Histogram(
      histogram: data.where((d) => min <= d && d <= max),
      over: data.where((d) => d > max).length,
      under: data.where((d) => min > d).length,
      max: max.toDouble(),
      min: min.toDouble(),
      binWidth: 0,
      labels: xy.map((xy) => xy.$1),
     );
    }

    final binWidth = bin ?? _scott(data, xPrecision);

    if(binWidth == 0){
      return Histogram.empty();
    }
    final k = math.max(((max-min)/binWidth).ceil(),1);

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

  List<(DateTime,num)> _aggregateData<T extends num>(List<T> data, int start, int end, AggregationLevel level, bool percentage){
    bool Function(DateTime a, DateTime b) isSame;

    switch(level){
      case AggregationLevel.day:
        isSame = (DateTime a, DateTime b) => (a.year == b.year && a.month == b.month && a.day == b.day);
        break;
      case AggregationLevel.week: 
        isSame = (DateTime a, DateTime b)
              {final wa = getWeekNumber(a);
               final wb = getWeekNumber(b);
              return (wa.weekYear == wb.weekYear && wa.week == wb.week);};
        break; 
      case AggregationLevel.month: 
        isSame = (DateTime a, DateTime b) => (a.year == b.year && a.month == b.month);  
        break; 
      case AggregationLevel.year: 
        isSame = (DateTime a, DateTime b) => a.year == b.year;  
        break; 
      default: 
        final y = data.getRange(start, end).toList();
        final x = time.getRange(start, end).toList();
        return List.generate(x.length, (i) => (x[i],y[i]));
    }

    final List<(DateTime,double)> aggregated = [];
    List<T> group = [];
    DateTime x = time[start]; 
    
  
    double mean (Iterable<T> l)=> l.fold<double>(0,(a,b) => (a + b))/l.length;
    double add (Iterable<T> l)=> l.fold<double>(0,(a,b) => (a + b));
    final groupUp = percentage ? mean : add;

    for(int i = start; i < end; i++){
      if (group.isEmpty || isSame(time[i], time[i - 1])) {
       group.add(data[i]);
      } else {
        aggregated.add((x,groupUp(group)));
        group = [data[i]];
        x = time[i];
      }
    }

    if (group.isNotEmpty) {
      aggregated.add((x, groupUp(group)));
    }
    
    return aggregated;
  }

  Histogram getHistogram<T extends num>(List<T> data, {double? start, double? end, double? bin, DateTime? startDate, DateTime? endDate, AggregationLevel level = AggregationLevel.workout, bool percentage = false, int? xPrecision, bool barChart = false}){

    if(data.isEmpty || time.isEmpty){
      return Histogram.empty();
    }

    final low = startDate == null ? 0 : time.indexWhere((d) => 0 >= startDate.compareTo(d));

    final len = math.min(data.length, time.length);
    int high = endDate == null ?  len :  time.indexWhere((d) => d.isAfter(endDate));
    high = high == -1 ? len : high;

    if(low == -1 || high < low){
      return Histogram.empty();
    }        

    final list = _aggregateData(data, low, high, level, percentage);
    return _getHistogram(list,start,end,bin,xPrecision,barChart);
  } 

  Histogram getLatestHistogram<T extends num>(List<T> data, {double? start, double? end, double? bin, bool currentTime=true, int days=0, int months=0,int years=0, AggregationLevel level = AggregationLevel.workout, bool percentage = false, int? xPrecision, barChart = false}){
    
    if(data.isEmpty || time.isEmpty){
      return Histogram.empty();
    }
    
    final endDate = currentTime ?  DateTime.now() : time.last;

    if([years,months,days].every((p) => 0 == p)){
      return getHistogram(data, barChart:barChart, start:start, end:end, bin:bin, endDate:endDate, level:level, percentage:percentage, xPrecision:xPrecision);
    }

    final startDate =DateTime(endDate.year - years, endDate.month - months, endDate.day - days);

    return getHistogram(data, barChart:barChart, start:start, end:end, bin:bin, startDate:startDate, endDate:endDate, level:level, percentage:percentage, xPrecision:xPrecision);
  } 

}

double _scott(Iterable<num> data, int? precision){
    final n = data.length; 
    if (n < 2) { 
      return 1;
    }
    final sd = _sampleStandardDeviation(data);
    final cbrtN = math.pow(data.length, 1.0/3.0);
    final bin = (3.5 * sd / cbrtN);
    if(precision == null){
      return bin;
    }
    final pow = math.pow(10, precision).toDouble();
    return (bin * pow).round()/pow;
}

double _sampleStandardDeviation(Iterable<num> data) {

  double mean = data.fold<double>(0,(a, b) => (a + b)) / data.length;

  return math.sqrt(data.map((x) => math.pow(x - mean, 2).toDouble())
            .fold<double>(0,(a, b) => a + b) / (data.length - 1));

}

({int week, int weekYear}) getWeekNumber(DateTime date) {
  int doy = int.parse(DateFormat("D").format(date));
  int w =  ((10 + doy - date.weekday) / 7).floor();
  int woy = w;
  int weekYear = date.year;
  if (w < 1) {
    woy = weeksInYear(date.year - 1);
    weekYear -= 1; 
  } else if (w > weeksInYear(date.year)) {
    woy = 1;
    weekYear += 1;
  }
  return (week:woy, weekYear:weekYear);
}

int weeksInYear(int year){
  p(int y) => (y + (y/4).floor() - (y/100).floor() + (y/400).floor()) % 7;

  if(p(year) == 4 || p(year - 1) == 3){
    return 53;
  }
  return 52;
}

