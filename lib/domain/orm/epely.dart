import 'dart:math';
import '../exercise.dart';

Iterable<double> allOrm(Iterable<Exercise> exercises){

    return exercises.map( (e) => epleyORM(e.weightKg, e.reps));
}

double ormList(Iterable<Exercise> exercises){

    return exercises.fold<double>(0, (orm, e) => max(orm, epleyORM(e.weightKg, e.reps)));
}

double ormExercise(Exercise exercises){

    return epleyORM(exercises.weightKg, exercises.reps);
}

double epleyORM(double w, int r) {
    if (r == 1){
        return w;
    }else if (r <= 0){
        return 0;
    }
        
    return w * (1 + r / 30.0);
}


int epleyMaxRep(double orm, double w) {

    final double reps = (orm / w - 1) * 30;
    if (reps <= 1){
        return 1;
    }

    const double eps = 0.0001;
    return (reps + eps).floor();
}