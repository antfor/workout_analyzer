import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_analyzer/data/local/drift/database.dart' as db;
import 'package:workout_analyzer/domain/domain.dart';
import 'package:workout_analyzer/domain/standards/muscle_group.dart';
import 'package:workout_analyzer/domain/standards/standards.dart';
import 'package:workout_analyzer/domain/workout.dart';
import 'package:workout_analyzer/repository/import/import.dart';
import 'package:workout_analyzer/repository/import/map.dart';
import 'package:workout_analyzer/repository/import/muscle.dart';
import 'package:workout_analyzer/repository/import/standards.dart';


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

    final muscleMap = old?.muscleMap ?? await this.muscleMap;
    final maleStandards = old?.maleStandards ?? await this.maleStandards;
    final femaleStandards = old?.femaleStandards ?? await this.femaleStandards;
    
    final newDomain = await importDataFromCsv(muscleMap, maleStandards, femaleStandards, filePath);

    localDB.import(newDomain);

    return newDomain;
  }

  void exportCSV(String filePath){
    //TODO
  }


  Future<Map<String, Muscle>> get muscleMap async{
    return importMuscle();//TODO read from data base
  }

  Future<Map<String, String>> get mapNames async{
    return importMap();//TODO fix so i dont need this
  }

  Future<Standards> get femaleStandards async{
    return importFemale(await mapNames);//TODO read from data base
  }
  
  Future<Standards> get maleStandards async{
    return importMale(await mapNames);//TODO read from data base
  }

  Future<Domain> get domain async {
    return await importMockData(await muscleMap, await maleStandards, await femaleStandards);//TODO read from data base
  }

}

class Cache{

  static final Cache _cache = Cache._();

  static Cache getCache(){
    return _cache;
  }

  Cache._();
  
  List<Workout>? workouts;
}