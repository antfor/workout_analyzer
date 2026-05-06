import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workout_analyzer/data/local/drift/database.dart' as db;
import 'package:workout_analyzer/domain/cardio.dart';
import 'package:workout_analyzer/domain/exercise.dart';
import 'package:workout_analyzer/domain/workout.dart';

enum Table{
  workout('private.workouts'),
  lift('private.lift'),
  cardio('private.cardio');

  final String id;

  const Table(this.id);

}

class Remote{

  final db.SharedDatabase local;
  final SupabaseClient remote;

  Remote(this.local, this.remote,);

  String? get uuid => remote.auth.currentUser?.id;

  Future<void> pull()async{
    final workout = await remote.from(Table.workout.id).select();
    final lift = await remote.from(Table.lift.id).select();
    final cardio = await remote.from(Table.cardio.id).select();

  }

  Future<String?> import2(List<Workout> workouts)async{

    final uuid = this.uuid;
    if(uuid == null) return "Not logged in";

    try {
      final now = DateTime.now().toIso8601String();
      await remote.from(Table.lift.id).update({"deleted_at": now});
      await remote.from(Table.cardio.id).update({"deleted_at": now});
      await remote.from(Table.workout.id).update({"deleted_at": now});
    
      await pushWorkouts(workouts);

      await remote.from(Table.lift.id).delete().eq('deleted_at', now);
      await remote.from(Table.cardio.id).delete().eq('deleted_at', now);
      await remote.from(Table.workout.id).delete().eq('deleted_at', now);
    }catch(e){
      debugPrint("Import failed: $e");
      return e.toString();
    }

    return null;
  }

  Future<void> pushWorkouts(List<Workout> workouts)async{

    final uuid = this.uuid;
    if(uuid == null) return;

    Map<String, Object> json(Workout w) => {
      "user_id":uuid, 
      "title":w.title, 
      "start_time":w.startTime.toIso8601String(), 
      "end_time":w.endTime.toIso8601String()
    };

    final package = workouts.map(json).toList();
    final result = await remote.from(Table.workout.id).insert(package).select();
    final ids = result.map((r)=> r["id"]).toList();

    for(int i = 0; i< workouts.length; i++){
      workouts[i].setID(ids[i]);
    }

    final exercises = workouts.expand((w) => w.exercises).toList();
    await pushExercises(exercises);

    final cardio = workouts.expand((w) => w.cardio).toList();
    await pushCardio(cardio);
    
  }

  Future<void> pushExercises(List<Exercise> exercises)async{

    final uuid = this.uuid;
    if(uuid == null) return;

    Map<String, Object> json(Exercise e) => {
      "user_id":uuid, 
      "exercise": e.id,
      "set_of_sets": e.setOfSets,
      "set_index": e.setIndex,
      "reps": e.reps,
      "weight_kg": e.weightKg,
      "workout": e.workout.id,
    };

    final package = exercises.map(json).toList();
    await remote.from(Table.lift.id).insert(package);

  }

  Future<void> pushCardio(List<Cardio> cardio)async{

    final uuid = this.uuid;
    if(uuid == null) return;

    Map<String, Object> json(Cardio c) => {
      "user_id":uuid, 
      "exercise": c.id,
      "lap": c.lap,
      "distance_m": c.distanceKm*1000,
      "duration_s": c.durationSeconds,
      "workout": c.workout.id,
    };

    final package = cardio.map(json).toList();
    await remote.from(Table.cardio.id).insert(package);
  }


  Future<String?> import(List<Workout> workouts)async{

    final uuid = this.uuid;
    if(uuid == null) return "Not logged in";

    try {
      final wjson = workouts.map(workoutJson);

      final exercises = workouts.expand((w) => w.exercises);
      final ejson = exercises.map(exerciseJson);

      final cardio = workouts.expand((w) => w.cardio).toList();
      final cjson = cardio.map(cardioJson);

      await remote.rpc('import_workouts', params: {
        '_user': uuid,
        '_workouts': wjson,
        '_exercises': ejson,
        '_cardio': cjson,
      });
      return null;

    }catch(e){
      debugPrint("Import failed: $e");
      return e.toString();
    }
  }


  Map<String, Object?> exerciseJson(Exercise e) => {
      "user_id":uuid, 
      "exercise": e.id,
      "set_of_sets": e.setOfSets,
      "set_index": e.setIndex,
      "reps": e.reps,
      "weight_kg": e.weightKg,
      "workout": e.workout.id,
  };

  Map<String, Object?> cardioJson(Cardio c) => {
      "user_id":uuid, 
      "exercise": c.id,
      "lap": c.lap,
      "distance_m": c.distanceKm*1000,
      "duration_s": c.durationSeconds,
      "workout": c.workout.id,
  };

  Map<String, Object?> workoutJson(Workout w) => {
      "user_id":uuid, 
      "id": w.id, //TODO do not handle IDs in flutter
      "title":w.title, 
      "start_time":w.startTime.toIso8601String(), 
      "end_time":w.endTime.toIso8601String()
  };
}