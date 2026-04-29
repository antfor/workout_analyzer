import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/collection.dart';
import 'package:workout_analyzer/data/local/drift/database.dart' as db;
import 'package:workout_analyzer/data/local/drift/mapper/mapper.dart';
import 'package:workout_analyzer/domain/cardio.dart';
import 'package:workout_analyzer/domain/domain.dart';
import 'package:workout_analyzer/domain/exercise.dart';
import 'package:workout_analyzer/domain/standards/muscle_group.dart';
import 'package:workout_analyzer/domain/standards/standards.dart';
import 'package:workout_analyzer/domain/workout.dart';
import 'package:workout_analyzer/repository/import/import.dart';
import 'package:workout_analyzer/repository/import/map.dart';

final repoProvider = Provider<Repo?>((ref) {
  return Repo.getRepo();
});

class Repo{


  final db.AppDb localDB;
  final Cache cache = Cache.getCache();

  static Repo? _repo;

  static Repo initRepo(db.AppDb localDB){

    _repo ??= Repo._(localDB);

    return _repo!;
  }

  static Repo? getRepo(){
    return _repo;
  }

  Repo._(this.localDB);

  void clearUserData(){

  }

  Future<Domain> importCSV(String filePath, Domain? old) async{

    final muscleMap = old?.muscleMap ?? await getMuscleMap();
    final maleStandards = old?.maleStandards ?? await getMaleStandards();
    final femaleStandards = old?.femaleStandards ?? await getFemaleStandards();
    
    final newDomain = await importDataFromCsv(muscleMap, maleStandards, femaleStandards, filePath);

    final error = await localDB.import(newDomain); //TODO can remove strength standarsd? import -> old -> new did not wor for abs?

    if(error != null){
      //return error; //TODO handel import error, like show msg why it faild.
    }

    return newDomain;
  }

  void exportCSV(String filePath){
    //TODO
  }


  Future<Map<String, Muscle>> getMuscleMap() async{
    final rows = await localDB.get_exercises().get();
    final entries = rows.map((w) => w.toLocal());
    return Map.fromEntries(entries);
  }

  Future<Map<String, String>> getMapNames() async{
    cache.mapNames  = cache.mapNames ?? await importMap();//TODO fix so i dont need mapNames
    return await importMap();
  }

  Future<Standards> getStandards(Sex sex) async{

    final namesW = await localDB.get_names_weight().get();
    final List<StandardTable> weight = [];
    for(final name in namesW){
      final data = await localDB.get_standard_weight(sex.string, name).get();
      weight.add(StandardsWeightMapper.fromRows(name, data));
    }

    final namesR = await localDB.get_names_reps().get();
    final List<StandardTable> reps = [];
    for(final name in namesR){
      final data = await localDB.get_standard_reps(sex.string, name).get();
      weight.add(StandardsRepsMapper.fromRows(name, data));
    }
    final List<StandardRatio> ratio = [];


    return Standards(sex, weight: weight, reps: reps, ratio: ratio, mapNames: await getMapNames());
  }

  Future<Standards> getFemaleStandards() async{
    return getStandards(Sex.female);
  }
  
  Future<Standards> getMaleStandards() async{
    return getStandards(Sex.male);
  }

  Future<List<Workout>> getWorkouts() async {

    final rows = await localDB.get_workouts().get();

    final List<Workout> localWorkouts = rows.map((w) => w.toLocal()).toList();

    for(final workout in localWorkouts){

      final liftData = await localDB.get_workout_lift(workout.id).get();
      final lifts = liftData.map((l) => Exercise(id: l.exercise, setIndex: l.setIndex, setOfSets: l.setOfSets, weightKg: l.weightKg ?? 0, reps: l.reps, workout: workout));
      workout.addExercises(lifts);

      final cardioData = await localDB.get_workout_cardio(workout.id).get();
      final cardio = cardioData.map((c) => Cardio(id: c.exercise, lap: c.lap, distanceKm: c.distanceM ?? 0, durationSeconds: c.durationS ?? 0, workout: workout)); //TODO make null instead of s?? 0
      workout.addCardio(cardio);
    }

    return localWorkouts;
    
  }

  Future<Domain> getDomain() async {

    final workouts = await getWorkouts();

    final exerciseMap = Multimap<String, Exercise>();
    final cardioMap = Multimap<String, Cardio>();

    for(final workout in workouts){
      for (final e in workout.exercises) {
        exerciseMap.add(e.id, e);
      }
      for (final c in workout.cardio) {
        cardioMap.add(c.id, c);
      }
    }

    final male = await getMaleStandards();
    final female = await getFemaleStandards();
    final muscle = await getMuscleMap();

    return Domain(workouts: workouts, exerciseMap: exerciseMap, cardioMap: cardioMap, maleStandards: male, femaleStandards: female, muscleMap:muscle);
    //return await importMockData(await getMuscleMap(), await getMaleStandards(), await getFemaleStandards());
  }

}

class Cache{

  static final Cache _cache = Cache._();

  static Cache getCache(){
    return _cache;
  }

  Cache._();
  
  Map<String, String>? mapNames;
}