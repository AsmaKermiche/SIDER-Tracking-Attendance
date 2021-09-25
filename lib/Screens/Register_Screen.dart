import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stage/Component/button.dart';
import 'package:http/http.dart' as http;
import 'package:stage/Screens/Home_Screen.dart';

import '../constants.dart';
import 'Login_Screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController matricule = TextEditingController();

  String? _chosenValue;
  int? _depId;
  bool isloading = false;
  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
           context, MaterialPageRoute(builder: (context) => LoginScreen())
           );

      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vous avez deja un compte?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: red,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }


  Future register() async {
    var url = "http://192.168.1.10/flutter_login_signup/register.php";
    var response = await http.post(Uri.parse(url), body: {
      "name": name.text,
      "phonenumber": phonenumber.text,
      "password": password.text,
      "matricule": matricule.text,
      "iddep": _depId.toString(),
    });
    var data = json.decode(response.body);
    if (data == "Error") {
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
    } else {
      print("hiii");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              id: _depId,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),*/
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
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              width: 100,
                              height: 150,
                              child: Image.asset("assets/logo.jpg"),
                            ),
                            Hero(
                              tag: '1',
                              child: Text(
                                "Salut!\nCréer un compte pour commencer",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: name,
                              validator: (value) => (value!.isEmpty)
                                  ? ' SVP entrez votre numéro de téléphone!'
                                  : null,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Entrez votre nom',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: red,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
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
                                hintText: 'Entrez votre numéro de téléphone',
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: red,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "SVP entrez un mot de passe!";
                                }
                              },
                              controller: password,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Entrez un mot de passe',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: red,
                                  )),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "SVP entrez votre matricule";
                                }
                              },
                              controller: matricule,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Entrez votre matricule',
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: red,
                                  )),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: 350,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              padding: const EdgeInsets.all(5.0),
                              child: DropdownButton<String>(
                                value: _chosenValue,
                                //elevation: 5,
                                style: TextStyle(color: Colors.black),

                                items: <String>[
                                  'Département RH et IT',
                                  'Département Qualité',
                                  'Administration',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      child: Icon(Icons.location_city,
                                        color: red,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text(
                                        'Choisir votre département SVP!',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _chosenValue = value;
                                    if (_chosenValue ==
                                        "Département RH et IT") {
                                      _depId = 1;
                                    } else if (_chosenValue ==
                                        "Département Qualité") {
                                      _depId = 2;
                                    } else if (_chosenValue ==
                                        "Administration") {
                                      _depId = 3;
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 48),
                            Container(
                              width: 250,
                                height: 50,
                                child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text("Créer un compte",
                                  style: TextStyle(fontSize: 20)),
                              onPressed: register,
                            )),
                            _loginAccountLabel(),
                          ],
                        ),),

                    )
                  ],
                ),
              ),
            ),
    );
  }
}
