import 'dart:math' as math;

const eliteIndex = 4;

enum Level {
  beginner(0.05),
  novice(0.2),
  intermediate(0.5),
  advanced(0.8),
  elite(0.95);

  final double percentage;
  const Level(this.percentage);

  static Level byIndex(int i){
    final index = math.min(math.max(0,i),eliteIndex);
    return Level.values[index];
  }
  static Level next(Level lvl){
    final i = Level.values.indexOf(lvl);
    return byIndex(i+1);
  }

  static Level prev(Level lvl){
    final i = Level.values.indexOf(lvl);
    return byIndex(i-1);
  }
}

enum Sex {
  male("male"),
  female("female");

  final String string;
  const Sex(this.string);
}

Standards? _male;
Standards? _female;

class Standard{
  final String id;
  final Sex sex;
  final StandardTable? weight;
  final StandardTable? reps;
  final StandardRatio? ratio;

  Standard(this.id, this.sex, this.weight, this.reps, this.ratio);
}

class Standards{

  final Sex sex;
  final List<StandardTable> weights;
  final List<StandardTable> reps;
  final List<StandardRatio> ratios;
  final Map<String, String> mapNames;

  Standards._male({required this.weights, required this.reps, required this.ratios, required this.mapNames}):sex=Sex.male;
  Standards._female({required this.weights, required this.reps, required this.ratios, required this.mapNames}):sex=Sex.female;

  factory Standards(Sex sex, {required weight, required reps, required ratio, required Map<String, String> mapNames}){
    if(sex == Sex.male){
      _male ??= Standards._male(weights: weight, reps: reps, ratios: ratio, mapNames: mapNames);
      return _male!; 
    }else{
      _female ??= Standards._female(weights: weight, reps: reps, ratios: ratio, mapNames: mapNames);
       return _female!; 
    }
  }

  factory Standards.male({required List<StandardTable> weight, required List<StandardTable> reps, required List<StandardRatio> ratio, required Map<String, String> mapNames}){

    _male ??= Standards._male(weights: weight, reps: reps, ratios: ratio, mapNames: mapNames);

    return _male!;
  }

  factory Standards.female({required List<StandardTable> weight, required List<StandardTable> reps, required List<StandardRatio> ratio, required Map<String, String> mapNames}){

    _female ??= Standards._female(weights: weight, reps: reps, ratios: ratio, mapNames: mapNames);
    
    return _female!; 
  }

  Standard getStandard(String workoutName){

      String name = mapNames[workoutName] ?? workoutName;
      
      final wi = weights.indexWhere((w)=> cmpS(w.id,name));
      final ri = reps.indexWhere((w)=> cmpS(w.id,name));
      final ir = ratios.indexWhere((w)=> cmpS(w.id,name));

      final weight = wi == -1 ? null : weights[wi];
      final rep = ri == -1 ? null : reps[ri];
      final ratio = ir == -1 ? null : ratios[ir];

      return Standard(name, sex, weight, rep, ratio);
  }
}

bool cmpS(String a, String b){
  return a.toLowerCase().trim() == b.toLowerCase().trim();
}

class StandardRatio {

  final String id;
  final double beginner;
  final double novice;
  final double intermediate;
  final double advanced;
  final double elite;

  StandardRatio(this.id, this.beginner, this.novice, this.intermediate, this.advanced, this.elite);

  double levelRatio(Level level) {
    switch(level){
      case Level.beginner: return beginner;
      case Level.novice: return novice;
      case Level.intermediate: return intermediate;
      case Level.advanced: return advanced;
      case Level.elite: return elite;
    }
  }

  List<double> get ratios => [beginner, novice, intermediate, advanced, elite];
    //0, 0.05, 0.2, 0.5, 0.8, 0.95, 1
  

  Level level(double bw, double lift){
    final ratio = (lift/bw);
    int index = ratios.indexWhere((r) =>  r < ratio );
    if(index == -1){
      return Level.elite;
    }
    index = math.max(0, index-1);
    return Level.byIndex(index);
  }

}

class StandardTable {

  final Iterable<int> bodyweight;

  final String id;
  final List<int> beginner;
  final List<int> novice;
  final List<int> intermediate;
  final List<int> advanced;
  final List<int> elite;

  StandardTable(this.id, this.bodyweight, this.beginner, this.novice, this.intermediate, this.advanced, this.elite);

  int value(double bw, Level level) {
    int wclass = bodyweight.firstWhere((b) => bw <= b);
    wclass = wclass == -1 ? bodyweight.last : wclass;

    switch(level){
      case Level.beginner: return beginner[wclass];
      case Level.novice: return novice[wclass];
      case Level.intermediate: return intermediate[wclass];
      case Level.advanced: return advanced[wclass];
      case Level.elite: return elite[wclass];
    }
  }

  List<int> standrads(int bw) => [beginner, novice, intermediate, advanced, elite].map((l)=>l.toList()[bw]).toList();
  
  Level level(double bw, double lift){
    int wclass = bodyweight.firstWhere((b) => bw <= b);
    wclass = wclass == -1 ? bodyweight.last : wclass;

    int index = standrads(wclass).indexWhere((sd) => lift < sd);
    index = index == -1 ? eliteIndex : index-1;

    return Level.byIndex(index);
  }
}