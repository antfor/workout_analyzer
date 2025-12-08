import '../Orm/epely.dart';
import 'dart:math' as math;


//todo use factory...
//todo make lazy
class OrmData {

  int incrementIndex;
  static const List<double> increments = [0,1,1.25,2.5,5];

  final double orm;
  late Iterable<double> percentages;
  late List<double> weightsKg;
  late List<int> reps;

  OrmData(this.orm, {this.incrementIndex=4}){
    weightsKg = _getWeight();
    percentages = weightsKg.map((w) => w/orm);
    reps = _getReps();
  }

  
  double get increment {
    int safeIndex = (incrementIndex % increments.length + increments.length) % increments.length;
    return increments[safeIndex];
  }

  List<int> _getReps(){
    return weightsKg.map((w) => epleyMaxRep(orm, w)).toList();
  }

  List<double> _getWeight(){

    final inc = increment;
    const double  minPercentage = 0.5;

     if (inc <= 0) { //just give standard percentages in this case
        const maxPercentage = 0.95;
        const gap = 0.05;
        const len = 1 + (maxPercentage * 100 - minPercentage * 100) / (gap * 100);
        return List<double>.generate(math.max(len.floor(),0), (i) => (maxPercentage - gap * i) * orm);
    }

    final int max = (orm / inc).floor();
    if (max < 1) {
        return [];
    }
    final int min = (minPercentage * orm / inc).round();
    final len = math.max(max - min + 1,0);
    return List<double>.generate(len, (i) => inc * (max - i));

  }

}

class NewOrmData extends OrmData{

  late Iterable<double> dif;
  late Iterable<double> newOrm;
  //static const int _maxReps = 20;

  NewOrmData(super.orm, {super.incrementIndex}){
    
    final len = math.min(reps.length, weightsKg.length);

    newOrm = List.generate(len, (i)=> epleyORM(weightsKg[i], reps[i]));
    dif = newOrm.map((v)=>v-orm);
    //todo filter reps bigger then 20
    
  }

  @override
  List<int> _getReps(){
    return weightsKg.map((w) => epleyMaxRep(orm, w) + 1).toList();
  }

}
