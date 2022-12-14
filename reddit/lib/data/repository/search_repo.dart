import 'package:dio/dio.dart';

import '../model/auth_model.dart';
import '../model/search_models/search_comments_model.dart';
import '../model/search_models/search_communities_model.dart';
import '../model/search_models/search_post_model.dart';
import '../web_services/search_web_service.dart';

class SearchRepo {
  final SearchWebService searchWebService;
  SearchRepo(this.searchWebService);

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the suggestions for the word we search for.
  /// This function calls the function [SearchWebService.getSuggestions] which makes the request to the server.
  /// Returns [List] that conatins the suggested users and subreddits.
  Future<List<List<Map<String, dynamic>>>> getSuggestions(String word) async {
    var res = await searchWebService.getSuggestions(word);
    if (res.statusCode == 200) {
      return List<List<Map<String, dynamic>>>.from(res.data);
    } else {
      return [];
    }
  }

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the users for the word we search for.
  /// This function calls the function [SearchWebService.searchPeople] which makes the request to the server.
  /// Returns [List] that conatins the users.
  Future<List<User>> searchPeople(String word) async {
    Response res = await searchWebService.searchPeople(word);
    if (res.statusCode == 200) {
      return List<User>.from(res.data.map((x) => User.fromJson(x)));
    } else {
      return [];
    }
  }

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the posts for the word we search for.
  /// This function calls the function [SearchWebService.searchPosts] which makes the request to the server.
  /// Returns [List] that conatins the posts.
  Future<List<SearchPostModel>> searchPosts(String word) async {
    Response res = await searchWebService.searchPosts(word);
    if (res.statusCode == 200) {
      return List<SearchPostModel>.from(
          res.data.map((x) => SearchPostModel.fromJson(x)));
    } else {
      return [];
    }
  }

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the communities for the word we search for.
  /// This function calls the function [SearchWebService.searchCommunities] which makes the request to the server.
  /// Returns [List] that conatins the communities.
  Future<List<SearchComminityModel>> searchCommunities(String word) async {
    Response res = await searchWebService.searchCommunities(word);
    if (res.statusCode == 200) {
      return List<SearchComminityModel>.from(
          res.data.map((x) => SearchComminityModel.fromJson(x)));
    } else {
      return [];
    }
  }

  /// [word] : [String] The word to search for.
  ///
  /// This function makes the request to the server to get the comments for the word we search for.
  /// This function calls the function [SearchWebService.searchComments] which makes the request to the server.
  /// Returns [List] that conatins the comments.
  Future<List<SearchCommentsModel>> searchComments(String word) async {
    Response res = await searchWebService.searchComments(word);
    if (res.statusCode == 200) {
      return List<SearchCommentsModel>.from(
          res.data.map((x) => SearchCommentsModel.fromJson(x)));
    } else {
      return [];
    }
  }
}
