import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        sendTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );
  }

  static Future getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    var response = await dio.get(url, queryParameters: query);
    return response.data;
  }

  static Future getDataWithHeaders({
    required String url,
    required Map<String, dynamic> query,
    required Map<String, dynamic> headers,
  }) async {
    var response = await dio.get(
      url,
      queryParameters: query,
      options: Options(headers: headers),
    );
    return response.data;
  }

  static Future postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    var response = await dio.post(url, data: data);
    return response.data;
  }

  static Future postDataWithHeaders({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, dynamic> headers,
  }) async {
    var response = await dio.post(
      url,
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }
}
