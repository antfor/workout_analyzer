import 'package:quiver/collection.dart';
import 'package:test_flutter/domain/exercise.dart';
import 'package:test_flutter/domain/workout.dart';

class Domain {

  //todo make private
  final List<Workout> workouts;
  final Multimap<String, Exercise> exerciseMap; //todo: stop using quiver? use Map<String,List<Exersise>>
  //final Multimap<String, Cardio> cardioMap;

  Domain({required this.workouts, required this.exerciseMap});

  Iterable<String> get exercises => exerciseMap.keys;
  Iterable<Exercise> exercise(String id) => exerciseMap.containsKey(id) ? exerciseMap[id] : [];

}