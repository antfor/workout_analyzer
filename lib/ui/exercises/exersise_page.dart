import 'package:flutter/material.dart';
import 'package:workout_analyzer/domain/info/cardio/cardio_info.dart';
import 'package:workout_analyzer/ui/exercises/cardio_info.dart';
import 'package:workout_analyzer/ui/exercises/components/selected.dart';
import '/domain/info/lift_info.dart';
import '/ui/app_page.dart';
import '/ui/exercises/exercises_info.dart';
import '/ui/exercises/list.dart';
import '/ui/util.dart' as util;

AppPage getExersisePage(List<LiftBasicInfo> lifts, List<CardioBasicInfo> cardio, BuildContext context){
  return AppPage(title: _title, body: _ExerciseState(lifts, cardio), navIcon: _icon(context));
}

NavigationDestination _icon(BuildContext context) => NavigationDestination(
            selectedIcon: Icon(Icons.fitness_center, color: Theme.of(context).colorScheme.primary,),
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Exercises',
          );

Widget _title = Text('Exercises');

class _ExerciseState extends StatefulWidget{
 final List<LiftBasicInfo> lifts;
 final List<CardioBasicInfo> cardio;

  const _ExerciseState(this.lifts, this.cardio);

  @override
  State<_ExerciseState> createState() => _ExercisePage();
}



class _ExercisePage extends State<_ExerciseState>  {

  Selected selected = Selected();

  @override
  Widget build(BuildContext context) {

    final listPage = ExerciseList(widget.lifts, widget.cardio, selected, (lift, cardio) => setState(() => selected.select(lift, cardio)));

    final loading = Text('');

    void exit() => setState(() => selected.exit());
    Widget infoPage = selected.lift == null ? loading : ExerciseInfo(selected.lift!.getInfo(), exit);
    infoPage = selected.cardio == null ? infoPage : InfoCardio(selected.cardio!.getInfo(), exit);

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

        if(selected.hasSelected()){
          return infoPage;//TODO: mark info page as subpage (make so yuo can turn back on subpage)
        }else{
          return listPage;
        }
        
      });
  }

}

