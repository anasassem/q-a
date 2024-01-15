import 'package:dio/dio.dart';

const String contentType = "content-type";
const String applicationJson = "application/json";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  Dio getDio() {
    Dio dio = Dio();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: "key=AAAA4eq02J0:APA91bEjPdrL25NFDZi3SuAkApc62y8Mbv3bP0swXoOsUlxA1FDNou1iE8AhwP4xP6_xpWatEL7oFod5fXduf0gqNfIIWuXX3rpjNotd3bnRXn_pm4YqAu4RtCo8zo2bswofzRVVFyKa"
    };
    dio.options = BaseOptions(
      baseUrl: "",
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: headers,
    );
    return dio;
  }
}
