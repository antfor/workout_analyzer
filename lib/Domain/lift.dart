import 'exercise.dart';
import 'Orm/epely.dart';
import 'dart:math';


class OrmData {

  int increment;
  static const List<double> increments = [0,1,1.25,2.5,5];
  static const int _maxReps = 20;
  final double orm;
  late Iterable<double> percentages;
  late Iterable<double> weightsKg;
  late Iterable<int> reps;

  OrmData(this.orm, {this.increment=4});

  void getWeight(){}

}

class NewOrmData extends OrmData{

  late Iterable<double> dif;

  NewOrmData(super.orm, {super.increment});

}


class Lift {

  final String id;

  late Iterable<Exercise> lifts;
  late double orm;
  late double maxWeight;
  late Exercise? maxVolume; // only reps,weigt and volume, so it can be serilised
  late double maxDuration;
  late Map<int, double> repMaxWeight;
  late OrmData ormData;
   

  Lift(this.id, List<Exercise> exercise){
    lifts = exercise.where((e)=>e.id == id);
    _getValues();
    ormData = OrmData(orm);
  }

  void _getValues() {

    maxWeight = 0;
    maxDuration = 0;
    orm = 0;
    repMaxWeight = {};

    if(lifts.isEmpty){
      this.maxVolume = null;
      return;
    }

    Exercise maxVolume = lifts.first;
    

    for(Exercise e in lifts){
      maxWeight = max(maxWeight, e.weightKg);
      maxDuration = max(maxDuration, e.durationSec);
      maxVolume = maxVolume.volume < e.volume ? e : maxVolume;
      repMaxWeight.update(e.reps, (v) => max(v, e.weightKg), ifAbsent:() => e.weightKg);
      orm = max(orm, epleyORM(e.weightKg, e.reps));
    }

    this.maxVolume = maxVolume;
  }

}