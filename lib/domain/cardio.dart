

//"distance_km","duration_seconds"

class Cardio {

  final String id;
  final double distanceKm;
  final int durationSeconds;

  Cardio({
    required this.id,
    required this.distanceKm,
    required this.durationSeconds,
  });

  @override
  String toString() =>
      'Cardio(id: $id distance: $distanceKm km, duration: $durationSeconds sec)';
}