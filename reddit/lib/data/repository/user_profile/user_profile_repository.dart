import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/left_drawer/moderating_subreddits_left_drawer_model.dart';
import 'package:reddit/data/web_services/user_profile/user_profile_webservices.dart';

class UserProfileRepository {
  final UserProfileWebServices userProfileWebServices;

  UserProfileRepository(this.userProfileWebServices);

  /// [userId] : the id of user to get his info
  /// `Returns` [statusCode] of the request:
  Future<dynamic> getUserInfo(String userID) async {
    final userInfo = await userProfileWebServices.getUserInfo(userID);
    return User.fromJson(userInfo);
  }

  /// `Returns` [ModeratingSubredditsDrawerModel] that has the subreddits that the user is modertor at:
  Future<List<ModeratingSubredditsDrawerModel>>
      getMyModeratedSubreddits() async {
    final moderatedSubreddit =
        await userProfileWebServices.getMyModeratedSubreddits();
    return List<ModeratingSubredditsDrawerModel>.from(moderatedSubreddit
        .map((i) => ModeratingSubredditsDrawerModel.fromJson(i)));
  }

  /// [subredditId] : the id of subreddit to leave
  /// `Returns` : `statusCode` of the request:
  /// - 201: you have left the subreddit successfully
  /// - 400: 	user is not inside subreddit
  /// - 401: user is not logged in
  Future<dynamic> leaveSubreddit(String subredditId) async {
    final statusCode = await userProfileWebServices.leaveSubreddit(subredditId);
    return statusCode;
  }

  /// [userId] : the id of user to be followed
  /// `Returns` [statusCode] of the request:
  /// - 201: you have followed the user successfully
  /// - 400: either you are following the user or there is a block between you and the user
  /// - 401: user is not logged in
  Future<dynamic> follow(String userID) async {
    final statusCode = await userProfileWebServices.follow(userID);
    return statusCode;
  }

  /// [userId] : the id of user to be unfollowed
  /// `Returns` [statusCode] of the request:
  /// - 201: you have unfollowed the user successfully
  /// - 400: either you are not following the user or there is a block between you and the user or wrong user id
  /// - 401: user is not logged in
  Future<dynamic> unfollow(String userID) async {
    final statusCode = await userProfileWebServices.unfollow(userID);
    return statusCode;
  }

  /// [username] : the username we want to block
  ///
  /// Returns status code 200 if success and 401 if an error occured
  Future<dynamic> blockUser(String username) async {
    final newVal = await userProfileWebServices.blockUser(username);
    return newVal;
  }
}
