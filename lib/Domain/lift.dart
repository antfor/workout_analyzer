import 'exercise.dart';
import 'workout.dart';
import 'Orm/epely.dart';
import 'dart:math' as math;


//todo use factory...
class OrmData {

  int incrementIndex;
  static const List<double> increments = [0,1,1.25,2.5,5];

  final double orm;
  late Iterable<double> percentages;
  late List<double> weightsKg;
  late List<int> reps;

  OrmData(this.orm, {this.incrementIndex=4}){
    weightsKg = _getWeight();
    percentages = weightsKg.map((w) => w/orm);
    reps = _getReps();
  }

  
  double get increment {
    int safeIndex = (incrementIndex % increments.length + increments.length) % increments.length;
    return increments[safeIndex];
  }

  List<int> _getReps(){
    return weightsKg.map((w) => epleyMaxRep(orm, w)).toList();
  }

  List<double> _getWeight(){

    final inc = increment;
    const double  minPercentage = 0.5;

     if (inc <= 0) { //just give standard percentages in this case
        const maxPercentage = 0.95;
        const gap = 0.05;
        const len = 1 + (maxPercentage * 100 - minPercentage * 100) / (gap * 100);
        return List<double>.generate(math.max(len.floor(),0), (i) => (maxPercentage - gap * i) * orm);
    }

    final int max = (orm / inc).floor();
    if (max < 1) {
        return [];
    }
    final int min = (minPercentage * orm / inc).round();
    final len = math.max(max - min + 1,0);
    return List<double>.generate(len, (i) => inc * (max - i));

  }

}

class NewOrmData extends OrmData{

  late Iterable<double> dif;
  late Iterable<double> newOrm;
  static const int _maxReps = 20;

  NewOrmData(super.orm, {super.incrementIndex}){
    
    final len = math.min(reps.length, weightsKg.length);

    newOrm = List.generate(len, (i)=> epleyORM(weightsKg[i], reps[i]));
    dif = newOrm.map((v)=>v-orm);
    //todo filter reps bigger then 20
    
  }

  @override
  List<int> _getReps(){
    return weightsKg.map((w) => epleyMaxRep(orm, w) + 1).toList();
  }

}

// todo make lazy? NO, only create this when needed instead. lazy cerate
class Lift {
  final String id;
  final List<Exercise> lifts;
  final Map<int, double> repMaxWeight;
  final OrmData ormData;

  final Exercise? maxVolume;
  final double orm;
  final double maxWeight;
  final double maxDuration;

  Lift._({
    required this.id,
    required this.lifts,
    required this.orm,
    required this.maxWeight,
    required this.maxVolume,
    required this.maxDuration,
    required this.repMaxWeight,
  }) : ormData = OrmData(orm);

  factory Lift(String id, List<Exercise> exercises) {
    final filtered = exercises.where((e) => e.id == id).toList();

    if (filtered.isEmpty) {
      return Lift._(
        id: id,
        lifts: filtered,
        orm: 0,
        maxWeight: 0,
        maxVolume: null,
        maxDuration: 0,
        repMaxWeight: {},
      );
    }

    filtered.sort();

    double maxWeight = 0;
    double maxDuration = 0;
    double orm = 0;
    final Map<int, double> repMaxWeight = {};
    Exercise maxVolume = filtered.first;

    for (final e in filtered) {

      orm = math.max(orm, epleyORM(e.weightKg, e.reps));
      maxWeight = math.max(maxWeight, e.weightKg);
      maxDuration = math.max(maxDuration, e.durationSec);

      if (e.volume > maxVolume.volume) maxVolume = e;

      repMaxWeight.update(e.reps, (v) => math.max(v, e.weightKg), ifAbsent: () => e.weightKg);
    }

    return Lift._(
      id: id,
      lifts: filtered,
      orm: orm,
      maxWeight: maxWeight,
      maxVolume: maxVolume,
      maxDuration: maxDuration,
      repMaxWeight: repMaxWeight,
    );
  }


