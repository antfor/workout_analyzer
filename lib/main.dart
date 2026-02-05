import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/navigation.dart';
import 'package:test_flutter/repository/import/map.dart';
import 'package:test_flutter/repository/import/muscle.dart';
import 'package:test_flutter/repository/import/standards.dart';
import 'package:test_flutter/state/domain.dart';
import 'package:test_flutter/state/settings.dart';
import 'package:test_flutter/ui/exercises/exersise_page.dart';
import 'package:test_flutter/ui/summary/summary_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final muscles = await importMuscle();
  final mapNames = await importMap();
  final male = await importMale(mapNames);
  final female = await importFemale(mapNames);
  

  runApp(ProviderScope(child:WorkoutAnalyzer(muscles, male, female))); 
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
      loading: () => materialAppWithTheme(home: Scaffold(body: Center(child: CircularProgressIndicator()))),
      error: (e, st) => materialAppWithTheme(home: Scaffold(body: Center(child: Text('Error: $e')))), //TODO option to import data or choose mock data
      data: (domain) {

        final basic = domain.getBasicInfo.toList();
        basic.sort();

        final workouts = domain.workouts;

        final pages = [getSummaryPage(basic,workouts),getExersisePage(basic)];

        return materialAppWithTheme(home: Navigation(pages));
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