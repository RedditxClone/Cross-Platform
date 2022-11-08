import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reddit/constants/strings.dart';

class LeftDrawerWebServices {
  bool useMockServer = true;
  // Mock URL For Mockoon
  // String mockUrl = TargetPlatform.android == defaultTargetPlatform
  //     ? "http://10.0.2.2:3001/"
  //     : "http://127.0.0.1:3001/";
  // Mock URL For Postman
  String mockUrl =
      "https://a8eda59d-d8f3-4ef2-9581-29e6473824d9.mock.pstmn.io/";
  late Dio dio;
  LeftDrawerWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: useMockServer ? mockUrl : baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 secs
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  // Gets data from server, the repository calls this function
  Future<dynamic> getModeratingCommunities() async {
    try {
      Response response = await dio.get('user/moderating_communities');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return "Error in left drawer web services";
    }
  }

  Future<dynamic> getYourCommunities() async {
    try {
      Response response = await dio.get('user/joined_communities');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return "Error in left drawer web services";
    }
  }

  Future<dynamic> getFollowingUsers() async {
    try {
      Response response = await dio.get('user/following');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return "Error in left drawer web services";
    }
  }

  Future<int> updateLeftDrawer(Map<String, dynamic> newAccSettings) async {
    try {
      Response response = await dio.patch(
        'user/me/prefs',
        data: newAccSettings,
      );
      if (response.statusCode == 200) {
        print("Account settings updated successfully");
      } else {
        print("Failed to updateAccount settings");
      }
      return response.statusCode!;
    } catch (e) {
      print(e);
      return 404;
    }
  }
}
