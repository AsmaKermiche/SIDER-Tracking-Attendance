import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show sin, cos, sqrt, atan2;
import 'package:vector_math/vector_math.dart';

import '../departement.dart';
class HomePage extends StatefulWidget {
  final int? id;
  const HomePage({Key? key,required this.id}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  double earthRadius = 6371000;
  double depLat = 0;   double depLong = 0;
  double myLat = 0; double myLong = 0;
   Future<void> _getCurrentPosition() async {
    final position = await _geolocatorPlatform.getCurrentPosition();
    myLat = position.latitude.toDouble();
    myLong = position.longitude.toDouble();
    fetchLatLong();
    var dLat = radians(depLat - myLat);
    var dLng = radians(depLong - myLong);
    var a = sin(dLat/2) * sin(dLat/2) + cos(radians(position.latitude))
        * cos(radians(depLat)) * sin(dLng/2) * sin(dLng/2);
    var c = 2 * atan2(sqrt(a), sqrt(1-a));
    var d = earthRadius * c;
    print(widget.id);
    print(position);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:
        Text('La distance: ${d} metres'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            }, child: Text('Ok'),
          )
        ],
      ),
    );
  }
  Future<void> fetchLatLong() async {
    var url ="http://192.168.1.10/flutter_login_signup/latlong.php";

    var data = {'iddep': int.parse(widget.id.toString())};

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {

      print(response.statusCode);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Departement> dep = items.map<Departement>((json) {
        return Departement.fromJson(json);
      }).toList();

      depLat = dep.first.latitude;
      depLong = dep.first.longitude;
      print(depLat);
      print(depLong);
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: RaisedButton(
            child: Text("asma"),
            onPressed: _getCurrentPosition,
          ),
        ),
    );
  }
}
