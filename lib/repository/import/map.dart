import '/data/import/csv.dart';

enum ColumnName{
  workout("Workout"),
  standards("Strandards");

  final String string;
  const ColumnName(this.string);
}



Future<Map<String,String>> importMap() async{
  const file = 'assets/data/map/mapLimited.csv';
  final rows = await loadCsv(file);

  if(rows.length < 2){
    return {};
  }

  final wi = rows[0].indexOf(ColumnName.workout.string);
  final si = rows[0].indexOf(ColumnName.standards.string);

  final Map<String,String> map = {};

  for(List<dynamic> row in rows.skip(1)){ //TODO make handle empty rows
    String workout = row[wi].toString();
    String standards = row[si].toString();
    map.putIfAbsent(workout, () => standards);
  }

  return map;
}