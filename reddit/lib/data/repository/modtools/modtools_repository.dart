import 'package:reddit/data/web_services/modtools/modtools_webservices.dart';

class ModToolsRepository {
  final ModToolsWebServices webServices;
  ModToolsRepository(this.webServices);

  /// Returns [statusCode] : 201 = Message created successfully, 403 = Unauthorized
  Future<List<dynamic>> getAprroved(String subredditID) async {
    final approvedList = await webServices.getApproved(subredditID);
    return approvedList;
  }

  /// Returns [statusCode] : 201 = Message created successfully, 403 = Unauthorized
  Future<int> addApprovedUser(String subredditID, String username) async {
    final statusCode = await webServices.addApprovedUser(subredditID, username);
    return statusCode;
  }

  /// Returns [statusCode] : 201 = Message created successfully, 403 = Unauthorized
  Future<int> removeApprovedUser(String subredditID, String username) async {
    final statusCode =
        await webServices.removeApprovedUser(subredditID, username);
    return statusCode;
  }
}
