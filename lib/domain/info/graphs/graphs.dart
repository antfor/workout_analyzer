import 'dart:math' as math;
import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/graphs/abstract_graph.dart';
import 'package:test_flutter/domain/orm/epely.dart';
import 'package:test_flutter/domain/workout.dart';



class Graphs extends Graph {

  final List<double> ormOverTime  = [];
  final List<double> weightOverTime = [];
  final List<double> volumeOverTime = [];

  Workout? _workout;

  double _orm = 0;
  double _weigh = 0;
  double _volume = 0;

  @override
  void update(Exercise e){

    _workout ??= e.workout;

    if(e.workout != _workout){

      time.add(_workout!.startTime);
      ormOverTime.add(_orm);
      weightOverTime.add(_weigh);
      volumeOverTime.add(_volume);

      //New workout
      _workout = e.workout;

      _orm = 0;
      _weigh = 0;
      _volume = 0;
    }

    _orm = math.max(_orm, epleyORM(e.weightKg, e.reps));
    _weigh = math.max(_weigh, e.weightKg);
    _volume = math.max(_volume, e.volume);
  }
  
  @override
  void done(String id) {
    if(_workout != null){

      time.add(_workout!.startTime);
      ormOverTime.add(_orm);
      weightOverTime.add(_weigh);
      volumeOverTime.add(_volume);

      _orm = 0;
      _weigh = 0;
      _volume = 0;
    }
  }
}