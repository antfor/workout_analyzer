part of 'abstract_value.dart';


class OrmV extends ExerciseValue {
  
  OrmV.empty() : super.empty();

  OrmV(super.weight, super.reps);


  @override
  void update(double weight, int reps) {
    final newOrm = epleyORM(weight, reps);
    if(newOrm > value){
      _set(weight,reps,newOrm); 
    }
    
  }
}

class VolumeV extends ExerciseValue {

  VolumeV.empty() : super.empty();


  VolumeV(super.weight, super.reps);

  @override
  void update(double weight, int reps) {
    final newVolume = weight*reps;
    if(newVolume > value){
      _set(weight,reps,newVolume);
    }
  }
}

class WeightV extends ExerciseValue {

  WeightV.empty() : super.empty();

  WeightV(super.weight, super.reps);

  @override
  void update(double weight, int reps) {

    if(weight > super.weight || (weight == super.weight && reps > super.reps)){
      _set(weight,reps,weight);
    }
  }
}
