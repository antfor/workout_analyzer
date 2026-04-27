import 'package:quiver/collection.dart';
import 'package:workout_analyzer/domain/cardio.dart';
import 'package:workout_analyzer/domain/info/cardio/cardio_info.dart';
import '/domain/exercise.dart';
import '/domain/info/lift_info.dart';
import '/domain/standards/muscle_group.dart';
import '/domain/standards/standards.dart';
import '/domain/workout.dart';

typedef Id = String;

class Domain {

  //todo make private
  final List<Workout> workouts;
  final Multimap<Id, Exercise> exerciseMap; //todo: stop using quiver? Use List<Exercise>
  final Standards maleStandards;
  final Standards femaleStandards;
  final Map<Id,Muscle> muscleMap;

  final Map<Id,LiftInfo> _lifts = {};
  final Map<Id,CardioInfo> _cardio = {};
  
  final Multimap<Id, Cardio> cardioMap;

  Domain({required this.workouts, required this.exerciseMap, required this.cardioMap, required this.maleStandards, required this.femaleStandards, required this.muscleMap});
 
  Iterable<String> get exercises => exerciseMap.keys;
  Iterable<String> get cardio => cardioMap.keys;

  Iterable<Exercise> exercise(Id id) => exerciseMap.containsKey(id) ? exerciseMap[id] : [];

  LiftInfo getLift(Id id) => _lifts.putIfAbsent(id, () => LiftInfo(id, exerciseMap[id], getMuscle(id), maleStandards.getStandard(id), femaleStandards.getStandard(id)));
  CardioInfo getCardio(Id id) => _cardio.putIfAbsent(id, () => CardioInfo(id, cardioMap[id]));
  Muscle getMuscle(Id id) => muscleMap[id] ?? Muscle.other;

  Iterable<LiftBasicInfo> get getBasicInfo => exercises.map((id)=> LiftBasicInfo(id, getMuscle(id), () => getLift(id)));

  Iterable<CardioBasicInfo> get getCardioInfo => cardio.map((id) => CardioBasicInfo(id, () => getCardio(id)));
}