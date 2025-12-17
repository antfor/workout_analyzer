import 'package:quiver/collection.dart';
import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/domain/workout.dart';

class Domain {

  //todo make private
  final List<Workout> workouts;
  final Multimap<String, Exercise> exerciseMap; //todo: stop using quiver? Use List<Exercise>
  final Standards maleStandards;
  final Standards femaleStandards;
  final Map<String,Muscle> muscleMap;
  
  //final Multimap<String, Cardio> cardioMap;

  Domain({required this.workouts, required this.exerciseMap, required this.maleStandards, required this.femaleStandards, required this.muscleMap});

  Iterable<Exercise> get exercises => exerciseMap.values;
  Iterable<Exercise> exercise(String id) => exerciseMap.containsKey(id) ? exerciseMap[id] : [];

}