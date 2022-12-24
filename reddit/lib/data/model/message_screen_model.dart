/// This class represents the data model of Inbox Messages from  "/api/message/me/message".
class AllMessageInboxModel {
  late String id;
  late String authorName;
  late String subject;
  late String body;
  late String createdAt;

  AllMessageInboxModel({
    required this.id,
    required this.authorName,
    required this.subject,
    required this.body,
    required this.createdAt,
  });

  @override
  // ignore: hash_and_equals
  /// [other] : is a [AllMessageInboxModel] object that we want to compare with
  ///
  /// Returns a [bool] that represent the equivilance of two [AllMessageInboxModel] objects
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllMessageInboxModel &&
          id == other.id &&
          authorName == other.authorName &&
          subject == other.subject &&
          body == other.body &&
          createdAt == other.createdAt;

  /// [json] : [Map] of the Inbox Messages that was returned by the API.
  ///
  /// Returns [AllMessageInboxModel] object that contains the data of [json].
  AllMessageInboxModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    authorName = json['authorName'];
    subject = json['subject'];
    body = json['body'];
    createdAt = json['createdAt'];
  }

  /// To Check Data of the Object from this Model Class [AllMessageInboxModel].
  printfunc() {
    print(
        'MassageModel: id =$id ,authorName=$authorName , subject =$subject ,body=$body ,createdAt=$createdAt');
  }
}

/// This class helping in return Object contain List of [InboxModelling] Recived from Server.
class InboxModelling {
  List<AllMessageInboxModel>? messages;
  InboxModelling() {
    messages = [];
  }

  /// [jsons] : [List] of the Inbox Messages that was returned by the API.
  ///
  /// intializing [messages]
  /// Returns [InboxModelling] object that contains the List data of [jsons].
  copyMessagesFromJson(List<dynamic> jsons) {
    messages = [];
    if (messages != null) {
      for (var json in jsons) {
        messages!.add(AllMessageInboxModel.fromJson((json)));
      }
      print('Inbox data after Modilling');
      print(messages!.length);
      for (var message in messages!) {
        print(message.printfunc());
      }
    }
  }

  /// [json] : [Map] of the messages Object that was returned by the API.
  ///
  /// intializing [messages] of [json] Data.
  fromJson(Map<String, dynamic> json) {
    copyMessagesFromJson(json['messages']);
  }

  /// [json] : [List] of the data List that was returned by the API.
  ///
  /// intializing [json] of [jsons] Data.
  copydataFromJson(List<dynamic> jsons) {
    var json = jsons[0];
    fromJson(json);
  }

  /// [json] : [Map] of the data Object that was returned by the API.
  ///
  /// intializing [data] of [json] Data.
  datafromJson(Map<String, dynamic> json) {
    copydataFromJson(json['data']);
  }
}

/// This class represents the data model of Sent Messages from  "/api/message/me/sent".
class AllSentMessageModel {
  late String id;
  late String destName;
  late String subject;
  late String body;
  late String createdAt;

  AllSentMessageModel({
    required this.id,
    required this.destName,
    required this.subject,
    required this.body,
    required this.createdAt,
  });

  @override
  // ignore: hash_and_equals
  /// [other] : is a [AllSentMessageModel] object that we want to compare with
  ///
  /// Returns a [bool] that represent the equivilance of two [AllSentMessageModel] objects
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllSentMessageModel &&
          id == other.id &&
          destName == other.destName &&
          subject == other.subject &&
          body == other.body &&
          createdAt == other.createdAt;

  /// [json] : [Map] of the Sent Messages that was returned by the API.
  ///
  /// Returns [AllSentMessageModel] object that contains the data of [json].
  AllSentMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    destName = json['destName'];
    subject = json['subject'];
    body = json['body'];
    createdAt = json['createdAt'];
  }

  /// To Check Data of the Object from this Model Class [AllSentMessageModel].
  printfunc() {
    print(
        'MassageModel: id =$id ,destName=$destName , subject =$subject ,body=$body ,createdAt=$createdAt');
  }
}

/// This class helping in return Object contain List of [AllSentMessageModel] Recived from Server.
class SentModelling {
  List<AllSentMessageModel>? messages;
  SentModelling() {
    messages = [];
  }

  /// [jsons] : [List] of the Sent Messages that was returned by the API.
  ///
  /// intializing [messages]
  /// Returns [SentModelling] object that contains the List data of [jsons].
  copyMessagesFromJson(List<dynamic> jsons) {
    messages = [];
    if (messages != null) {
      for (var json in jsons) {
        messages!.add(AllSentMessageModel.fromJson((json)));
      }
      print('Sent data after Modilling');
      print(messages!.length);
      for (var message in messages!) {
        print(message.printfunc());
      }
    }
  }

  /// [json] : [Map] of the messages Object that was returned by the API.
  ///
  /// intializing [messages] of [json] Data.
  fromJson(Map<String, dynamic> json) {
    copyMessagesFromJson(json['messages']);
  }

  /// [json] : [List] of the data List that was returned by the API.
  ///
  /// intializing [json] of [jsons] Data.
  copydataFromJson(List<dynamic> jsons) {
    var json = jsons[0];
    fromJson(json);
  }

  /// [json] : [Map] of the data Object that was returned by the API.
  ///
  /// intializing [data] of [json] Data.
  datafromJson(Map<String, dynamic> json) {
    copydataFromJson(json['data']);
  }
}
