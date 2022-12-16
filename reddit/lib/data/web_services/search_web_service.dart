import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/helper/dio.dart';

class SearchWebService {
  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the suggestions for the word we search for.
  /// This function calls the function [DioHelper.getData] which makes the request to the server.
  /// Returns the response from the server.
  Future getSuggestions(String word) async {
    try {
      var res =
          await DioHelper.getData(url: 'search/general/?word=$word', query: {});
      //     await DioHelper.getDataWithHeaders(
      //   url: 'search/general/?word=$word',
      //   query: {},
      //   headers: {
      //     "Authorization": "Bearer ${UserData.user!.token}",
      //   },
      // );
      return res;
    } on DioError catch (e) {
      debugPrint("from getSuggestions $e");
      return e.response;
    }
  }

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the users for the word we search for.
  /// This function calls the function [DioHelper.getData] which makes the request to the server.
  /// Returns the response from the server.
  Future searchPeople(String word) async {
    try {
      var res =
          await DioHelper.getData(url: 'search/peoples/?word=$word', query: {});
      return res;
    } on DioError catch (e) {
      debugPrint("from searchPeople $e");
      return e.response;
    }
  }

  /// [word] : [String] The word to search for.
  /// [sort] : [int] The sort type.
  /// [time] : [int] The time type.
  ///
  /// This function makes the request to the server to get the posts for the word we search for.
  /// This function calls the function [DioHelper.getData] which makes the request to the server.
  /// Returns the response from the server.
  Future searchPosts(String word, int sort, int time) async {
    try {
      var res = await DioHelper.getData(
          url: 'search/posts/?word=$word&sort=$sort', query: {});
      debugPrint("from searchPosts ${res.statusCode}");
      return res;
    } on DioError catch (e) {
      debugPrint("from searchPosts $e");
      return e.response;
    }
  }

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the communities for the word we search for.
  /// This function calls the function [DioHelper.getData] which makes the request to the server.
  /// Returns the response from the server.
  Future searchCommunities(String word) async {
    try {
      var res = await DioHelper.getData(
          url: 'search/communities/?word=$word', query: {});
      return res;
    } on DioError catch (e) {
      debugPrint("from searchCommunities $e");
      return e.response;
    }
  }

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the comments for the word we search for.
  /// This function calls the function [DioHelper.getData] which makes the request to the server.
  /// Returns the response from the server.
  Future searchComments(String word) async {
    try {
      var res = await DioHelper.getData(
          url: 'search/comments/?word=$word', query: {});
      return res;
    } on DioError catch (e) {
      debugPrint("from searchComments $e");
      return e.response;
    }
  }
}
