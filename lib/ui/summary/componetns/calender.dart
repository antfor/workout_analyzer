import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '/domain/workout.dart';

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
}

List<Workout> events(DateTime date, List<Workout> workouts){

  final events = workouts.where((w)=> isSameDay(w.startTime, date));
  return events.toList();
}

Widget calender(List<Workout> workouts){
  //todo min size
  return TableCalendar<Workout>(
    firstDay: DateTime.utc(2000, 1, 1),
    lastDay: DateTime.now(),
    focusedDay: DateTime.now(),
    eventLoader: (d)=>events(d, workouts),

    //pageJumpingEnabled: true,
    startingDayOfWeek: StartingDayOfWeek.monday,
    weekNumbersVisible: true,
    availableCalendarFormats: {CalendarFormat.month: 'Month'},
    calendarStyle: CalendarStyle( 
      outsideDaysVisible: false,
      todayTextStyle: TextStyle(color: Colors.blue.shade400, fontWeight: FontWeight.bold),
      todayDecoration: const BoxDecoration(),
    ),

    calendarBuilders: CalendarBuilders(
       markerBuilder: (context, date, events) {

        if (events.isEmpty) return null;
        
        Color getColor(Workout w) => w.exercises.isNotEmpty? Colors.deepOrangeAccent.shade400 : Colors.blueAccent.shade400;

        return Transform.translate( offset: const Offset(0, -6),
          child: SizedBox(
          height: 6,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: events.take(4).map((event) {
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(event),
              ),
            );
          }).toList(),
          ))
        );
      },
      defaultBuilder: (context, day, focusedDay) {
        final events = workouts.where((w)=>isSameDay(w.startTime,day));

        Color color = Colors.orange.shade400;
     
        final textColor = Colors.black;

        if (events.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${day.day}',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          );
        }

        return null;
      },
    ),
  );
}