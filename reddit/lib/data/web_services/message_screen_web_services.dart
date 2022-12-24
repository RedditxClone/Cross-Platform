// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:reddit/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

import '../model/auth_model.dart';

/// This class is responsible of performing All Messages requests to the REST API
class MessageScreenWebServices {
  late Dio dio;
  String mockUrl =
      "https://43a82e45-5f65-4651-90fe-a2190fb44ded.mock.pstmn.io/";

  ///Setting Dio Options.
  MessageScreenWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl, //mockUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  /// This function makes the request to the server to get All Sent Messages .
  ///
  /// This function calls the function [ dio.get ] which makes the request to the server.
  /// Returns the response from the server.
  dynamic getAllSentMessages() async {
    try {
      // Response response = await dio.get('message/me/sent');
      Response response = await dio.get('message/me/sent',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
          ));
      debugPrint('status code : ${response.statusCode}');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }

  /// This function makes the request to the server to get All Messages Inbox.
  ///
  /// This function calls the function [ dio.get ] which makes the request to the server.
  /// Returns the response from the server.
  dynamic getAllMessagesInbox() async {
    try {
      //Response response = await dio.get('message/me/message');
      Response response = await dio.get('message/me/message',
          options: Options(
            headers: {"Authorization": "Bearer ${UserData.user!.token}"},
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
