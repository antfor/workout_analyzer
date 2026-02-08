
import 'package:test_flutter/domain/exercise.dart';

abstract class IUpdate {
  void update(double weight, int reps);
}

abstract class IExerciseUpdate {
  void update(Exercise e);
  void done(String id);
}