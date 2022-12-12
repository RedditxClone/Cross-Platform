import 'package:reddit/data/web_services/user_profile/user_profile_webservices.dart';

class UserProfileRepository {
  final UserProfileWebServices userProfileWebServices;

  UserProfileRepository(this.userProfileWebServices);

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
}
