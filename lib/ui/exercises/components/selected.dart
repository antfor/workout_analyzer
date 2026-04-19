import 'package:workout_analyzer/domain/info/cardio/cardio_info.dart';
import 'package:workout_analyzer/domain/info/i_info.dart';
import 'package:workout_analyzer/domain/info/lift_info.dart';

class Selected{

  LiftBasicInfo? _selectedLift;
  CardioBasicInfo? _selectedCardio;

  LiftBasicInfo? get lift => _selectedLift;
  CardioBasicInfo? get cardio => _selectedCardio;

  Selected();

  void selectCardio(CardioBasicInfo cardio){
    _selectedLift = null;
    _selectedCardio = cardio;
  }

  void selectLift(LiftBasicInfo lift){
    _selectedCardio = null;
    _selectedLift = lift;
    
  }

  void select(LiftBasicInfo? lift, CardioBasicInfo? cardio){
    _selectedLift = lift;
    _selectedCardio = lift == null ? cardio : null;
  }

  void exit(){
    _selectedLift = null;
    _selectedCardio = null;
  }

  bool hasSelected(){
    return _selectedLift != null || _selectedCardio != null;
  }

  IInfo? get selected =>  _selectedLift ?? _selectedCardio;

}