import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(
  baseUrl: "https://api.themoviedb.org/3/",
  queryParameters: {"api_key": "c5850ed73901b8d268d0898a8a9d8bff"},
));