
import 'package:workout_analyzer/data/local/drift/database.dart';
import 'package:workout_analyzer/domain/domain.dart';
import 'package:workout_analyzer/domain/standards/muscle_group.dart' as data;
import 'package:workout_analyzer/domain/standards/standards.dart';

typedef StaticData = (List<ExercisesCompanion>, List<MuscleCompanion>, List<EquipmentCompanion>, List<StandardsWeightCompanion>);

StaticData staticData(Domain domain){

  final male = domain.maleStandards;
  final female = domain.femaleStandards;

  //Exercises
      final exercisesInserts = <ExercisesCompanion>[];

      for (final exercise in domain.exercises) {
        exercisesInserts.add(
          ExercisesCompanion.insert(id: exercise, muscle:domain.getMuscle(exercise).string),);
      }

      //Muscle
      final muscleInserts = <MuscleCompanion>[];
      
      for (final muscle in data.Muscle.values) {
        muscleInserts.add(
          MuscleCompanion.insert(id: muscle.string),);
      }

      //Equipment
      final equipmentInserts = <EquipmentCompanion>[];
      for (final equipment in data.Equipment.values) {
        equipmentInserts.add(
          EquipmentCompanion.insert(id: equipment.string),);
      }

      //Standards
      //StandardsWeight
      final swInserts = <StandardsWeightCompanion>[];
      void addStandards(String sex, List<StandardTable> standards) {
        for (final s in standards) {
          for (int i = 0; i < s.bodyweight.length; i++) {
            swInserts.add(_toCompanion(s, i, sex));
          }
        }
      }
      addStandards('male', male.weights);
      addStandards('female', female.weights);

      //StandardsReps //TODO
      //final srInserts = <StandardsReps>[];
      //StandardsCardio
      //final scInserts = <StandardsReps>[]; 

  return (exercisesInserts, muscleInserts, equipmentInserts, swInserts);
}

  StandardsWeightCompanion _toCompanion(StandardTable s, int i, String sex) {
  return StandardsWeightCompanion.insert(
    exercise: s.id,
    sex: sex,
    bodyweight: s.bodyweight[i].toDouble(),
    beginner: s.beginner[i].toDouble(),
    novice: s.novice[i].toDouble(),
    intermediate: s.intermediate[i].toDouble(),
    advanced: s.advanced[i].toDouble(),
    elite: s.elite[i].toDouble(),
  );
}