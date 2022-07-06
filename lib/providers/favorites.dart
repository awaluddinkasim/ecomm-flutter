import 'package:dio/dio.dart';
import 'package:ecomm/services/dio.dart';
import 'package:flutter/foundation.dart';

class FavoriteState extends ChangeNotifier {
  bool loading = true;

  List favorites = [];

  void getFavorites({required String token}) async {
    Response res = await dio(token: token).get('/favorites');

    if (res.statusCode == 200) {
      favorites = res.data['favorites'];
      loading = false;
    }

    notifyListeners();
  }

  void favoriteAction({required String token, required Map data}) async {
    Response res = await dio(token: token).post('/favorite', data: data);

    if (res.statusCode == 200) {
      favorites = res.data['favorites'];
      loading = false;
    }

    notifyListeners();
  }
}
