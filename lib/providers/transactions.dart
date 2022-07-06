import 'package:dio/dio.dart';
import 'package:ecomm/services/dio.dart';
import 'package:flutter/foundation.dart';

class TransactionState extends ChangeNotifier {
  bool loading = true;
  List orderan = [];

  void getTransactions({required String token}) async {
    Response res = await dio(token: token).get('/orderan');

    if (res.statusCode == 200) {
      orderan = res.data['orderan'];
      loading = false;
    }

    notifyListeners();
  }

  void cancelTransaction({required String token, required Map data}) async {
    Response res = await dio(token: token).put('/orderan/cancel', data: data);

    if (res.statusCode == 200) {
      orderan = res.data['orderan'];
      loading = false;
    }

    notifyListeners();
  }
}
