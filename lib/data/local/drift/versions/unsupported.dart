
import 'package:drift/native.dart';
import 'package:workout_analyzer/data/local/drift/database.dart';

SharedDatabase constructDb() {
  return SharedDatabase(NativeDatabase.memory());
}

//import 'package:workout_analyzer/data/local/drift/database.dart';
//SharedDatabase constructDb() => throw UnimplementedError();
