import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:provider/provider.dart';

import '../CalendarScreenProvider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key,required this.matricule}) : super(key: key);
  final String? matricule;
  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

List<DateTime> absentDates = [
  DateTime(2021, 10, 2),
  DateTime(2021, 11, 7),
  DateTime(2020, 11, 8),
  DateTime(2020, 11, 12),
  DateTime(2020, 11, 13),
  DateTime(2020, 11, 14),
  DateTime(2020, 11, 16),
  DateTime(2020, 11, 17),
  DateTime(2020, 11, 18),
  DateTime(2020, 11, 19),
  DateTime(2020, 11, 20),
];

class _CalendarPageState extends State<CalendarPage> {


  static Widget _presentIcon(String day) => CircleAvatar(
    backgroundColor: Colors.green,
    child: Text(
      day,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );


  static Widget _absentIcon(String day) => CircleAvatar(
    backgroundColor: Colors.red,
    child: Text(
      day,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  late CalendarCarousel _calendarCarouselNoHeader;
  late double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<CalendarScreenProvider>(
        create: (context) => CalendarScreenProvider(),
        child: Consumer<CalendarScreenProvider>(
        builder: (context, provider, child) {
         provider.fetchDates(widget.matricule!);
          var len = min(absentDates.length, provider.presentDates.length);
          for (int i = 0; i < len; i++) {
            _markedDateMap.add(
              provider.presentDates[i],
              new Event(
                date: provider.presentDates[i],
                title: 'Event 5',
                icon: _presentIcon(
                  provider.presentDates[i].day.toString(),
                ),
              ),
            );
          }

          for (int i = 0; i < len; i++) {
            _markedDateMap.add(
              absentDates[i],
              new Event(
                date: absentDates[i],
                title: 'Event 5',
                icon: _absentIcon(
                  absentDates[i].day.toString(),
                ),
              ),
            );
          }

          _calendarCarouselNoHeader = CalendarCarousel<Event>(
            height: cHeight * 0.54,
            weekendTextStyle: TextStyle(
              color: Colors.red,
            ),
            todayButtonColor: Colors.blue,
            markedDatesMap: _markedDateMap,
            markedDateShowIcon: true,
            markedDateIconMaxShown: 1,
            markedDateMoreShowTotal:
            null,
            // null for not showing hidden events indicator
            markedDateIconBuilder: (event) {
              return event.icon;
            },
          );
          Widget markerRepresent(Color color, String data) {
            return new ListTile(
              leading: new CircleAvatar(
                backgroundColor: color,
                radius: cHeight * 0.022,
              ),
              title: new Text(
                data,
              ),
            );
          }



          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Calender"),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _calendarCarouselNoHeader,
                  markerRepresent(Colors.red, "Absent"),
                  markerRepresent(Colors.green, "Present"),
                ],
              ),
            ),
          );
        }));
  }
}