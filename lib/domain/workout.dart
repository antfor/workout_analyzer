import 'cardio.dart';
import 'exercise.dart';

/*
final workout = Workout(
  title: 'Leg Day',
  startTime: DateTime.now(),
  endTime: DateTime.now().add(Duration(hours: 1)),
  exercises: [],
);

final squat = Exercise(
  exerciseTitle: 'Squat',
  setIndex: 1,
  weightKg: 100,
  reps: 8,
  durationSeconds: 60,
  workout: workout,
);

workout.exercises.add(squat);
*/

//"title","start_time","end_time"
class Workout implements Comparable<Workout>{

  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final List<Cardio> cardio = [];
  final List<Exercise> exercises = [];

  Workout({
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  Duration get totalDuration => endTime.difference(startTime);

  void addExercises(Iterable<Exercise> list){
    exercises.addAll(list);
  }

  void addCardio(Iterable<Cardio> list){
    cardio.addAll(list);
  }

  @override
  int compareTo(Workout other) {//todo if equal also compare start time and then title
    
    return endTime.compareTo(other.endTime);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // same instance
    return other is Workout &&
        other.title == title &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.cardio == cardio &&
        other.exercises == exercises;
  }

  @override
  int get hashCode => Object.hash(title, startTime, endTime, cardio.hashCode, exercises.hashCode);

  @override
  String toString() =>
      'Workout($title, from $startTime to $endTime, duration: ${totalDuration.inMinutes} min)';
      
        
}
/*
class ExersiceWorkout{
  Workout workout;
  String id;
  int sets;
  int reps;
  double volume;
  double maxWeight;
}
*/

//get cardio, exersise dates for month, week, year, custom?
class Calender {

  List<Workout> workouts;

  Calender(this.workouts);
}