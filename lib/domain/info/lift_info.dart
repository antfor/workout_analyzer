import 'dart:math' as math;
import 'package:test_flutter/domain/orm/epely.dart';
import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/values/exercise_values.dart';
import 'package:test_flutter/domain/workout.dart';


class LiftInfo{
  //data 
  final String id;
  //final MuscleGrups = Map<Muscle, double>
  
  //history
  final List<Exercise> history;

  //values
  final ExerciseValues values;

  //Graphs, idevidual, period, complete
  final Graphs graphs;

  //Bucket graph
  final BucketGraphs bucketGraphs;

  //tables  
  final Tables tables;
 
  

  LiftInfo._({
    //data 
    required this.id,
    //history
    required this.history,
    //values
    required this.values,
    //Graphs
    required this.graphs,
    //Bucket graph
    required this.bucketGraphs,
    //tables 
    required this.tables,
  });

  

  factory LiftInfo(String id, Iterable<Exercise> exercises){
    final filtered = exercises.where((e) => e.id == id).toList();
    filtered.sort();

    final values = ExerciseValues();

    for(Exercise e in exercises){

      values.update(e.weightKg, e.reps);

    }


    return LiftInfo._(
      id: id,
      history: filtered,
      values: values,
      graphs: graphs,
      bucketGraphs: bucketGraphs,
      tables: tables,
    );
  }
  
}