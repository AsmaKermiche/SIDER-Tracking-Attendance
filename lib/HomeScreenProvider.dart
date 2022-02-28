import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier{
  String _presenceMessage = "";
  int _isPresent = 0;
  int _testQR = 0;

  void checkPresence(double distance){
    if(distance > 10.5)
      notPresent();
    else
      Present();
  }

  void Present(){
    _presenceMessage = "";
    _isPresent = 1;
    notifyListeners();
  }


  void notPresent(){
    _presenceMessage = "Vous n'êtes pas dans les alentours de votre département";
    _isPresent = 2;
    notifyListeners();
  }

  String get presenceMessage => _presenceMessage;
  int get isPresent => _isPresent;
  void checkQR(String value1, String value2 ){
    if(value1 == value2){
      Equal();
    }
    else{
      notEqual();
    }
  }

  void Display(){
    if ((testQR == 1) & (isPresent ==1)){
      _presenceMessage ="";
    }else{
      if(isPresent == 2){
        _presenceMessage = "Vous n'etes pas dans votre département";
      }else if (testQR == 2){
        _presenceMessage = "Scanner un code QR qui correspond à votre département";
      }
    }
    notifyListeners();
  }

  void Equal(){
    _testQR = 1;
    notifyListeners();
  }
  void notEqual(){
    _testQR = 2;
    notifyListeners();
  }

  int get testQR => _testQR;

}