import 'package:reddit/data/web_services/messages/messages_web_services.dart';

class MessagesRepository {
  final MessagesWebServices webServices;
  MessagesRepository(this.webServices);

  /// [messageData] : [Map] that represent the JSON data to be sent.
  /// [userID] :
  ///
  /// Returns `statusCode` : 201 = Message created successfully, 403 = Unauthorized
  Future<dynamic> sendMessage(
      Map<String, dynamic> messageData, String userID) async {
    final statusCode = await webServices.sendMessage(messageData, userID);
    return statusCode;
  }
}
