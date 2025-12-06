

//"distance_km","duration_seconds"

class Cardio {

  final double distanceKm;
  final int durationSeconds;

  Cardio({
    required this.distanceKm,
    required this.durationSeconds,
  });

  @override
  String toString() =>
      'Cardio(distance: $distanceKm km, duration: $durationSeconds sec)';
}