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
            id: workout.id,
            title: workout.title,
            startTime: workout.startTime.toUtc().toIso8601String(),
            endTime: workout.endTime.toUtc().toIso8601String(),
          ),
        );

        //Lift
        final unique = workout.exercises.map((e)=>e.id).toSet();
        for(final id in unique){
          final exercises =  workout.exercises.where((e) => e.id == id);
          int setOfSets = 0;
          for(final lift in exercises){
            if(lift.setIndex == 0) setOfSets +=1;

            liftInserts.add(
              db.LiftCompanion.insert(exercise:lift.id, setOfSets:setOfSets, setIndex:lift.setIndex, reps:lift.reps, weightKg: Value(lift.weightKg), workout:workout.id),);
          }
        }
      
        //cardio
        for(final cardio in workout.cardio){
          cardioInserts.add(
            db.CardioCompanion.insert(exercise: cardio.id, lap: cardio.lap, workout: workout.id, distanceM: Value(cardio.distanceKm), durationS: Value(cardio.durationSeconds))
          );

        }
      }

      return (workoutsInserts,liftInserts,cardioInserts);
}