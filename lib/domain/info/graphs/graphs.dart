import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/i_info.dart';
import 'package:test_flutter/domain/orm/epely.dart';
import 'package:test_flutter/domain/workout.dart';
import 'dart:math' as math;


enum History {
    indevidual,
    period,
    complete,
}


class Graphs implements IExerciseUpdate {

  final List<DateTime> _time = [];
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

      _time.add(_workout!.startTime);
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

  Map<DateTime, T> getGraphdata<T extends num>(List<T> data, History type, {DateTime? startDate, DateTime? endDate}){
    final start = startDate == null ? 0 : _time.indexWhere((d) => 0 <= startDate.compareTo(d));
    final min = math.min(data.length, _time.length);
    final end = endDate == null ?  min :  _time.indexWhere((d) => d.isAfter(endDate));


    final x = _time.getRange(start, end); 

    Iterable<T> y;

    switch(type){
      case History.indevidual: y=data.getRange(start, end); break;
      case History.period: y=_getmaxOverTime(data.getRange(start, end)); break;
      case History.complete: y=_getmaxOverTime(data).toList().getRange(start, end); break;
    }

    return Map.fromIterables(x, y);
  }

  //day, month, year
  Map<DateTime, T> getLatestGraph<T extends num>(List<T> data, History type, {bool currentTime=true, int? days, int? months,int? years}){
    final end = currentTime ?  DateTime.now() : _time.last;

    if([years,months,days].every((p) => 0 == (p ?? 0))){
      return getGraphdata(data, type, endDate: end);
    }

    final start = DateTime(end.year - (years ?? 0), end.month - (months ?? 0), end.day - (days ?? 0));

    return getGraphdata(data, type, startDate: start, endDate: end);
  }

}


Iterable<T> _getmaxOverTime<T extends num>(Iterable<T> data){

  if(data.isEmpty){
    return [];
  }

  T max = data.first;
  return data.map((value) {
    max = math.max(max, value);
    return max;
  });
}