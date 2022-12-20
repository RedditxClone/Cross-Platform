// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';

class MessageScreenWebServices {
  late Dio dio;

  ///Setting Dio Options.
  MessageScreenWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://43a82e45-5f65-4651-90fe-a2190fb44ded.mock.pstmn.io/",
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  dynamic getAllSentMessages() async {
    try {
      Response response = await dio.get('message/me/sent');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }

  dynamic getAllMessagesInbox() async {
    try {
      Response response = await dio.get('message/me/message');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
