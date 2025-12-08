part of 'abstract_value.dart';


class OrmValue extends ExerciseValue {
  
  OrmValue.empty() : super.empty();

  OrmValue(super.weight, super.reps);


  @override
  void update(double weight, int reps) {
    final newOrm = epleyORM(weight, reps);
    if(newOrm > value){
      _set(weight,reps,newOrm); 
    }
    
  }
}

class VolumeValue extends ExerciseValue {

  VolumeValue.empty() : super.empty();


  VolumeValue(super.weight, super.reps);

  @override
  void update(double weight, int reps) {
    final newVolume = weight*reps;
    if(newVolume > value){
      _set(weight,reps,newVolume);
    }
  }
}

class WeightValue extends ExerciseValue {

  WeightValue.empty() : super.empty();

  WeightValue(super.weight, super.reps);

  @override
  void update(double weight, int reps) {

    if(weight > super.weight || (weight == super.weight && reps > super.reps)){
      _set(weight,reps,weight);
    }
  }
}
