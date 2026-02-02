import 'package:intl/intl.dart';

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

  WeekYear get week => WeekYear(startTime);

  void addExercises(Iterable<Exercise> list){
    exercises.addAll(list);
  }

  void addCardio(Iterable<Cardio> list){
    cardio.addAll(list);
  }

  @override
  int compareTo(Workout other) {//todo if equal also compare start time and then title
    final cmpEnd = endTime.compareTo(other.endTime);

    if(cmpEnd == 0){
      final cmpStart = startTime.compareTo(other.startTime);

      if(cmpStart==0){
        return title.compareTo(other.title);
      }

      return cmpStart;
    }

    return cmpEnd;
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

class WeekYear implements Comparable{
  late final int week;
  late final int weekYear;
  
  WeekYear(DateTime date){
    final wy = getWeekNumber(date);
    week = wy.week;
    weekYear = wy.weekYear;
  }

  WeekYear.from(this.week, this.weekYear);

  WeekYear.prev(WeekYear wy){
    if(wy.week == 1){
      weekYear = wy.weekYear - 1;
      week = weeksInYear(weekYear);
    }else{
      weekYear = wy.weekYear;
      week = wy.week-1;
    }
  }

  WeekYear get prev => WeekYear.prev(this);
  
  DateTime get isoDate {
    final jan4 = DateTime(weekYear, 1, 4);
    final mondayOfWeek1 =
        jan4.subtract(Duration(days: jan4.weekday - DateTime.monday));

    return mondayOfWeek1.add(Duration(days: (week - 1) * 7));
  }

  int difInWeeks(WeekYear other) {
    final thisDate = isoDate;
    final otherDate = other.isoDate;
    return otherDate.difference(thisDate).inDays ~/ 7;
  }

  @override
  int compareTo(other) {
    final cmpYear = weekYear.compareTo(other.weekYear);

    if(cmpYear == 0){
      return week.compareTo(other.week);
    }

    return cmpYear;
  } 

  @override 
  bool operator ==(Object other) => 
    identical(this, other) || 
    other is WeekYear && 
      week == other.week && 
      weekYear == other.weekYear; 
    
  @override 
  int get hashCode => Object.hash(week, weekYear);

  @override 
  String toString(){
    return 'weekYear: $weekYear week: $week';
  }

  ({int week, int weekYear}) getWeekNumber(DateTime date) {
    int doy = int.parse(DateFormat("D").format(date));
    int w =  ((10 + doy - date.weekday) / 7).floor();
    int woy = w;
    int weekYear = date.year;
    if (w < 1) {
      woy = weeksInYear(date.year - 1);
      weekYear -= 1; 
    } else if (w > weeksInYear(date.year)) {
      woy = 1;
      weekYear += 1;
    }
    return (week:woy, weekYear:weekYear);
  }

  int weeksInYear(int year){
    p(int y) => (y + (y/4).floor() - (y/100).floor() + (y/400).floor()) % 7;

    if(p(year) == 4 || p(year - 1) == 3){
      return 53;
    }
    return 52;
  }

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