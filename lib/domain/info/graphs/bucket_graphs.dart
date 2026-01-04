import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/graphs/abstract_bucket.dart';
import 'package:test_flutter/domain/orm/epely.dart';
import 'package:test_flutter/domain/workout.dart';
import 'dart:math' as math;

enum Data {
  weight,
  volume,
  reps,
  set,
  duration,
  count,
}

class BucketGraphs extends Bucket {

  final List<double> perWeightOverTime = [];
  final List<double> perVolumeOverTime = [];
  final List<int> repsOverTime = [];
  final List<int> setsOverTime = [];
  final List<Duration> duration = [];

  List<int> get workoutCount => List.generate(time.length, (i) => 1);

  Workout? _workout;
  double _maxOrm = 0;
  double _maxVolume = 0;

  @override
  void update(Exercise e) {
    _workout ??= e.workout;

    if(e.workout != _workout){

      final exercises = _workout!.exercises.where((ex) => ex.id==e.id);
      
      time.add(_workout!.startTime);
      duration.add(_workout!.endTime.difference(_workout!.startTime));
      setsOverTime.add(exercises.length);

      for(Exercise we in exercises){
        perWeightOverTime.add(we.weightKg/_maxOrm);
        perVolumeOverTime.add(we.volume/_maxVolume);
        repsOverTime.add(we.reps);
      }

      _workout = e.workout;
    }

    _maxOrm = math.max(_maxOrm, epleyORM(e.weightKg, e.reps));
    _maxVolume = math.max(_maxVolume, e.weightKg * e.reps);

  }
}