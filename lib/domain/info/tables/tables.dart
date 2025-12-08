
import 'package:test_flutter/domain/info/i_info.dart';
import 'package:test_flutter/domain/info/values/value/abstract_value.dart';
import 'package:test_flutter/domain/table/orm.dart';
import 'dart:math' as math;



class Tables implements IUpdate{

  late final OrmData? _ormData;
  late final NewOrmData? _newOrmData;
  final RepPb repPB =  RepPb.empty();
  final ExerciseValue ormValue;

  Tables(this.ormValue);

  @override
  void update(reps, weight){
    repPB.update(reps, weight);
  }
  //todo make OrmData take Exersice value
  //Make Exersice value take liseners if value if update and add OrmData to it
  OrmData get ormData{
    _ormData ??= OrmData(ormValue.value); 
    return _ormData!;
  } 
  NewOrmData get newOrmData{
    _newOrmData ??= NewOrmData(ormValue.value);
    return _newOrmData!;
  }

}

class RepPb implements IUpdate{

  final Map<int, double> _map = {};

  RepPb.empty();

  @override
  void update(weight, reps){
    _map.update(reps, (v) => math.max(v, weight), ifAbsent: () => weight);
  }

  Iterable<int> get reps => _map.keys;
  Iterable<double> get weight => _map.values;
}