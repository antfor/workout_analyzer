import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/graphs/abstract_bucket.dart';
import 'package:test_flutter/domain/orm/epely.dart';
import 'package:test_flutter/domain/workout.dart';
import 'dart:math' as math;


class Histogram{

  final double _max;
  final double _min;
  final double _binWidth;

  final int _over;
  final int _under;
  final Iterable<int> _histogram;

 Histogram({
    required double max,
    required double min,
    required double binWidth,
    required int over,
    required int under,
    required Iterable<int> histogram,
  })  : _max = max,
        _min = min,
        _binWidth = binWidth,
        _over = over,
        _under = under,
        _histogram = histogram;

  double get max => _max;
  double get min => _min;
  double get binWidth => _binWidth;

  int get over => _over;
  int get under => _under;

  int get total => _histogram.reduce((a,b) => a+b);

  ({List<(double?, double?)> x, Iterable<double> y})getData({bool over=false, bool under=false, bool percentage = false}){
    
    final N = total  + (over ? this.over : 0) + (under ? this.under : 0);
    

    final x =[if(under) (null, min),
              ...(List.generate(total, (i) => (min + binWidth * i, math.min(min + binWidth * (i+1), max)))),
              if(over) (max, null)
            ];


    final v =[if (under) this.under.toDouble(),
              ...(_histogram.map((i)=>i.toDouble())),
              if (over) this.over.toDouble()
             ];
      
    final y = percentage ? v.map((v)=>v/N) : v;

    return (x:x,y:y);
  }



}

//TODO per Month, per week. per year
//now only per workout
class BucketGraphs extends Bucket {

  final List<double> _perWeightOverTime = [];
  final List<double> _perVolumeOverTime = [];
  final List<int> _repsOverTime = [];
  final List<int> _setsOverTime = [];

  Workout? _workout;
  double _maxOrm = 0;
  double _maxVolume = 0;

  @override
  void update(Exercise e) {
    _workout ??= e.workout;

    if(e.workout != _workout){

      final exercises = _workout!.exercises.where((ex) => ex.id==e.id);
      
      time.add(_workout!.startTime);
      _setsOverTime.add(exercises.length);

      for(Exercise we in exercises){
        _perWeightOverTime.add(we.weightKg/_maxOrm);
        _perVolumeOverTime.add(we.volume/_maxVolume);
        _repsOverTime.add(we.reps);
      }

      _workout = e.workout;
    }

    _maxOrm = math.max(_maxOrm, epleyORM(e.weightKg, e.reps));
    _maxVolume = math.max(_maxVolume, e.weightKg * e.reps);

  }


   Histogram getHistogram<T extends num>(List<T> data, double? start, double? end, double? bin){

    final binWidth = bin ?? _scott(data);
    final max = end ?? data.reduce(math.max);
    final min = start ?? data.reduce(math.min);
    final k = ((max-min)/binWidth).ceil();

    final bins = List.generate(k, (i) => min + binWidth * i);  
   
    final histogram = bins.map((l) =>  data.where((d)=> l <= d && d < (l + binWidth) && d <= max).length);

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
    final sd = _standardDeviation(data.cast<double>());
    final cbrtN = math.pow(data.length, 1.0/3.0);

    return 3.49 * sd / cbrtN;
}

double _standardDeviation<T extends num>(List<double> data) {
  if (data.isEmpty) return 0;

  double mean = data.reduce((a, b) => a + b) / data.length;

  return math.sqrt(data.map((x) => math.pow(x - mean, 2))
            .reduce((a, b) => a + b) / (data.length - 1));

}