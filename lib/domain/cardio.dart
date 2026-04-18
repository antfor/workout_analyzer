import 'package:workout_analyzer/domain/workout.dart';

class Cardio implements Comparable<Cardio>  {

  final String id;
  final int lap;
  final double distanceKm;
  final double durationSeconds;
  final Workout workout;

  Cardio({
    required this.id,
    required this.lap,
    required this.distanceKm,
    required this.durationSeconds,
    required this.workout,
  });

  /* 
    pace per distance, like you dont want to compare 5km and 100m pace, ony comare between similar distances
    button option/setting? to compare to diffrent distances

    translate to 5km time
    graph total time
    graph distane

     
  // */
  double get paceSec => durationSeconds/distanceKm;
  ({int min, double sec})  get pace => (min: paceSec~/60, sec: paceSec % 60);
  static String toPace(num sec, {int decimals=2}) => "${sec~/60}:${(sec%60).toStringAsFixed(decimals)}";

  String get duration => calcDuration(durationSeconds);

  static String calcDuration(double time,{int decimals = 2, bool compact = false}){
    final hours = time ~/ 3600;
    final minutes = (time % 3600) ~/ 60;
    final seconds = time % 60;

    final buffer = StringBuffer();

    if (hours > 0) buffer.write("$hours${compact ? ":" : "h "}");
    if ((hours > 0 &&  seconds > 0) || minutes > 0) buffer.write("$minutes${compact ? ":" : "m "}");

    if (seconds > 0) {
      final fixed = seconds.truncate() == seconds ? 0 : decimals;
      buffer.write("${seconds.toStringAsFixed(fixed)}${compact ? "" : "s"}");
    }

    return buffer.toString();
  }

   @override
  int compareTo(Cardio other) {
    int cmpW = workout.compareTo(other.workout);
    if(cmpW != 0) return cmpW;

    int cmpId = id.compareTo(other.id);
    if(cmpId != 0) return cmpId;

    return lap.compareTo(other.lap);
  }

  @override
  String toString() =>
      'Cardio(id: $id distance: $distanceKm km, duration: $durationSeconds sec)';
}