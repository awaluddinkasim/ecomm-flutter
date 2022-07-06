import 'package:dio/dio.dart';
import 'package:ecomm/models/user.dart';
import 'package:ecomm/services/dio.dart';
import 'package:flutter/foundation.dart';

class Auth extends ChangeNotifier {
  String? token;
  User? user;

  bool loading = false;
  bool passwordVisible = false;

  String? err;

  void togglePassword() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void login({required Map creds}) async {
    loading = true;
    try {
      err = null;
      Response res = await dio().post('auth', data: creds);

      if (res.statusCode == 200) {
        token = res.data['token'];
        user = User.fromJson(res.data['user']);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        err = e.response!.data['message'];
      }
      loading = false;
    }
    notifyListeners();
  }

  void logout() async {
    loading = true;
    try {
      Response res = await dio(token: token).get('/logout');

      if (res.statusCode == 200) {
        user = null;
        token = null;
        loading = false;
      }
    } catch (e) {
      loading = false;
    }
    notifyListeners();
  }

  void updateUser({required Map data}) async {
    loading = true;

    try {
      Response res = await dio(token: token).post('/update-profile', data: data);

      if (res.statusCode == 200) {
        user = User.fromJson(res.data['user']);
        loading = false;
      }
    } catch (e) {
      loading = false;
    }

    notifyListeners();
  }
}
