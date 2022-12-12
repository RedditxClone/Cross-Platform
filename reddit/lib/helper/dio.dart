import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';

class DioHelper {
  static late Dio _dio;

  static init() {
    _dio = Dio(
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
    var response = await _dio.get(url, queryParameters: query);
    return response;
  }

  static Future getDataWithHeaders({
    required String url,
    required Map<String, dynamic> query,
    required Map<String, dynamic> headers,
  }) async {
    var response = await _dio.get(
      url,
      queryParameters: query,
      options: Options(headers: headers),
    );
    return response;
  }

  static Future postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    var response = await _dio.post(url, data: data);
    return response;
  }

  static Future patchData({
    required String url,
    required dynamic data,
    required Options? options,
  }) async {
    var response = await _dio.patch(url, data: data, options: options);
    return response;
  }

  static Future postDataWithHeaders({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, dynamic> headers,
  }) async {
    var response = await _dio.post(
      url,
      data: data,
      options: Options(headers: headers),
    );
    return response;
  }
}
