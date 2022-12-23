/// Model for Getting Messages from  "/api/message/me/message".
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllMessageInboxModel &&
          id == other.id &&
          authorName == other.authorName &&
          subject == other.subject &&
          body == other.body &&
          createdAt == other.createdAt;

  AllMessageInboxModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    authorName = json['authorName'];
    subject = json['subject'];
    body = json['body'];
    createdAt = json['createdAt'];
  }
  printfunc() {
    print(
        'MassageModel: id =$id ,authorName=$authorName , subject =$subject ,body=$body ,createdAt=$createdAt');
  }
}

class InboxModelling {
  List<AllMessageInboxModel>? messages;
  InboxModelling() {
    messages = [];
  }
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

  fromJson(Map<String, dynamic> json) {
    copyMessagesFromJson(json['messages']);
  }

  copydataFromJson(List<dynamic> jsons) {
    var json = jsons[0];
    fromJson(json);
  }

  datafromJson(Map<String, dynamic> json) {
    copydataFromJson(json['data']);
  }
}

/// Model for Getting Messages from  "/api/message/me/sent".
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllSentMessageModel &&
          id == other.id &&
          destName == other.destName &&
          subject == other.subject &&
          body == other.body &&
          createdAt == other.createdAt;

  AllSentMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    destName = json['destName'];
    subject = json['subject'];
    body = json['body'];
    createdAt = json['createdAt'];
  }
  printfunc() {
    print(
        'MassageModel: id =$id ,destName=$destName , subject =$subject ,body=$body ,createdAt=$createdAt');
  }
}

class SentModelling {
  List<AllSentMessageModel>? messages;
  SentModelling() {
    messages = [];
  }
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

  fromJson(Map<String, dynamic> json) {
    copyMessagesFromJson(json['messages']);
  }

  copydataFromJson(List<dynamic> jsons) {
    var json = jsons[0];
    fromJson(json);
  }

  datafromJson(Map<String, dynamic> json) {
    copydataFromJson(json['data']);
  }
}
