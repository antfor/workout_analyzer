import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/ui/app_page.dart';
import 'package:test_flutter/ui/exercises/list.dart';

AppPage getExersisePage(List<LiftBasicInfo> lifts){
  return AppPage(title: _title, body: _ExercisePage(lifts), navIcon: _icon);
}

NavigationDestination _icon = NavigationDestination(
            selectedIcon: Icon(Icons.fitness_center_outlined),
            icon: Icon(Icons.fitness_center),
            label: 'Exercises',
          );

Widget _title = Text('Exercises');

class _ExercisePage extends StatelessWidget {

  final List<LiftBasicInfo> lifts;

  const _ExercisePage(this.lifts);

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(child:ExerciseList(lifts)),
              Expanded(child:ExerciseList(lifts))
            ],);
        }

        return ExerciseList(lifts);
        
      });
  }

}

