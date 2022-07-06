import 'package:dio/dio.dart';

Dio dio({String? token}) {
  Dio dio = Dio();
  dio.options.baseUrl = 'https://ecomm.my.id/api/';
  dio.options.headers['Accept'] = 'application/json';
  if (token != null) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  return dio;
}
