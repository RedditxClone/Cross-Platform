// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

class MessageScreenWebServices {
  late Dio dio;
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzODhhNjFiNWUwYjU4M2Y0YTc5ZTQxYSIsImlhdCI6MTY2OTg5OTgwMywiZXhwIjoxNjcwNzYzODAzfQ.19uD_QlcThGaS_lZ0iE92q0771WwJSB2jgWfJPTWkn8";
  //String mockUrl = "https://43a82e45-5f65-4651-90fe-a2190fb44ded.mock.pstmn.io/";
  ///Setting Dio Options.
  MessageScreenWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  dynamic getAllSentMessages() async {
    try {
      Response response = await dio.get('message/me/sent',
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint('status code : ${response.statusCode}');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }

  dynamic getAllMessagesInbox() async {
    try {
      Response response = await dio.get('message/me/message',
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      debugPrint('status code : ${response.statusCode}');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
