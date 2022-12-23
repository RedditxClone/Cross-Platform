import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';

/// This class is responsible of performing safety settings requests to the REST API
class MessagesWebServices {
  late Dio dio;
  bool isMockerServer = useMockServerForAllWebServices;

  MessagesWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: isMockerServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );

    dio = Dio(options);
  }

  /// [messageData] : [Map] that contains the subject and the body of the message to be sent
  /// [username]    : username to sent the message to.
  /// Returns all user safety settings if the request is performend succefuly or an null if an exception
  /// occured while trying to perform the request.
  ///
  /// This function Performs get request to the endpoint `baseUrl/user/me/prefs` to get all user settings from the API.
  Future<dynamic> sendMessage(
      Map<String, dynamic> messageData, String username) async {
    try {
      Response response = await dio.post('message/$username',
          data: messageData,
          options: Options(
            headers: {"Authorization": "Bearer  ${UserData.user!.token}"},
          ));
      debugPrint('message send status code : ${response.statusCode}');
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
