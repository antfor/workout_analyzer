import 'workout.dart';

//"title","start_time","end_time","description","exercise_title","superset_id","exercise_notes","set_index","set_type","weight_kg","reps","distance_km","duration_seconds","rpe"

//cardio: "distance_km","duration_seconds"
//exercise: "exercise_title","set_index","weight_kg","reps","duration_seconds"
//workout: "title","start_time","end_time"

//"exercise_title","set_index","weight_kg",""reps", "duration_seconds"

class Exercise implements Comparable<Exercise> {
  
  final Workout workout;
  
  final String id; //exercise_title
  final int setIndex; //set_index[]
  final double weightKg; //weight_kg[]
  final int reps; //reps[]
  final double volume;

  Exercise({
    required this.id,
    required this.setIndex,
    required this.weightKg,
    required this.reps,
    required this.workout,
  }): volume = reps * weightKg;
  

  @override
  int compareTo(Exercise other) {
    int cmpW = workout.compareTo(other.workout);
    return cmpW == 0 ? setIndex.compareTo(other.setIndex) : cmpW;
  }
  
  @override
  String toString() =>
      'Exercise($id, set $setIndex, $weightKg kg, $reps reps)';

}