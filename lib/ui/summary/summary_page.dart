import 'package:flutter/material.dart';
import 'package:test_flutter/domain/info/lift_info.dart';
import 'package:test_flutter/domain/workout.dart';
import 'package:test_flutter/ui/app_page.dart';
import 'package:test_flutter/ui/summary/summary.dart';
import 'package:test_flutter/ui/util.dart' as util;

AppPage getSummaryPage(List<LiftBasicInfo> lifts, List<Workout> workouts){
  return AppPage(title: _title, body: _SummaryState(lifts, workouts), navIcon: _icon);
}

NavigationDestination _icon = NavigationDestination(
            selectedIcon: Icon(Icons.home),
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