  /*
  update(List<Exercise> exercises){
    final filtered = exercises.where((e) => e.id == id).toList();

    if (filtered.isEmpty) {
      return this;
    }

    final newLifts = Lift(id, filtered);
    lifts.addAll(newLifts.lifts);


    newLifts.repMaxWeight.forEach((k,newV)=>repMaxWeight.update(k, (oldV) => math.max(oldV,newV), ifAbsent: () => newV ));
   
    if(newLifts.maxVolume != null && maxVolume != null){
      maxVolume = newLifts.maxVolume!.volume > maxVolume!.volume ? newLifts.maxVolume : maxVolume;
    }else if(newLifts.maxVolume != null){
      maxVolume = newLifts.maxVolume;
    }
    orm = math.max(orm, newLifts.orm);
    maxWeight = math.max(maxWeight, newLifts.maxWeight);
    maxDuration= math.max(maxDuration, newLifts.maxDuration);

  }
  */

}

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
class MaxVolume {
  final double weight;
  final int reps;
  late final double volume;

  MaxVolume(this.weight, this.reps){
    volume = weight * reps;
  }
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
  //final List<Exercise> lifts; //for history tab, maybe save workout set intead.
  //final List<Workout> workouts; 

  //values
  final double orm;
  final double maxWeight;
  final MaxVolume maxVolume;

  //Graphs, idevidual, period, complete
  final List<DateTime> time;
  final List<double> ormOverTime;
  final List<double> weightOverTime;
  final List<double> volumeOverTime;

  //Bucket graph
  final List<double> perWeightOverTime;
  final List<double> perVolumeOverTime;
  final List<int> repsOverTime;
  final List<int> setsOverTime;

  //tables  
  final Map<int, double> repMaxWeight;
  final OrmData? ormData; //todo lazy create
  final NewOrmData? newOrmData;
  

  LiftHistory._({
    required this.time,
    required this.ormOverTime,
    required this.weightOverTime,
    required this.volumeOverTime,

    required this.perWeightOverTime,
    required this.perVolumeOverTime,
    required this.repsOverTime,
  });

  //Max over time
  Iterable<double> maxOrmOverTime({int start=0, int? end}) => gatMaxOverTimeInRange(ormOverTime, start, end);
  Iterable<double> maxWeightOverTime({int start=0, int? end}) => gatMaxOverTimeInRange(ormOverTime, start, end);
  Iterable<double> maxVolumeOverTime({int start=0, int? end}) => gatMaxOverTimeInRange(ormOverTime, start, end);
  Iterable<double> maxDurationOverTime({int start=0, int? end}) => gatMaxOverTimeInRange(ormOverTime, start, end);


  factory LiftHistory(String id, List<Exercise> exercises){
    final filtered = exercises.where((e) => e.id == id).toList();
    filtered.sort();

    List<DateTime> time = [];
    List<double> ormOverTime = [];
    List<double> weightOverTime = [];
    List<double> volumeOverTime = [];
    List<double> durationOverTime = [];

    List<double> perWeightOverTime = [];
    List<double> perVolumeOverTime = [];
    List<double> perDurationOverTime = [];
    List<int> repsOverTime = [];

    double maxOrm = 0;
    double maxWeigh = 0;
    double maxVolume = 0;
    double maxDuration = 0;

    Set<Workout> workouts = filtered.map((e) => e.workout).toSet();

    for(Workout w in workouts){
      double orm = 0;
      double weigh = 0;
      double volume = 0;
      double duration = 0;

      final exercises = w.exercises.where((e) => e.id==id);
      for(Exercise e in exercises){
        orm = math.max(orm, epleyORM(e.weightKg, e.reps));
        weigh = math.max(weigh, e.weightKg);
        volume = math.max(volume, e.volume);
        duration = math.max(duration, e.durationSec);   
      }

      time.add(w.endTime);
      ormOverTime.add(orm);
      weightOverTime.add(weigh);
      volumeOverTime.add(volume);
      durationOverTime.add(duration);

      maxOrm = math.max(maxOrm, orm);
      maxWeigh = math.max(maxWeigh, weigh);
      maxVolume = math.max(maxVolume, volume);
      maxDuration = math.max(maxDuration, duration);

      for(Exercise e in exercises){

        perWeightOverTime.add(e.weightKg/maxOrm);
        perVolumeOverTime.add(e.volume/maxVolume);
        perDurationOverTime.add(e.durationSec/maxDuration);

        repsOverTime.add(e.reps);
      }

    }


    return LiftHistory._(
      time: time,
      ormOverTime: ormOverTime,
      weightOverTime: weightOverTime,
      volumeOverTime: volumeOverTime,
      perWeightOverTime: perWeightOverTime,
    );
  }
  
}