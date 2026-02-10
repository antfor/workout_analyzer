import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/workout.dart';
import 'package:test_flutter/ui/app_page.dart';
import 'package:test_flutter/ui/history/history.dart';
import 'package:test_flutter/ui/util.dart' as util;

AppPage getHistoryPage(List<Workout> workouts, BuildContext context, {LiftBasicInfo? lift}){
  return AppPage(title: _title, body: _HistoryState(lift, workouts), navIcon: _icon(context));
}

NavigationDestination _icon(BuildContext context) => NavigationDestination(
            selectedIcon: Icon(Icons.history, color: Theme.of(context).colorScheme.primary,),
            icon: Icon(Icons.history_outlined),
            label: 'History',
          );

Widget _title = Text('History');

class _HistoryState extends StatefulWidget{
 final LiftBasicInfo? lift;
 final List<Workout> workouts;

  const _HistoryState(this.lift, this.workouts);

  @override
  State<_HistoryState> createState() => _HistoryPage();
}


class _HistoryPage extends State<_HistoryState>  {

  @override
  Widget build(BuildContext context) {

    return  LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > util.desktop){}
        
        return History(widget.lift, widget.workouts);
      });
  }

}