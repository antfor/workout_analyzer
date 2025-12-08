import 'dart:math' as math;
import 'package:test_flutter/Domain/Orm/epely.dart';
import 'package:test_flutter/Domain/exercise.dart';
import 'package:test_flutter/Domain/history/values/exercise_values.dart';
import 'package:test_flutter/Domain/workout.dart';


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

    final values = ExerciseValues();

    for(Exercise exercise in exercises){

    }


    return LiftHistory._(
      id: id,
      lifts: filtered,
      values: values,
      graphs: graphs,
      bucketGraphs: bucketGraphs,
      tables: tables,
    );
  }
  
}