import '/domain/info/i_info.dart';
import '/domain/info/values/value/abstract_value.dart';


class ExerciseValues implements IUpdate{

  final ExerciseValue _orm = OrmValue.empty();
  final ExerciseValue _maxWeight = WeightValue.empty();
  final ExerciseValue _maxVolume = VolumeValue.empty();

  ExerciseValues();

  @override
  void update(double weight, int reps){
    
    _orm.update(weight, reps);
    _maxWeight.update(weight, reps);
    _maxVolume.update(weight, reps);
  }

  ExerciseValue get orm => _orm;
  ExerciseValue get maxWeight => _maxWeight;
  ExerciseValue get maxVolume => _maxVolume;

}
