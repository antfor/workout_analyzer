

enum Level {
  beginner(0.05),
  novice(0.2),
  intermediate(0.5),
  advanced(0.8),
  elite(0.95);

  final double percentage;
  const Level(this.percentage);
}

enum Sex {
  male("male"),
  female("female");

  final String string;
  const Sex(this.string);
}

Standards? _male;
Standards? _female;

class Standards{

  final Sex sex;
  final List<StandardTable> weight;
  final List<StandardTable> reps;
  final List<StandardRatio> ratio;

  Standards._male({required this.weight, required this.reps, required this.ratio}):sex=Sex.male;
  Standards._female({required this.weight, required this.reps, required this.ratio}):sex=Sex.female;

  factory Standards(Sex sex, {required weight, required reps, required ratio}){
    if(sex == Sex.male){
      _male ??= Standards._male(weight: weight, reps: reps, ratio: ratio);
      return _male!; 
    }else{
      _female ??= Standards._female(weight: weight, reps: reps, ratio: ratio);
       return _female!; 
    }
  }

  factory Standards.male({required List<StandardTable> weight, required List<StandardTable> reps, required List<StandardRatio> ratio}){

    _male ??= Standards._male(weight: weight, reps: reps, ratio: ratio);

    return _male!;
  }

  factory Standards.female({required List<StandardTable> weight, required List<StandardTable> reps, required List<StandardRatio> ratio}){

    _female ??= Standards._female(weight: weight, reps: reps, ratio: ratio);
    
    return _female!; 
  }
}

class StandardRatio {

  final String id;
  final double beginner;
  final double novice;
  final double intermediate;
  final double advanced;
  final double elite;

  StandardRatio(this.id, this.beginner, this.novice, this.intermediate, this.advanced, this.elite);

  double level(Level level) {
    switch(level){
      case Level.beginner: return beginner;
      case Level.novice: return novice;
      case Level.intermediate: return intermediate;
      case Level.advanced: return advanced;
      case Level.elite: return elite;
    }
  }

}

class StandardTable {

  final Iterable<int> bodyweight;

  final String id; //TODO: Exersise? or put in exersise
  final Iterable<int> beginner;
  final Iterable<int> novice;
  final Iterable<int> intermediate;
  final Iterable<int> advanced;
  final Iterable<int> elite;

  StandardTable(this.id, this.bodyweight, this.beginner, this.novice, this.intermediate, this.advanced, this.elite);

  Iterable<int>  level(Level level) {
    switch(level){
      case Level.beginner: return beginner;
      case Level.novice: return novice;
      case Level.intermediate: return intermediate;
      case Level.advanced: return advanced;
      case Level.elite: return elite;
    }
  }

}