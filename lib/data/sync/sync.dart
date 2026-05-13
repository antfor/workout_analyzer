import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_analyzer/data/local/drift/database.dart' as db;
import 'package:workout_analyzer/data/remote/remote.dart';
import 'package:workout_analyzer/domain/domain.dart';

typedef Error = String?;

class Sync {

  static final storage = "last_sync_at";
  final db.SharedDatabase local;
  final Remote remote;
  DateTime? _lastSync;
  final Future<SharedPreferencesWithCache> _prefsWithCache = SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(
      allowList: <String>{storage},
    ),
  );

  Sync(this.local, this.remote,);


  Future<Error> import(Domain domain) async {

    final result =  await remote.import(domain.workouts);

    final timestamp = result.result;
    if(timestamp != null){
      setLastSync(timestamp);//TODO latest of timestamp and _lastSync;
      return null;
    } else if(result.error != null){
      return result.error;
    }

    return "Remote Error: No result or error";
  }


  Future<DateTime> getLastSync() async {

    final defaultDate = DateTime.fromMillisecondsSinceEpoch(0);

    try {

      SharedPreferencesWithCache prefsWithCache= await _prefsWithCache;
      final iso8601String = prefsWithCache.getString(storage) ?? defaultDate.toUtc().toIso8601String();
      return  DateTime.parse(iso8601String);
    } catch (e) {
      debugPrint('Error getting last_sync_at value: $e');
      return defaultDate;
    }
  }


  Future<Error> setLastSync(String timeStamp) async {
    try {
      SharedPreferencesWithCache prefsWithCache= await _prefsWithCache;

      await prefsWithCache.setString(storage, timeStamp);
      return null;
    } catch (e) {
      debugPrint('Error setting bool value: $e');
      return 'Error setting last_sync_at value: $e';
    }
  }
}