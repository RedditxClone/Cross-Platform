import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
    Response res = await searchWebService.getSuggestions(word);
    if (res.statusCode == 200) {
      return List<List<Map<String, dynamic>>>.from(
        res.data.map(
          (x) => List<Map<String, dynamic>>.from(
            x.map(
              (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)),
            ),
          ),
        ),
      );
    } else {
      return [];
    }
    /*
    response
    [
    [
        {
            "_id": "639b40ade14bed80ef988757",
            "username": "1234",
            "profilePhoto": "assets/profilePhotos/639b40ade14bed80ef988757.jpeg",
            "coverPhoto": "",
            "about": "",
            "nsfw": false,
            "allowFollow": true,
            "cakeDay": true,
            "userId": "639b40ade14bed80ef988757",
            "followed": false
        },
        {
            "_id": "638f974731186b7fd21bae53",
            "username": "ahmed12345",
            "profilePhoto": "",
            "coverPhoto": "",
            "about": "",
            "nsfw": false,
            "allowFollow": true,
            "cakeDay": true,
            "userId": "638f974731186b7fd21bae53",
            "followed": false
        },
        {
            "_id": "638f37de31186b7fd21ba6aa",
            "username": "ahmed222",
            "profilePhoto": "",
            "coverPhoto": "",
            "about": "",
            "nsfw": false,
            "allowFollow": true,
            "cakeDay": true,
            "userId": "638f37de31186b7fd21ba6aa",
            "followed": false
        },
        {
            "_id": "638f672331186b7fd21baddd",
            "username": "amfamf",
            "profilePhoto": "",
            "coverPhoto": "",
            "about": "",
            "nsfw": false,
            "allowFollow": true,
            "cakeDay": true,
            "userId": "638f672331186b7fd21baddd",
            "followed": false
        },
        {
            "_id": "638f377f31186b7fd21ba69f",
            "username": "attention-lbc7hi4701qinc0b68g",
            "profilePhoto": "",
            "coverPhoto": "",
            "about": "",
            "nsfw": false,
            "allowFollow": true,
            "cakeDay": true,
            "userId": "638f377f31186b7fd21ba69f",
            "followed": false
        }
    ],
    [
        {
            "_id": "639771faa875316ad8d9f3e4",
            "name": "bemoireddit",
            "over18": false,
            "flairList": [],
            "categories": [],
            "users": 1,
            "joined": false
        },
        {
            "_id": "6399b53e3eb38f2c2fb08e14",
            "name": "hamzawy",
            "over18": false,
            "flairList": [
                {
                    "text": "flair 1",
                    "backgroundColor": "lime",
                    "textColor": "black"
                },
                {
                    "text": "flair 2",
                    "backgroundColor": "red",
                    "textColor": "black"
                },
                {
                    "text": "flair 3",
                    "backgroundColor": "blue",
                    "textColor": "white"
                }
            ],
            "categories": [],
            "description": "This is a new Description",
            "users": 2,
            "joined": false
        },
        {
            "_id": "639a9ce93eb38f2c2fb09b6f",
            "name": "champions",
            "over18": false,
            "flairList": [],
            "categories": [],
            "users": 0,
            "joined": false
        },
        {
            "_id": "639b27bbef88b3df0463d04b",
            "name": "bemoireddit2",
            "over18": false,
            "flairList": [],
            "categories": [],
            "createdDate": "2022-12-15T06:27:30.805Z",
            "users": 0,
            "joined": false
        }
    ]
]
     */
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
  /// [sort] : [int] The sort type.
  /// [time] : [int] The time type.
  ///
  /// This function makes the request to the server to get the posts for the word we search for.
  /// This function calls the function [SearchWebService.searchPosts] which makes the request to the server.
  /// Returns [List] that conatins the posts.
  Future<List<SearchPostModel>> searchPosts(
      String word, int sort, int time) async {
    Response res = await searchWebService.searchPosts(word, sort, time);
    if (res.statusCode == 200) {
      return List<SearchPostModel>.from(res.data.map(
        (x) {
          return SearchPostModel.fromJson(x as Map<String, dynamic>);
        },
      ));
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
        res.data.map((x) => SearchComminityModel.fromJson(x)),
      );
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
      debugPrint("res.data: ${res.data}");
      return List<SearchCommentsModel>.from(
          res.data.map((x) => SearchCommentsModel.fromJson(x)));
    } else {
      return [];
    }
  }

  /// [subredditId] : [String] The id of the subreddit.
  ///
  /// This function makes the request to the server to join the subreddit.
  /// This function calls the function [SearchWebService.joinSubreddit] which makes the request to the server.
  /// Returns [bool] that indicates if the user joined the subreddit or not.
  Future<bool> joinSubreddit(String subredditId) async {
    Response res = await searchWebService.joinSubreddit(subredditId);
    if (res.statusCode == 201) {
      return true;
    } else {
      debugPrint(res.statusCode.toString());
      return false;
    }
  }

  /// [subredditId] : [String] The id of the subreddit.
  ///
  /// This function makes the request to the server to leave the subreddit.
  /// This function calls the function [SearchWebService.leaveSubreddit] which makes the request to the server.
  /// Returns [bool] that indicates if the user left the subreddit or not.
  Future<bool> leaveSubreddit(String subredditId) async {
    Response res = await searchWebService.leaveSubreddit(subredditId);
    if (res.statusCode == 201) {
      return true;
    } else {
      debugPrint(res.statusCode.toString());
      return false;
    }
  }

  /// [userId] : the id of user to be followed
  /// 
  /// This function makes the request to the server to follow the user.
  /// This function calls the function [SearchWebService.follow] which makes the request to the server.
  /// Returns [bool] that indicates if the user followed the user or not.
  Future<bool> follow(String userId) async {
    Response res = await searchWebService.follow(userId);
    if (res.statusCode == 201) {
      return true;
    } else {
      debugPrint(res.statusCode.toString());
      return false;
    }
  }

  /// [userId] : the id of user to be unfollowed
  /// 
  /// This function makes the request to the server to unfollow the user.
  /// This function calls the function [SearchWebService.unfollow] which makes the request to the server.
  /// Returns [bool] that indicates if the user unfollowed the user or not.
  Future<bool> unfollow(String userId) async {
    Response res = await searchWebService.unfollow(userId);
    if (res.statusCode == 201) {
      return true;
    } else {
      debugPrint(res.statusCode.toString());
      return false;
    }
  }
}
