import 'package:cbhsapp/services/login.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _academicNumber = '';
  String _password = '';
  String _qrData = '준비 중';

  String get academicNumber => _academicNumber;
  String get password => _password;
  String get qrData => _qrData;

  void setUser(String academicNumber, String password) {
    _academicNumber = academicNumber;
    _password = password;
    notifyListeners();
  }

  void setQRdata(String qrData) {
    _qrData = qrData;
    notifyListeners();
  }

  Future<void> refreshQRdata() async {
    try {
      final qrData = await Login.postLogin(academicNumber, password);
      setQRdata(qrData);
    } catch (e) {
      print(e.toString());
    }
  }
}
