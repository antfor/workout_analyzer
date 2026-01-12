import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/ui/app_page.dart';
import 'package:test_flutter/ui/exercises/exercises.dart';
import 'package:test_flutter/ui/exercises/list.dart';
import 'package:test_flutter/ui/util.dart' as util;

AppPage getExersisePage(List<LiftBasicInfo> lifts){
  return AppPage(title: _title, body: _ExerciseState(lifts), navIcon: _icon);
}

NavigationDestination _icon = NavigationDestination(
            selectedIcon: Icon(Icons.fitness_center),
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Exercises',
          );

Widget _title = Text('Exercises');

class _ExerciseState extends StatefulWidget{
 final List<LiftBasicInfo> lifts;

  const _ExerciseState(this.lifts);

  @override
  State<_ExerciseState> createState() => _ExercisePage();
}


class _ExercisePage extends State<_ExerciseState>  {

  LiftBasicInfo? selectedLift;

  @override
  Widget build(BuildContext context) {

    final listPage = ExerciseList(widget.lifts, selectedLift, (lift) => setState(() => selectedLift = lift));

    final loading = Text('');
    final infoPage = selectedLift == null ? loading : ExerciseInfo(selectedLift!.getInfo());

    return  LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > util.desktop) {
          return Row(
            children: [
              Flexible(flex: 1, child:listPage),
              Flexible(flex: 2, child:infoPage)
            ],);
        } else if (constraints.maxWidth > util.tablet) {
          return Row(
            children: [
              Flexible(flex: 1, child:listPage),
              Flexible(flex: 1, child:infoPage)
            ],);
        }

        if(selectedLift != null){
          return infoPage;//TODO: mark info page as subpage (make so yuo can turn back on subpage)
        }else{
          return listPage;
        }
        
      });
  }

}

