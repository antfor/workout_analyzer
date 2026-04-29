import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:workout_analyzer/data/local/drift/seeding/static_data.dart';
import 'package:workout_analyzer/data/local/drift/seeding/user_data.dart';
import 'package:workout_analyzer/domain/domain.dart';
import 'package:workout_analyzer/repository/import/import.dart';
import 'package:workout_analyzer/repository/import/map.dart';
import 'package:workout_analyzer/repository/import/muscle.dart';
import 'package:workout_analyzer/repository/import/standards.dart';

part 'database.g.dart';

typedef DdError = (Object,StackTrace)?;

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  include: {'tables.drift', 'queries/test.drift'},
)
class AppDb extends _$AppDb {


  AppDb(): super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      try{
      // Seed default data //TODO do not neet to crate oject just create database directly
      //ALSO handle this if seeding fail, just empty?
        final muscles = await importMuscle();
        final mapNames = await importMap();
        final male = await importMale(mapNames);
        final female = await importFemale(mapNames);
        final Domain domain = await importMockData(muscles, male, female);

        final (exercisesInserts, muscleInserts, equipmentInserts, swInserts) = staticData(domain);

        final (workoutsInserts,liftInserts,cardioInserts) = userData(domain.workouts);
        print("seed");
        await batch((b) {

          //STAIC DATA
          b.insertAll(muscle, muscleInserts);
          b.insertAll(equipment, equipmentInserts);
          b.insertAll(standardsWeight, swInserts);
          b.insertAll(exercises, exercisesInserts);

          //USER DATA
          b.insertAll(workouts, workoutsInserts);
          b.insertAll(lift, liftInserts);
          b.insertAll(cardio, cardioInserts); 
        });
      }catch (e, st) {
        print("DB ERROR in seeding: $e");
        print(st);
      }

    },
  );

  Future<DdError> import(Domain domain) async {
    try{
      final (workoutsInserts,liftInserts,cardioInserts) = userData(domain.workouts);
      print("import");
      await batch((b) {
        // DELETE OLD USER DATA
        b.deleteAll(workouts);
        b.deleteAll(lift);
        b.deleteAll(cardio);

        // INSERT NEW USER DATA
        b.insertAll(workouts, workoutsInserts);
        b.insertAll(lift, liftInserts);
        b.insertAll(cardio, cardioInserts);
      });
    }catch (e, st) {
      print("DB ERROR in import: $e");
      print(st);
      return (e, st);
    }

    return null;
  }

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}

Future<void> resetDatabase() async {
  print("delete");
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'db.sqlite'));

  if (await file.exists()) {
    await file.delete();
  }
}
