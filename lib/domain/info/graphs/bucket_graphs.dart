import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/graphs/abstract_bucket.dart';
import 'package:test_flutter/domain/orm/epely.dart';
import 'package:test_flutter/domain/workout.dart';
import 'dart:math' as math;



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
}