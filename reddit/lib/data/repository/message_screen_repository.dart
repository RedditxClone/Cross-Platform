// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:reddit/data/model/message_screen_model.dart';

import 'package:reddit/data/web_services/message_screen_web_services.dart';

/// Repo for Reciveng data from Web Server.
///
/// Then Model it.
/// Then Sending it to Cubit.
class MessageScreenRepository {
  final MessageScreenWebServices messageScreenWebServices;
  SentModelling sentModelling = SentModelling();
  InboxModelling inboxModelling = InboxModelling();

  MessageScreenRepository({
    required this.messageScreenWebServices,
  });

  Future<InboxModelling> getAllMessageInboxModel() async {
    final allMessages = await messageScreenWebServices.getAllMessagesInbox();
    print("All InboxMessages from repo:");
    print("$allMessages");
    if (allMessages != []) {
      inboxModelling.datafromJson(allMessages);
      return inboxModelling;
    } else {
      return InboxModelling();
    }
  }

  Future<SentModelling> getAllSentMessageModel() async {
    final sentMessages = await messageScreenWebServices.getAllSentMessages();
    print("All sent Messages from repo:");
    print("$sentMessages");
    if (sentMessages != []) {
      sentModelling.datafromJson(sentMessages);
      return sentModelling;
    } else {
      return SentModelling();
    }
  }
}
