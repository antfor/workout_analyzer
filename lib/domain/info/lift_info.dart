import 'package:test_flutter/domain/info/graphs/bucket_graphs.dart';
import 'package:test_flutter/domain/info/graphs/graphs.dart';
import 'package:test_flutter/domain/info/tables/tables.dart';
import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/values/exercise_values.dart';


class LiftInfo{

  final String id;
  //final MuscleGrups = Map<Muscle, double>
  final List<Exercise> history;
  final ExerciseValues values;
  final Graphs graphs;
  final BucketGraphs bucketGraphs;
  final Tables tables;

  LiftInfo._({
    required this.id,
    required this.history,
    required this.values,
    required this.graphs,
    required this.bucketGraphs,
    required this.tables,
  });

  factory LiftInfo(String id, Iterable<Exercise> exercises){
    final filtered = exercises.where((e) => e.id == id).toList();
    filtered.sort();

    final values = ExerciseValues();
    final tables = Tables(values.orm);
    final graphs = Graphs();
    final bucket = BucketGraphs();

    for(Exercise e in exercises){

      final weight = e.weightKg;
      final reps = e.reps;

      values.update(weight, reps);
      tables.update(weight, reps);
      graphs.update(e);
      bucket.update(e);
    }

    return LiftInfo._(
      id: id,
      history: filtered,
      values: values,
      graphs: graphs,
      bucketGraphs: bucket,
      tables: tables,
    );
  }
}