
import 'dart:async';

import 'package:bloc_demo/src/utils/validations.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();

  BehaviorSubject _userSubject = BehaviorSubject();

  Stream get userStream => _userSubject.stream;
  Stream get passStream => _passController.stream;

  bool isValidInfo(String username, String password) {
    if (!Validations.isValidUser(username)){
      _userSubject.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _userSubject.sink.add("OK");
    if (!Validations.isValidPass(password)){
      _passController.sink.addError("Mật khẩu không hợp lệ");
      return false;
    }
    _passController.sink.add("OK");

    return true;
  }

  void dispose() {
    _userController.close();
    _passController.close();
    _userSubject.close();
  }

}