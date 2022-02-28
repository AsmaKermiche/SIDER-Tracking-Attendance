import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show asin, atan2, cos, sin, sqrt;
import 'package:intl/intl.dart';
import '../CalendarScreenProvider.dart';
import '../Departement.dart';
import '../HomeScreenProvider.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  final int? iddep;
  final String? matricule;

  const HomePage({Key? key, required this.matricule, required this.iddep})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  double earthRadius = 6371000;
  double depLat = 0;
  double depLong = 0;
  double myLat = 0;
  double myLong = 0;
  double distance = 0;
  String? qrData;
  bool status = false;
  bool show = false;
  String? date;
  String? time;

  Future _qrscanner() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      if (qrData != widget.iddep.toString()) qrData = (await scanner.scan());
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        qrData = (await scanner.scan());
      }
    }
  }

  void _show(String title) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext ctx) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AlertDialog(
              elevation: 10,
              title: Text(title),
              content: Text(show
                  ? 'Vous êtes deja présent'
                  : 'Vous êtes présent, bonne journée!'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ),
          );
        });
  }

  Future registerPresence() async {
    var url = "http://192.168.1.6/flutter_login_signup/pointage.php";
    var response = await http.post(Uri.parse(url), body: {
      "matricule": widget.matricule,
      "date": date,
      "time": time.toString(),
      "status": status.toString(),
    });
    print(response.body);
    var data = json.decode(response.body);
    if (data == "Error") {
      show = true;
    } else {
      print("it's okay");
    }
  }

  Future<void> _getCurrentPosition() async {
    final position = await _geolocatorPlatform.getCurrentPosition();
    myLat = position.latitude.toDouble();
    myLong = position.longitude.toDouble();
    fetchLatLong();
    double p = 0.017453292519943295;
    double a = 0.5 -
        cos((depLat - myLat) * p) / 2 +
        cos(myLat * p) *
            cos(depLat * p) *
            (1 - cos((depLong - myLong) * p)) /
            2;
    distance = 1000 * 12742 * asin(sqrt(a));
  }

  Future<void> fetchLatLong() async {
    var url = "http://192.168.1.6/flutter_login_signup/latlong.php";
    print(widget.iddep);
    var data = {'iddep': int.parse(widget.iddep.toString())};

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
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    time = DateFormat('kk:mm').format(now).toString();
    date = formatter.format(now);
    return ChangeNotifierProvider<HomeScreenProvider>(
        create: (context) => HomeScreenProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
            body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Hero(
                    tag: '1',
                    child: Text(
                      date!,
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Hero(
                    tag: '2',
                    child: Text(
                      time!,
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 300.0,
                    width: 280.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 1.0),
                            blurRadius: 2,
                            spreadRadius: 1.0)
                      ],
                    ),
                    child: Consumer<HomeScreenProvider>(
                        builder: (context, provider, child) {
                          return Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "Prenons votre présence",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black87),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          _getCurrentPosition();
                                          provider.checkPresence(distance);
                                        },
                                        color: (provider.isPresent == 0)
                                            ? Colors.grey
                                            : (provider.isPresent == 1)
                                            ? Colors.green
                                            : Colors.redAccent,
                                        textColor: Colors.white,
                                        child: Icon(
                                          (provider.isPresent == 0)
                                              ? Icons.location_pin
                                              : (provider.isPresent == 1)
                                              ? Icons.check
                                              : Icons.error_outline_sharp,
                                          size: 30,
                                        ),
                                        padding: EdgeInsets.all(16),
                                        shape: CircleBorder(),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          _qrscanner();
                                          if (qrData != null) {
                                            provider.checkQR(
                                                qrData!,
                                                widget.iddep.toString());
                                          }
                                        },
                                        color: (provider.testQR == 0)
                                            ? Colors.grey
                                            : (provider.testQR == 1)
                                            ? Colors.green
                                            : Colors.redAccent,
                                        textColor: Colors.white,
                                        child: Icon(
                                          (provider.testQR == 0)
                                              ? Icons.qr_code
                                              : (provider.testQR == 1)
                                              ? Icons.check
                                              : Icons.error_outline_sharp,
                                          size: 30,
                                        ),
                                        padding: EdgeInsets.all(16),
                                        shape: CircleBorder(),
                                      ),
                                    ]),
                                Text(provider.presenceMessage,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87)),

                                SizedBox(
                                  height: 30,
                                )
                                ,
                                Container(
                                    width: 250,
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12.0),
                                          side: BorderSide(color: red)),
                                      color: red,
                                      textColor: Colors.white,
                                      child: Text("Vérifier",
                                          style: TextStyle(fontSize: 20)),
                                      onPressed: () {
                                        provider.Display();
                                        if (provider.presenceMessage ==
                                            "") {
                                          status = true;
                                          registerPresence();
                                          _show(date!);
                                        }
                                      },
                                    )
                                ),
                              ]);
                        })),
                      Container(
                        child: Image.asset("assets/pin.png",width: 250,height: 280,
                        ),
                      ),
                    ],
                  ),
                )),
          );
        }));
  }
}
/*Container(
                           width: 250,
                           height: 50,


                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(color: red)),
                            color: red,
                            textColor: Colors.white,
                            child: Text("Considère-moi présent",
                                style: TextStyle(fontSize: 20)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarPage(matricule: widget.matricule,)),);
                            },
                          )
                           ),*/