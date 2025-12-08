
import 'package:test_flutter/Domain/history/values/value/abstract_exercise_value.dart';


class ExerciseValues {

  final ExerciseValue _orm = OrmV.empty();
  final ExerciseValue _maxWeight = WeightV.empty();
  final ExerciseValue _maxVolume = VolumeV.empty();

  ExerciseValues();

  void update(double weight, int reps){
    _orm.update(weight, reps);
    _maxWeight.update(weight, reps);
    _maxVolume.update(weight, reps);
  }

  ExerciseValue? get orm => _orm;
  ExerciseValue? get maxWeight => _maxWeight;
  ExerciseValue? get maxVolume => _maxVolume;

}
