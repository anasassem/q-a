import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://pyocr-b3169decc152.herokuapp.com/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getDate({
    String lang = "en",
    String? token,
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": token ?? '',
      "lang": lang,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postDate({
    String lang = "en",
    String? token,
    Map<String, dynamic>? query,
    required String url,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": token ?? '',
      "lang": lang,
    };

    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putDate({
    String lang = "en",
    String? token,
    Map<String, dynamic>? query,
    required String url,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      "Authorization": token ?? '',
      "lang": lang,
    };

    return await dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
