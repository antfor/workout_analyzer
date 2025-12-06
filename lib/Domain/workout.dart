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
class Workout {

  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final List<Cardio> cardio;
  final List<Exercise> exercises;

  Workout({
    required this.title,
    required this.startTime,
    required this.endTime,
    this.cardio = const [],
    this.exercises = const [],
  });

  Duration get totalDuration => endTime.difference(startTime);

  @override
  String toString() =>
      'Workout($title, from $startTime to $endTime, duration: ${totalDuration.inMinutes} min)';
}