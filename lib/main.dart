import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_analyzer/navigation.dart';
import 'package:workout_analyzer/repository/repo.dart';
import 'package:workout_analyzer/state/domain.dart';
import '/ui/exercises/exersise_page.dart';
import '/ui/history/history_page.dart';
import '/ui/summary/summary_page.dart';
import '/data/local/drift/database.dart' as db;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 2. Call your query
  //final muscles = await database.get_muscles().get();

  //await db.resetDatabase();//TODO remove
  final localDB = db.AppDb();
 
  Repo.initRepo(localDB);

  runApp(ProviderScope(child:materialAppWithTheme(home: WorkoutAnalyzer()))); 
}

class WorkoutAnalyzer extends ConsumerWidget{
  
  const WorkoutAnalyzer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final asyncDomain = ref.watch(domainProvider);//TODO Did not rebuild when new import
    
    return asyncDomain.when(
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))), //TODO option to import data or choose mock data
      data: (domain) {
        
        if(domain == null){
          return Scaffold(body: Center(child: Text('Error: No domain')));
        }

        final basic = domain.getBasicInfo.toList();
        final cardioInfo = domain.getCardioInfo.toList();
        basic.sort();

        final workouts = domain.workouts;

        final pages = [getSummaryPage(basic,workouts,context), getHistoryPage(workouts, context), getExersisePage(basic, cardioInfo, context)];

        return Navigation(pages);
    });
  }
}

Widget materialAppWithTheme({required Widget home}){

  return MaterialApp(
      title:'Workout Analyzer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.orange, brightness: Brightness.dark),
      ),
      home: home,
      );
}