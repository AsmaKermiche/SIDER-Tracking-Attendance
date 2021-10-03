import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import 'Presence_Screen.dart';

class IDDEP extends StatefulWidget {
  const IDDEP({Key? key}) : super(key: key);

  @override
  _IDDEPState createState() => _IDDEPState();
}

class _IDDEPState extends State<IDDEP> {
  TextEditingController phonenumber = TextEditingController();
  int iddep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          child:
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
              hintText: 'Numéro de département',
              prefixIcon: Icon(
                Icons.location_city,
                color: red,
              ),
            ),
          ),
        ),
        Container(
            width: 250,
            height: 50,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Colors.red)),
              color: Colors.red,
              textColor: Colors.white,
              child: Text("Tester",
                  style: TextStyle(fontSize: 20)),
              onPressed: () {
                iddep = int.parse(phonenumber.text);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PresenceScreen(iddep: iddep),),);
              },

            )),])
      ),
    );
  }
}
