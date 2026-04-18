import 'dart:math' as math;
import 'package:workout_analyzer/domain/cardio.dart';
import 'package:workout_analyzer/domain/info/i_info.dart';
import '/domain/info/graphs/abstract_graph.dart';
import '/domain/workout.dart';



class CardioGraphs extends Graph implements IDoneUpdate<Cardio> {

  final List<double> pace  = [];
  final List<double> distance = [];
  final List<double> duration = [];

  List<double> filter(List<double> data, double? min, double? max){
    
    if(min == null && max == null) return data;

    return data.where((n) => (min == null || min <= n) && (max == null || n <= max)).toList();
  }

  Workout? _workout;

  double _pace = 0;
  double _distance = 0;
  double _duration = 0;

  @override
  void update(Cardio c){

    _workout ??= c.workout;

    if(c.workout != _workout){

      time.add(_workout!.startTime);
      pace.add(_pace);
      distance.add(_distance);
      duration.add(_duration);

      //New workout
      _workout = c.workout;

      _pace = 0;
      _distance = 0;
      _duration = 0;
    }

    _pace = math.max(_pace, c.paceSec);
    _distance = math.max(_distance, c.distanceKm);
    _duration = math.max(_duration, c.durationSeconds);
  }
  
  @override
  void done(String id) {
    if(_workout != null){

      time.add(_workout!.startTime);
      pace.add(_pace);
      distance.add(_distance);
      duration.add(_duration);

      _pace = 0;
      _distance = 0;
      _duration = 0;
    }
  }
}