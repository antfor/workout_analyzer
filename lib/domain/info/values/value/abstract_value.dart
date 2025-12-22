import 'package:test_flutter/domain/info/i_info.dart';
import 'package:test_flutter/domain/orm/epely.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

part 'value.dart';


abstract  class ExerciseValue implements IUpdate {

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

 @override
 void update(double weight, int reps);

 void _set(double weight, int reps, double value){
    
    _weight = weight;
    _reps = reps;
    _value = value;
 }

  double get weight => _weight;
  int get reps => _reps;
  double get value => _value;

  double _roundTo(double n, [int d = 0]) {
    final pow = math.pow(10, d);
    return (n * pow).round() / pow;
  }

  String simplifyValue(int decimals) {
    final rounded = _roundTo(value, decimals);

    return NumberFormat.decimalPattern('en_US').format(rounded + 0);
  }

  @override
  String toString() =>
      'ExerciseValue(value: $value, weight: $weight kg, reps: $reps)';
}