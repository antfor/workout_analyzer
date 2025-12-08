import 'exercise.dart';
import 'orm/epely.dart';
import 'dart:math' as math;


// todo make lazy? NO, only create this when needed instead. lazy cerate
class Lift {
  final String id;
  final List<Exercise> lifts;
  final Map<int, double> repMaxWeight;
  //final OrmData ormData;

  final Exercise? maxVolume;
  final double orm;
  final double maxWeight;
  final double maxDuration;

  Lift._({
    required this.id,
    required this.lifts,
    required this.orm,
    required this.maxWeight,
    required this.maxVolume,
    required this.maxDuration,
    required this.repMaxWeight,
  }); //: ormData = OrmData(orm);

  factory Lift(String id, List<Exercise> exercises) {
    final filtered = exercises.where((e) => e.id == id).toList();

    if (filtered.isEmpty) {
      return Lift._(
        id: id,
        lifts: filtered,
        orm: 0,
        maxWeight: 0,
        maxVolume: null,
        maxDuration: 0,
        repMaxWeight: {},
      );
    }

    filtered.sort();

    double maxWeight = 0;
    double maxDuration = 0;
    double orm = 0;
    final Map<int, double> repMaxWeight = {};
    Exercise maxVolume = filtered.first;

    for (final e in filtered) {

      orm = math.max(orm, epleyORM(e.weightKg, e.reps));
      maxWeight = math.max(maxWeight, e.weightKg);
      //maxDuration = math.max(maxDuration, e.durationSec);

      if (e.volume > maxVolume.volume) maxVolume = e;

      repMaxWeight.update(e.reps, (v) => math.max(v, e.weightKg), ifAbsent: () => e.weightKg);
    }

    return Lift._(
      id: id,
      lifts: filtered,
      orm: orm,
      maxWeight: maxWeight,
      maxVolume: maxVolume,
      maxDuration: maxDuration,
      repMaxWeight: repMaxWeight,
    );
  }

}
