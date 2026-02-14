import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/standards/muscle_group.dart';
import '/domain/standards/standards.dart';
import '/navigation.dart';
import '/repository/import/map.dart';
import '/repository/import/muscle.dart';
import '/repository/import/standards.dart';
import '/state/domain.dart';
import '/state/settings.dart';
import '/ui/exercises/exersise_page.dart';
import '/ui/history/history_page.dart';
import '/ui/summary/summary_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final muscles = await importMuscle();
  final mapNames = await importMap();
  final male = await importMale(mapNames);
  final female = await importFemale(mapNames);
  

  runApp(ProviderScope(child:materialAppWithTheme(home: WorkoutAnalyzer(muscles, male, female)))); 
}

class WorkoutAnalyzer extends ConsumerWidget{

  final Standards male;
  final Standards female;
  final Map<String, Muscle> muscles;

  
  const WorkoutAnalyzer(this.muscles, this.male, this.female,{super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final filePath = ref.watch(settingsProvider.select((s) => s.filePath));
    final asyncDomain = ref.watch(domainProvider(DomainArgs(muscles, male, female, filePath)));
    
    return asyncDomain.when(
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))), //TODO option to import data or choose mock data
      data: (domain) {

        final basic = domain.getBasicInfo.toList();
        basic.sort();

        final workouts = domain.workouts;

        final pages = [getSummaryPage(basic,workouts,context), getHistoryPage(workouts, context),getExersisePage(basic,context)];

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