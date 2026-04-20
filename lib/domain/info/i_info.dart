
import 'package:workout_analyzer/domain/standards/muscle_group.dart';

abstract class IExerciseUpdate {
  void update(double weight, int reps);
}

abstract class IUpdate<T> {
  void update(T e);
}

abstract class IDoneUpdate<T> {
  void update(T e);
  void done(String id);
}

abstract class IInfo implements Comparable<IInfo>{
  String get id;
  Muscle get muscle;
  //final Widget logo //TODO

  @override
  int compareTo(IInfo other) => id.compareTo(other.id);

}