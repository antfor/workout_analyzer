import 'package:workout_analyzer/data/local/drift/database.dart';
import 'package:workout_analyzer/domain/standards/muscle_group.dart' as domain;
import 'package:workout_analyzer/domain/standards/standards.dart' as domain;
import 'package:workout_analyzer/domain/workout.dart' as domain;


extension WorkoutMapper on Workout {
  domain.Workout toLocal() {
    return domain.Workout(
      id: id,
      title: title,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
    );
  }
}

extension ExerciseMapper on Exercise {
  MapEntry<String, domain.Muscle> toLocal() {
    return MapEntry(id, domain.Muscle.fromString(muscle));
  }
}

class StandardsWeightMapper {
  static domain.StandardTable fromRows(String exerciseId, List<StandardsWeightData> rows) {
    return domain.StandardTable(
      exerciseId,
      rows.map((r) => r.bodyweight).toList(),
      rows.map((r) => r.beginner).toList(),
      rows.map((r) => r.novice).toList(),
      rows.map((r) => r.intermediate).toList(),
      rows.map((r) => r.advanced).toList(),
      rows.map((r) => r.elite).toList(),
    );
  }
}

class StandardsRepsMapper {
  static domain.StandardTable fromRows(String exerciseId, List<StandardsRep> rows) {
    return domain.StandardTable(
      exerciseId,
      rows.map((r) => r.bodyweight).toList(),
      rows.map((r) => r.beginner).toList(),
      rows.map((r) => r.novice).toList(),
      rows.map((r) => r.intermediate).toList(),
      rows.map((r) => r.advanced).toList(),
      rows.map((r) => r.elite).toList(),
    );
  }
}