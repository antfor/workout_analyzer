import 'package:workout_analyzer/domain/cardio.dart';

import '/domain/domain.dart';
import '/domain/exercise.dart';
import '/domain/standards/muscle_group.dart';
import '/domain/standards/standards.dart';
import '/domain/workout.dart';
import '/data/import/csv.dart';
import 'package:intl/intl.dart';
import 'package:quiver/collection.dart';

//"title","start_time","end_time","description","exercise_title","superset_id","exercise_notes","set_index","set_type","weight_kg","reps","distance_km","duration_seconds","rpe"
//"start_time","end_time","exercise_title","superset_id","set_index","weight_kg","reps","distance_km","duration_seconds"
//lift: 1,2,4,7,8,9,
//cardio: 1,2,4,7,10,11

enum ColumnName{
  title("title"),
  start("start_time"),
  end("end_time"),
  exercise("exercise_title"),
  set("set_index"),
  weightKg("weight_kg"),
  reps("reps"),
  distanceKm("distance_km"),
  durationSeconds("duration_seconds");

  final String string;

  const ColumnName(this.string);
}

Future<Domain> importMockData(Map<String,Muscle> muscleMap, Standards male, Standards female) async {
  const mockData = 'assets/data/test_workout_data.csv';
  return importDataFromCsv(muscleMap, male, female, mockData); 
}
 

Future<Domain> importDataFromCsv(Map<String,Muscle> muscleMap, Standards male, Standards female, String filePath) async {
  final rows = await loadCsv(filePath);

  if(rows.length < 2){
    return Domain(workouts: [], exerciseMap: Multimap<String, Exercise>(), cardioMap:  Multimap<String, Cardio>(), maleStandards: male, femaleStandards: female, muscleMap:muscleMap);
  }

  final title = rows[0].indexOf(ColumnName.title.string);
  final start = rows[0].indexOf(ColumnName.start.string);
  final end = rows[0].indexOf(ColumnName.end.string);
  final exercise = rows[0].indexOf(ColumnName.exercise.string); 
  final set = rows[0].indexOf(ColumnName.set.string); 
  final weightKg = rows[0].indexOf(ColumnName.weightKg.string); 
  final reps = rows[0].indexOf(ColumnName.reps.string);

  final distance = rows[0].indexOf(ColumnName.distanceKm.string);
  final duration = rows[0].indexOf(ColumnName.durationSeconds.string);

  bool isExercises(List<dynamic> row){

    return (double.tryParse(row[weightKg].toString()) != null && int.tryParse(row[reps].toString()) != null);
  } 

  bool isCardio(List<dynamic> row){
    return (double.tryParse(row[distance].toString()) != null && double.tryParse(row[duration].toString()) != null);
  } 

  Workout workout = Workout(
      endTime: toDateTime(rows[1][end].toString()),
      startTime: toDateTime(rows[1][start].toString()),
      title: rows[1][title].toString());

  final List<Workout> workouts = [workout];
  final exerciseMap = Multimap<String, Exercise>();
  final cardioMap = Multimap<String, Cardio>();

  List<Exercise> exercises = [];
  List<Cardio> cardioList = [];

  for(List<dynamic> row in rows.skip(1)){
    final newWorkout =  Workout(
      endTime: toDateTime(row[end].toString()),
      startTime: toDateTime(row[start].toString()),
      title: row[title].toString());
    
    if(0 != newWorkout.compareTo(workout)){
      workout.addExercises(exercises);
      workout.addCardio(cardioList);
      exercises = [];
      cardioList = [];
      workouts.add(newWorkout);
      workout = newWorkout;
    }

    if(isExercises(row)){//TODO: mising exerscises whitout weight, chin up/ pull up

      final ex = Exercise(
        id: row[exercise].toString(), 
        setIndex: safeIntParse(row[set].toString()), 
        weightKg: double.parse(row[weightKg].toString()),// TODO make optioal
        reps: int.parse(row[reps].toString()), 
        workout: workout);

      exercises.add(ex);
      exerciseMap.add(ex.id, ex);
    }else if(isCardio(row)){ //TODO missing cardio without distance
      
      final cardio = Cardio(
        id: row[exercise].toString(), 
        lap: safeIntParse(row[set].toString()),
        distanceKm: double.parse(row[distance]),// TODO make optioal
        durationSeconds: double.parse(row[duration]),
        workout: workout);
        
      cardioList.add(cardio);
      cardioMap.add(cardio.id, cardio);

    }else{
      print(row);//TODO
    }
  }

  workouts.last.addExercises(exercises);
  workouts.last.addCardio(cardioList);

  return Domain(workouts: workouts, exerciseMap: exerciseMap, cardioMap: cardioMap, maleStandards: male, femaleStandards: female, muscleMap:muscleMap);
}


int safeIntParse(String i, {int defaultValue = 0}){
  return int.tryParse(i) ?? defaultValue;
}

DateTime toDateTime(String date, {format = "d MMM yyyy, HH:mm"}){

  final dateFormat = DateFormat(format);

  return dateFormat.parse(date);
}