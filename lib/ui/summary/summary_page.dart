import 'package:flutter/material.dart';
import '/domain/info/lift_info.dart';
import '/domain/workout.dart';
import '/ui/app_page.dart';
import '/ui/summary/summary.dart';
import '/ui/util.dart' as util;

AppPage getSummaryPage(List<LiftBasicInfo> lifts, List<Workout> workouts, BuildContext context){
  return AppPage(title: _title, body: _SummaryState(lifts, workouts), navIcon: _icon(context));
}

NavigationDestination _icon(BuildContext context) => NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Theme.of(context).colorScheme.primary,),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          );

Widget _title = Text('Home');

class _SummaryState extends StatefulWidget{
 final List<LiftBasicInfo> lifts;
 final List<Workout> workouts;

  const _SummaryState(this.lifts, this.workouts);

  @override
  State<_SummaryState> createState() => _SummaryPage();
}


class _SummaryPage extends State<_SummaryState>  {

  @override
  Widget build(BuildContext context) {

    return  LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > util.desktop){}
        
        return Summary(widget.lifts, widget.workouts);
      });
  }

}

