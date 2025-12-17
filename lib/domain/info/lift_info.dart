import 'package:test_flutter/domain/info/graphs/bucket_graphs.dart';
import 'package:test_flutter/domain/info/graphs/graphs.dart';
import 'package:test_flutter/domain/info/tables/tables.dart';
import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/values/exercise_values.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';
import 'package:test_flutter/domain/standards/standards.dart';


class LiftInfo{

  final String id;
  final List<Exercise> history;
  final ExerciseValues values;
  final Graphs graphs;
  final BucketGraphs bucketGraphs;
  final Tables tables;

  final Muscle muscle;
  final Standard maleStandard;
  final Standard femaleStandard;

  LiftInfo._({
    required this.id,
    required this.history,
    required this.values,
    required this.graphs,
    required this.bucketGraphs,
    required this.tables,
    required this.muscle,
    required this.maleStandard,
    required this.femaleStandard,
  });

  factory LiftInfo(String id, Iterable<Exercise> exercises, Muscle muscle, Standard maleStandard, Standard femaleStandard){
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
      muscle: muscle,
      maleStandard: maleStandard,
      femaleStandard: femaleStandard
    );
  }
}