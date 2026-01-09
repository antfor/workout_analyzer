import 'package:flutter/material.dart';
import 'package:test_flutter/domain/domain.dart';
import 'package:test_flutter/navigation.dart';
import 'package:test_flutter/repository/import/map.dart';
import 'package:test_flutter/repository/import/muscle.dart';
import 'package:test_flutter/repository/import/standards.dart';
import 'package:test_flutter/ui/exercises/exersise_page.dart';
import 'package:test_flutter/ui/summary/summary_page.dart';
import 'repository/import.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final muscles = await importMuscle();
  final mapNames = await importMap();
  final male = await importMale(mapNames);
  final female = await importFemale(mapNames);
  final domain = await importMockData(muscles,male,female);

  runApp(WorkoutAnalyzer(domain)); 
}

class WorkoutAnalyzer extends StatelessWidget{

  final Domain domain;
  
  const WorkoutAnalyzer(this.domain,{super.key});

  @override
  Widget build(BuildContext context) {
    
    final basic = domain.getBasicInfo.toList();
    basic.sort();

    final pages = [getSummaryPage(basic),getExersisePage(basic)];

    return MaterialApp(
      title:'Exerise analyzer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
      ),
      home: Navigation(pages)
        
      );
  }
}