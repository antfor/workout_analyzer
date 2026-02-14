import '/data/import/csv.dart';
import '/domain/standards/muscle_group.dart';

enum ColumnName{
  exercise("Exercise"),
  muscle("Muscle");

  final String string;
  const ColumnName(this.string);
}



Future<Map<String,Muscle>> importMuscle() async{
  const file = 'assets/data/imports/exercisesLimited.csv';
  final rows = await loadCsv(file);

  if(rows.length < 2){
    return {};
  }

  final id = rows[0].indexOf(ColumnName.exercise.string);
  final im = rows[0].indexOf(ColumnName.muscle.string);

  final Map<String,Muscle> map = {};

  for(List<dynamic> row in rows.skip(1)){
    String exercise = row[id].toString();
    Muscle muscle = Muscle.fromString(row[im].toString());
    map.putIfAbsent(exercise, () => muscle);
  }

  return map;
}