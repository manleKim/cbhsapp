import 'package:cbhsapp/models/reassess_element_model.dart';
import 'package:cbhsapp/services/dormitory_service.dart';
import 'package:cbhsapp/services/login.dart';
import 'package:flutter/material.dart';

class UserManageProvider extends ChangeNotifier {
  String _academicNumber = '';
  String _password = '';
  String _studentNumber = '';
  String _studentName = '';
  String _session = '';
  List<ReassessElementModel> _reassessList = [];

  String get academicNumber => _academicNumber;
  String get password => _password;
  String get studentName => _studentName;
  String get studentNumber => _studentNumber;
  String get session => _session;
  List<ReassessElementModel> get reassessList => _reassessList;

  void setUser(String academicNumber, String password) {
    _academicNumber = formatAcademicNumber(academicNumber);
    _password = formatPassword(password);
    notifyListeners();
  }

  void setSession(String session) {
    _session = session;
    notifyListeners();
  }

  Future<void> getStudentNumber() async {
    try {
      final info = await Login.postServiceLogin(_academicNumber, _password);
      _studentName = info['studentName'];
      _studentNumber = info['studentNumber'];
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> refreshSession() async {
    try {
      final session =
          await DormitoryService.getSession(_academicNumber, _password);
      setSession(session);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> refreshReassessList() async {
    try {
      _reassessList = await DormitoryService.getTotalReassess(
          _academicNumber, _password, _session);
    } catch (e) {
      print(e.toString());
    }
  }
}

String formatAcademicNumber(String academicNumber) {
  // 123456 -> 12-3456
  return '${academicNumber.substring(0, 2)}-${academicNumber.substring(2)}';
}

String formatPassword(String password) {
  //000101 -> 20000101, 980101 -> 19980101
  String prefix = password.substring(0, 2);
  String modifyPassword =
      (int.parse(prefix) > 20) ? '19$password' : '20$password';
  return modifyPassword;
}
