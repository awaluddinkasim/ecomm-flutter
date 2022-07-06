import 'package:dio/dio.dart';
import 'package:ecomm/services/dio.dart';
import 'package:flutter/foundation.dart';

class Settings extends ChangeNotifier {
  int ongkir = 10000;

  String? bank;
  String? norek;
  String? pemilik;

  void getSettings(token) async {
    Response res = await dio(token: token).get('/settings');

    if (res.statusCode == 200) {
      ongkir = int.parse(res.data['ongkir']);

      bank = res.data['bank'];
      norek = res.data['norek'];
      pemilik = res.data['pemilik'];
    }

    notifyListeners();
  }
}
