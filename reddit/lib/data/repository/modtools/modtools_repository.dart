import 'package:reddit/data/web_services/modtools/modtools_webservices.dart';

class ModToolsRepository {
  final ModToolsWebServices webServices;
  ModToolsRepository(this.webServices);

  /// [subredditID] is the id of subreddit to which we get the approved list
  /// Returns [List] of the approved users in modtools
  Future<List<dynamic>> getAprroved(String subredditID) async {
    final approvedList = await webServices.getApproved(subredditID);
    return approvedList;
  }

  /// [subredditID] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  /// Returns status code 201 if insert is successfull
  Future<int> addApprovedUser(String subredditID, String username) async {
    final statusCode = await webServices.addApprovedUser(subredditID, username);
    return statusCode;
  }

  /// [subredditID] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  /// Returns status code 201 if remove is successfull
  Future<int> removeApprovedUser(String subredditID, String username) async {
    final statusCode =
        await webServices.removeApprovedUser(subredditID, username);
    return statusCode;
  }
}
