import 'package:workout_analyzer/domain/info/i_info.dart';

import '/domain/info/graphs/bucket_graphs.dart';
import '/domain/info/graphs/graphs.dart';
import '/domain/info/tables/tables.dart';
import '/domain/exercise.dart';
import '/domain/info/values/exercise_values.dart';
import '/domain/standards/muscle_group.dart';
import '/domain/standards/standards.dart';

class LiftBasicInfo extends IInfo{//TODO remove? because of getLevel spoil lazy create
  @override
  final String id;
  @override
  final Muscle muscle;
  final LiftInfo Function () getInfo;

  LiftBasicInfo(this.id, this.muscle, this.getInfo);

  double getLevel(Sex sex, double bodyWeight) {

    return getInfo().getLevel(sex, bodyWeight);
  }
}

class LiftInfo extends IInfo{
  
  @override
  final String id;
  final List<Exercise> history;
  final ExerciseValues values;
  final Graphs graphs;
  final BucketGraphs bucketGraphs;
  final Tables tables;

  @override
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