import 'package:flutter/material.dart';
import '/domain/workout.dart';
import '/ui/app_page.dart';
import '/ui/history/history.dart';
import '/ui/history/history_info.dart';
import '/ui/util.dart' as util;

AppPage getHistoryPage(List<Workout> workouts, BuildContext context){
  return AppPage(title: _title, body: _HistoryState(workouts), navIcon: _icon(context));
}

NavigationDestination _icon(BuildContext context) => NavigationDestination(
            selectedIcon: Icon(Icons.history, color: Theme.of(context).colorScheme.primary,),
            icon: Icon(Icons.history_outlined),
            label: 'History',
          );

Widget _title = Text('History');

class _HistoryState extends StatefulWidget{

 final List<Workout> workouts;

  const _HistoryState(this.workouts);

  @override
  State<_HistoryState> createState() => _HistoryPage();
}


class _HistoryPage extends State<_HistoryState>  {

  Workout? selectedWorkout;

  @override
  Widget build(BuildContext context) {

    final listPage = History(widget.workouts, selectedWorkout,(workout) => setState(() => selectedWorkout = workout));

    final loading = Text('');
    void exit() => setState(() => selectedWorkout = null);
    final infoPage = selectedWorkout == null ? loading : HistoryInfo(selectedWorkout!, exit);

    return  LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > util.desktop){
          return Row(
            children: [
              Align( child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600,), 
                child: listPage)),
              Expanded(child:infoPage)
            ],);
        }else if (constraints.maxWidth > util.tablet){
          
        }

        if(selectedWorkout != null){
          return infoPage;//TODO: mark info page as subpage (make so yuo can turn back on subpage)
        }else{
          return listPage;
        }
      });
  }

}