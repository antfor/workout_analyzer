import 'dart:math' as math;
import 'package:workout_analyzer/domain/cardio.dart';
import 'package:workout_analyzer/domain/info/i_info.dart';

final _distances = [10000,5000,2240,1000,800,400,200,100].map((d) => d/1000).toList()..sort((a,b)=> b.compareTo(a));

class DistPb implements IUpdate<Cardio>{

  final Map<double, double> _map = {};

  DistPb.empty();

  @override
  void update(Cardio cardio){
    double distance = cardio.distanceKm;
    double time = cardio.durationSeconds;

    final bracket = _distances.firstWhere((d) => d <= distance, orElse: ()=>-1);
    if(bracket > 0){
      final lapTime = bracket/distance * time;
      _map.update(bracket, (t) => math.min(t, lapTime), ifAbsent: () => lapTime);
    }
  }

  Iterable<double> get dist => _map.keys;
  Iterable<double> get time => _map.values;
  Iterable<MapEntry<double, double>> get data => _map.entries;
}