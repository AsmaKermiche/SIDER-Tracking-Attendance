import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage/Component/button.dart';
import 'package:stage/Employee.dart';
import 'package:stage/Screens/Presence_Screen.dart';
import 'package:stage/Screens/wrapper.dart';
import '../constants.dart';
import 'Home_Screen.dart';
import 'Register_Screen.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;
  int iddep = 0;
  String matricule = "";
  Future login() async {
    var url = "http://192.168.1.6/flutter_login_signup/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "phonenumber": phonenumber.text,
      "password": password.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar(matricule: matricule,iddep: iddep),),);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(' Ops! Registration Failed'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'),
            )
          ],
        ),
      );
    }
  }

  Future<void> fetchIDIDDEP() async {
    var url = "http://192.168.1.6/flutter_login_signup/iddep.php";

    var data = {'phonenumber': phonenumber.text};

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.statusCode);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Employee> emp = items.map<Employee>((json) {
        return Employee.fromJson(json);
      }).toList();
      matricule = emp.first.matricule;
      iddep = emp.first.iddep;
      print(iddep);
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(
                  children: [
                    Container(
                      height:MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              width: 120,
                              height: 170,
                              child: Image.asset("assets/logo.jpg"),
                            ),
                            SizedBox(height: 30),

                            Text(
                              "Se connecter à votre compte",
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 50),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: phonenumber,
                              validator: (value) => (value!.isEmpty)
                                  ? ' SVP entrez votre numéro de téléphone!'
                                  : null,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Numéro de téléphone',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: red,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "SVP entrez un mot de passe!";
                                }
                              },
                              controller: password,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Mot de passe',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: red,
                                  )),
                            ),
                            SizedBox(height: 150),
                            Container(
                                width: 250,
                                height: 50,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(color: Colors.red)),
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text("Se connecter",
                                      style: TextStyle(fontSize: 20)),
                                  onPressed: () {
                                    fetchIDIDDEP();
                                    login();
                                  },

                                ))

                          ],
                        ),
                      ),
                    ),],
                    ),
                ),
              ),

    );
  }
}
