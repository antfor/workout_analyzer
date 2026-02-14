import '/data/import/csv.dart';
import '/domain/standards/standards.dart';

enum ColumnName{
  exercise("Exercise"),
  count("Count"),

  ratio("Bodyweight Ratio"),
  level("Strength Level"),
  bodyweight("Bodyweight"),

  beginner("Beginner"),
  novice("Novice"),
  intermediate("Intermediate"),
  advanced("Advanced"),
  elite("Elite");

  final String string;

  const ColumnName(this.string);

  static ColumnName getColumn(String name) => ColumnName.values.firstWhere((v)=>v.string==name);
}

const _path = 'assets/data/standards/limited/';


Future<Standards> importMale(Map<String, String> mapNames) async{

  final reps = await importTable("male_standards_reps.csv", safeRepParse);
  final weight = await importTable("male_standards_weight.csv", safeIntParse);
  final ratio = await importRatio("male_standards_ratio.csv");

  return Standards.male(reps:reps, weight: weight, ratio: ratio, mapNames: mapNames);
}

Future<Standards> importFemale(Map<String, String> mapNames) async{

  final reps = await importTable("female_standards_reps.csv", safeRepParse);
  final weight = await importTable("female_standards_weight.csv", safeIntParse);
  final ratio = await importRatio("female_standards_ratio.csv");

  return Standards.female(reps:reps, weight: weight, ratio: ratio, mapNames: mapNames);
}

Future<Map<String, int>> importExercises() async{
  final file = "exercises.csv";
  final rows = await loadCsv(_path + file);

  if(rows.length < 2){
    return {};
  }
  
  final exercise = rows[0].indexOf(ColumnName.exercise.string);
  final count = rows[0].indexOf(ColumnName.count.string);
  final Map<String, int> map = {};
  for(List<dynamic> row in rows.skip(1)){
    map.putIfAbsent(row[exercise].toString(), () => safeIntParse(row[count].toString()));
  }

  return map;
}

Future<List<StandardTable>> importTable(String file, int Function(String) parse) async{
  
  final rows = await loadCsv(_path + file);

  if(rows.length < 2){
    return [];
  }

  final iExercise = rows[0].indexOf(ColumnName.exercise.string);

  final ibw = rows[0].indexOf(ColumnName.bodyweight.string); //TODO look that it is not -1, then throw
  final ib = rows[0].indexOf(ColumnName.beginner.string);
  final ino = rows[0].indexOf(ColumnName.novice.string);
  final ii = rows[0].indexOf(ColumnName.intermediate.string);
  final ia = rows[0].indexOf(ColumnName.advanced.string);
  final ie = rows[0].indexOf(ColumnName.elite.string);

  final List<StandardTable> tables = [];
  List<int> bw = [];
  List<int> beginner = [];
  List<int> novice = [];
  List<int> intermediate = [];
  List<int> advanced = [];
  List<int> elite = [];

  
  String current = rows[1][iExercise].toString();

  for(List<dynamic> row in rows.skip(1)){
    final exercise = row[iExercise].toString();

    if(exercise != current){
      
      tables.add(StandardTable(current, bw, beginner, novice, intermediate, advanced, elite));
      bw = [];
      beginner = [];
      novice = [];
      intermediate = [];
      advanced = [];
      elite = [];
      current = exercise;
    }

    bw.add(safeIntParse(row[ibw].toString()));
    
    beginner.add(parse(row[ib].toString()));//TODO do parse(row, i) and make sure it it not out of bound in parse
    novice.add(parse(row[ino].toString()));
    intermediate.add(parse(row[ii].toString()));
    advanced.add(parse(row[ia].toString()));
    elite.add(parse(row[ie].toString()));
  }

  tables.add(StandardTable(current, bw, beginner, novice, intermediate, advanced, elite));

  return tables;

}



Future<List<StandardRatio>> importRatio(String file) async{
  final rows = await loadCsv(_path + file);

  if(rows.length < 2){
    return [];
  }

  final iExercise = rows[0].indexOf(ColumnName.exercise.string);
  final iRatio = rows[0].indexOf(ColumnName.ratio.string);
  final iLevel = rows[0].indexOf(ColumnName.level.string);

  final List<StandardRatio> tables = [];
 
  Map<Level, double> map = {};
  
  
  String current = rows[1][iExercise].toString();

  const double defaultValue = -1;
  getValue(Level l) => map[l] ?? defaultValue;

  for(List<dynamic> row in rows.skip(1)){
    final exercise = row[iExercise].toString();

    if(exercise != current){
      current = exercise;
      tables.add(StandardRatio(exercise, getValue(Level.beginner), getValue(Level.novice), getValue(Level.intermediate), getValue(Level.advanced), getValue(Level.elite)));
      map.clear();
    }

    final level = parseLevel(row[iLevel]);
    final ratio = parseRatio(row[iRatio]);
    map.putIfAbsent(level, ()=>ratio);
  }

  return tables;
}

double parseRatio(String s){
  final cleaned = s.replaceAll(RegExp(r'[^-0-9.]+'), '');
  return double.tryParse(cleaned) ?? 0;
}

Level parseLevel(String s){
  final col = ColumnName.getColumn(s);
  switch(col){
    case ColumnName.beginner: return Level.beginner;
    case ColumnName.novice: return Level.novice;
    case ColumnName.intermediate: return Level.intermediate;
    case ColumnName.advanced: return Level.advanced;
    case ColumnName.elite: return Level.elite;
    default: throw Exception("no valid strength level in ratio csv");
  }
 
}
int safeRepParse(String s){
    const zero = "< 1";
    if(s == zero){
      return 0;
    }
    return safeIntParse(s);
}

int safeIntParse(String i, {int defaultValue = 0}){
  return int.tryParse(i) ?? defaultValue;
}