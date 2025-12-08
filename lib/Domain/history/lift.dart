import 'package:flutter/material.dart';

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

  @override
  String toString() =>
      'ExerciseValue(value: $value, weight: $weight kg, reps: $reps)';
}

class ExerciseValues {}

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
  final ExerciseValues values;

  //Graphs, idevidual, period, complete
  final Graphs graphs;

  //Bucket graph
  final BucketGraphs bucketGraphs;

  //tables  
  final Tables tables;
 
  

  LiftHistory._({
    //data 
    required this.id,
    //history
    required this.lifts,
    //values
    required this.values,
    //Graphs
    required this.graphs,
    //Bucket graph
    required this.bucketGraphs,
    //tables 
    required this.tables,
  });

  

  factory LiftHistory(String id, Iterable<Exercise> exercises){
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
    //todo make same type of loop as in import mockdata
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
          maxWeigh = ExerciseValue(e.weightKg, e.reps, e.weightKg);
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
      exerciseValues: exerciseValues,
      //Graphs
      graphs: graphs,
      //Bucket Graph
      bucketGraphs: bucketGraphs,
      //tables
      tables: tables,
    );
  }
  
}