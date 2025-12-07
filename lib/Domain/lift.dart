import 'exercise.dart';
import 'workout.dart';
import 'Orm/epely.dart';
import 'Table/orm.dart';
import 'dart:math' as math;


Iterable<T> gatMaxOverTimeInRange<T extends num>(List<T> list, int start, int? end){
  return getmaxOverTime(list.getRange(start, end ?? list.length));
}

Iterable<T> getmaxOverTime<T extends num>(Iterable<T> data){

  if(data.isEmpty){
    return [];
  }

  T max = data.first;
  return data.map((value) {
    max = math.max(max, value);
    return max;
  });
}

class ExerciseValue {

  final double weight;
  final int reps;
  late final double value;

  ExerciseValue(this.weight, this.reps, this.value);
}

enum History {
    indevidual,
    period,
    complete,
}

class LiftHistory{
  //data 
  final String id;
  //final MuscleGrups = Map<Muscle, double>
  
  //history
  final List<Exercise> lifts;

  //values
  final ExerciseValue orm;
  final ExerciseValue maxWeight;
  final ExerciseValue maxVolume;

  //Calculate graph data when needed?
  //Graphs, idevidual, period, complete
  final List<DateTime> time;
  final List<double> ormOverTime;
  final List<double> weightOverTime;
  final List<double> volumeOverTime;

  //Calculate as needed?
  //Bucket graph
  final List<double> perWeightOverTime;
  final List<double> perVolumeOverTime;
  final List<int> repsOverTime;
  final List<int> setsOverTime;

  //Calculate as needed?
  //tables  
  final Map<int, double> repMaxWeight;
  final OrmData ormData;
  final NewOrmData newOrmData;
  

  LiftHistory._({
    //data 
    required this.id,
    //history
    required this.lifts,
    //values
    required this.orm,
    required this.maxWeight,
    required this.maxVolume,
    //Graphs
    required this.time,
    required this.ormOverTime,
    required this.weightOverTime,
    required this.volumeOverTime,
    //Bucket graph
    required this.perWeightOverTime,
    required this.perVolumeOverTime,
    required this.repsOverTime,
    required this.setsOverTime,
    //tables 
    required this.repMaxWeight,
    required this.ormData,
    required this.newOrmData,

  });

  //getGraphdata
  Map<DateTime, T> getGraphdata<T extends num>(List<T> data, History type, {DateTime? startDate, DateTime? endDate}){
    final start = startDate == null ? 0 : time.indexWhere((d) => 0 <= startDate.compareTo(d));
    final min = math.min(data.length, time.length);
    final end = endDate == null ?  min :  time.indexWhere((d) => d.isAfter(endDate));


    final x = time.getRange(start, end); 

    Iterable<T> y;

    switch(type){
      case History.indevidual: y=data.getRange(start, end); break;
      case History.period: y=getmaxOverTime(data.getRange(start, end)); break;
      case History.complete: y=getmaxOverTime(data).toList().getRange(start, end); break;
    }

    return Map.fromIterables(x, y);
  }

  //day, month, year
  Map<DateTime, T> getLatestGraph<T extends num>(List<T> data, History type, {bool currentTime=true, int? days, int? months,int? years}){
    final end = currentTime ?  DateTime.now() : time.last;

    if([years,months,days].every((p) => 0 == (p ?? 0))){
      return getGraphdata(data, type, endDate: end);
    }

    final start = DateTime(end.year - (years ?? 0), end.month - (months ?? 0), end.day - (days ?? 0));

    return getGraphdata(data, type, startDate: start, endDate: end);
  }

  factory LiftHistory(String id, List<Exercise> exercises){
    final filtered = exercises.where((e) => e.id == id).toList();
    filtered.sort();

    final List<DateTime> time = [];
    final List<double> ormOverTime = [];
    final List<double> weightOverTime = [];
    final List<double> volumeOverTime = [];

    final List<double> perWeightOverTime = [];
    final List<double> perVolumeOverTime = [];
    final List<int> repsOverTime = [];
    final List<int> setsOverTime = [];

    ExerciseValue maxOrm = ExerciseValue(0,0,0);
    ExerciseValue maxWeigh = ExerciseValue(0,0,0);
    ExerciseValue maxVolume = ExerciseValue(0,0,0);

    final Map<int, double> repMaxWeight = {};

    Set<Workout> workouts = filtered.map((e) => e.workout).toSet();

    for(Workout w in workouts){
      double orm = 0;
      double weigh = 0;
      double volume = 0;

      final exercises = w.exercises.where((e) => e.id==id);

      for(Exercise e in exercises){
        //table
        repMaxWeight.update(e.reps, (v) => math.max(v, e.weightKg), ifAbsent: () => e.weightKg);
        
        final newOrm = epleyORM(e.weightKg, e.reps);
        //valuses
        if(newOrm > maxOrm.value){
          maxOrm = ExerciseValue(e.weightKg, e.reps, newOrm);
        }
        if(e.weightKg > maxWeigh.value || (e.weightKg == maxWeigh.value && e.reps > maxWeigh.reps)){
          maxOrm = ExerciseValue(e.weightKg, e.reps, e.weightKg);
        }
        if(e.volume > maxVolume.value){
          maxVolume = ExerciseValue(e.weightKg, e.reps, e.volume);
        }

        orm = math.max(orm, newOrm);
        weigh = math.max(weigh, e.weightKg);
        volume = math.max(volume, e.volume); 
      }

      //Graphs
      time.add(w.endTime);
      ormOverTime.add(orm);
      weightOverTime.add(weigh);
      volumeOverTime.add(volume);

      //Bucket Graphs
      setsOverTime.add(exercises.length);
      for(Exercise e in exercises){

        perWeightOverTime.add(e.weightKg/maxOrm.value);
        perVolumeOverTime.add(e.volume/maxVolume.value);
        repsOverTime.add(e.reps);
      }

    }


    return LiftHistory._(
      //data
      id: id,
      //history
      lifts: filtered,
      //values
      orm: maxOrm,
      maxWeight: maxWeigh,
      maxVolume: maxVolume,
      //Graphs
      time: time,
      ormOverTime: ormOverTime,
      weightOverTime: weightOverTime,
      volumeOverTime: volumeOverTime,
      //Bucket Graph
      perWeightOverTime: perWeightOverTime,
      perVolumeOverTime: perVolumeOverTime,
      repsOverTime: repsOverTime,
      setsOverTime: setsOverTime,
      //tables
      repMaxWeight: repMaxWeight,
      ormData: OrmData(maxOrm.value),
      newOrmData: NewOrmData(maxOrm.value),
    );
  }
  
}