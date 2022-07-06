import 'package:dio/dio.dart';
import 'package:ecomm/services/dio.dart';
import 'package:flutter/foundation.dart';

class CartState extends ChangeNotifier {
  int count = 0;
  List items = [];
  num total = 0;
  bool loading = true;

  void resetCart() {
    count = 0;
    items = [];
    total = 0;
    loading = true;

    notifyListeners();
  }

  void addToCart({required Map data, required String token}) async {
    loading = true;
    Response res = await dio(token: token).post('cart', data: data);

    if (res.statusCode == 200) {
      count = res.data['count'];

      notifyListeners();
    }
  }

  void countCart(token) async {
    Response res = await dio(token: token).get('count-cart');

    if (res.statusCode == 200) {
      count = res.data['count'];
    }
    notifyListeners();
  }

  void fetchItem(token) async {
    Response res = await dio(token: token).get('cart');

    if (res.statusCode == 200) {
      items = res.data['items'];
      loading = false;
    }
    totalCount();
    notifyListeners();
  }

  totalCount() {
    total = 0;
    items.forEach((element) async {
      total = total + int.parse(element['product']['harga']) * int.parse(element['qty']);
    });
  }

  void increase({required String token, required int id}) async {
    print("Increase qty $id");
    Response res = await dio(token: token).post('cart/increase', data: {"id": id});
    if (res.statusCode == 200) {
      items = res.data['items'];
    }
    totalCount();
    notifyListeners();
  }

  void decrease({required String token, required int id}) async {
    print("Decrease qty $id");
    Response res = await dio(token: token).post('cart/decrease', data: {"id": id});
    if (res.statusCode == 200) {
      items = res.data['items'];
      count = res.data['count'];
    }
    totalCount();
    notifyListeners();
  }

  void delete({required String token, required int id}) async {
    print("Delete item $id");
    Response res = await dio(token: token).delete('cart', data: {"id": id});
    if (res.statusCode == 200) {
      items = res.data['items'];
      count = res.data['count'];
    }
    totalCount();
    notifyListeners();
  }

  void checkout({required String token, required Map data}) async {
    Response res = await dio(token: token).post('/checkout', data: data);
    if (res.statusCode == 200) {
      items = [];
      count = 0;
    }
    totalCount();
    notifyListeners();
  }
}
