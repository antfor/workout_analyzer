import 'package:drift/drift.dart';
import 'package:workout_analyzer/data/local/drift/database.dart' as db;
import 'package:workout_analyzer/domain/workout.dart';

typedef UserData = (List<db.WorkoutsCompanion>, List<db.LiftCompanion>, List<db.CardioCompanion>);

UserData userData(Iterable<Workout> workouts){

      final workoutsInserts = <db.WorkoutsCompanion>[];
      final liftInserts = <db.LiftCompanion>[];
      final cardioInserts = <db.CardioCompanion>[];

      for (final workout in workouts){
        workoutsInserts.add(
          db.WorkoutsCompanion.insert(
            title: workout.title,
            startTime: workout.startTime.millisecondsSinceEpoch.toDouble() ,
            endTime: workout.endTime.millisecondsSinceEpoch.toDouble(),
          ),
        );
        //Lift
        final ids = workout.exercises.map((e)=> e.id);
        final setId = ids.toSet();
        for(final id in setId){
          int setOfSets = 1;
          for(final lift in workout.exercises.where((e)=>e.id==id)){
            liftInserts.add(
              db.LiftCompanion.insert(exercise:lift.id, setOfSets:setOfSets, setIndex:lift.setIndex, reps:lift.reps, weightKg: Value(lift.weightKg), workout:workout.id),);
            setOfSets +=1;
          }
        }/*
        for(final lift in workout.exercises){
          liftInserts.add(
            db.LiftCompanion.insert(exercise:lift.id, setOfSets:1, setIndex:lift.setIndex, reps:lift.reps, weightKg: Value(lift.weightKg), workout:workout.id),);
        }
        */
        //cardio
        for(final cardio in workout.cardio){
          cardioInserts.add(
            db.CardioCompanion.insert(exercise: cardio.id, lap: cardio.lap, workout: workout.id, distanceM: Value(cardio.distanceKm), durationS: Value(cardio.durationSeconds))
          );

        }
      }

      return (workoutsInserts,liftInserts,cardioInserts);
}