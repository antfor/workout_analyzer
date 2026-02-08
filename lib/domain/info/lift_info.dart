import 'package:test_flutter/domain/info/graphs/bucket_graphs.dart';
import 'package:test_flutter/domain/info/graphs/graphs.dart';
import 'package:test_flutter/domain/info/tables/tables.dart';
import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/info/values/exercise_values.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';
import 'package:test_flutter/domain/standards/standards.dart';

class LiftBasicInfo implements Comparable<LiftBasicInfo>{
  final String id;
  final Muscle muscle;
  final LiftInfo Function () getInfo;

  LiftBasicInfo(this.id, this.muscle, this.getInfo);
  
  @override
  int compareTo(LiftBasicInfo other) {
    return id.compareTo(other.id);
  }

  double getLevel(Sex sex, double bodyWeight) {

    return getInfo().getLevel(sex, bodyWeight);
  }
}

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
    final filtered = exercises.where((e) => e.id == id).toList()..sort();

    final values = ExerciseValues();
    final tables = Tables(values.orm);
    final graphs = Graphs();
    final bucket = BucketGraphs();

    for(Exercise e in filtered){

      final weight = e.weightKg;
      final reps = e.reps;

      values.update(weight, reps);
      tables.update(weight, reps);
      graphs.update(e);
      bucket.update(e);
    }

    graphs.done(id);
    bucket.done(id);

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

  double getLevel(Sex sex, double bodyWeight) {
    final orm = values.orm.value ;

    final standard  = sex == Sex.male ? maleStandard : femaleStandard;
    final strengthLevel = standard.weight ?? standard.reps;
    if(strengthLevel != null){
      return strengthLevel.levelValue(bodyWeight, orm);
    }   

    return 0;
  }
}