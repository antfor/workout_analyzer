import 'package:test_flutter/Domain/Orm/epely.dart';

part './exersise_value.dart';


abstract  class ExerciseValue {

  double _weight;
  int _reps;
  late double _value;
  
  ExerciseValue.empty():
    _weight = 0,
    _reps = 0,
    _value = 0;


  ExerciseValue(this._weight, this._reps){
      update(_weight, _reps);
  }

 void update(double weight, int reps);

 void _set(double weight, int reps, double value){
    
    _weight = weight;
    _reps = reps;
    _value = value;
 }

  double get weight => _weight;
  int get reps => _reps;
  double get value => _value;


  @override
  String toString() =>
      'ExerciseValue(value: $value, weight: $weight kg, reps: $reps)';
}