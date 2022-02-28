import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:provider/provider.dart';

import '../CalendarScreenProvider.dart';
import '../name.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key, required this.matricule}) : super(key: key);
  final String? matricule;

  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

List<DateTime> absentDates = [];
String? matricule;
String? name;

Future<void> fetchName() async {
  var url = "http://192.168.1.6/flutter_login_signup/name.php";

  var data = {'matricule': matricule};

  var response = await http.post(Uri.parse(url), body: json.encode(data));

  if (response.statusCode == 200) {
    print(response.statusCode);

    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    List<Name> names = items.map<Name>((json) {
      return Name.fromJson(json);
    }).toList();
    print(names.first.name);
    name = names.first.name;
  } else {
    throw Exception('Failed to load data from Server.');
  }
}

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
    fetchName();
    matricule = widget.matricule;
    cHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<CalendarScreenProvider>(
        create: (context) => CalendarScreenProvider(),
        child: Consumer<CalendarScreenProvider>(
            builder: (context, provider, child) {
          provider.fetchDates(widget.matricule!);
          var len = provider.presentDates.length;
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

          _calendarCarouselNoHeader = CalendarCarousel<Event>(
            height: cHeight * 0.54,
            weekendTextStyle: TextStyle(
              color: Colors.red,
            ),
            todayButtonColor: Colors.blue,
            markedDatesMap: _markedDateMap,
            markedDateShowIcon: true,
            markedDateIconMaxShown: 1,
            markedDateMoreShowTotal: null,
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bonjour, ",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Asma Kermiche",
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _calendarCarouselNoHeader,
                  markerRepresent(Colors.green, "Present"),
                ],
              ),
            ),
          );
        }));
  }
}
