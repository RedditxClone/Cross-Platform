// ignore_for_file: public_member_api_docs, sort_constructors_first

/// This class represents the data model of Saved Posts from  "/api/user/post/save".
class SavedPostsModel {
  late String id;
  late String text;
  late int commentCount;
  late String title;
  late String publishedDate;
  late String subredditName;
  late String subredditId;
  late int votesCount;
  late String userName;
  late String userPhoto;
  late String userId;

  SavedPostsModel({
    required this.id,
    required this.text,
    required this.commentCount,
    required this.title,
    required this.publishedDate,
    required this.subredditName,
    required this.subredditId,
    required this.votesCount,
    required this.userName,
    required this.userPhoto,
    required this.userId,
  });

  @override
  // ignore: hash_and_equals
  /// [other] : is a [SavedPostsModel] object that we want to compare with
  ///
  /// Returns a [bool] that represent the equivilance of two [SavedPostsModel] objects
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPostsModel &&
          id == other.id &&
          text == other.text &&
          commentCount == other.commentCount &&
          title == other.title &&
          publishedDate == other.publishedDate &&
          subredditName == other.subredditName &&
          subredditId == other.subredditId &&
          votesCount == other.votesCount &&
          userName == other.userName &&
          userPhoto == other.userPhoto &&
          userId == other.userId;

  /// [json] : [Map] of the Saved Posts that was returned by the API.
  ///
  /// Returns [SavedPostsModel] object that contains the data of [json].
  SavedPostsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    text = json['text'];
    commentCount = json['commentCount'];
    title = json['title'];
    publishedDate = json['publishedDate'];
    votesCount = json['votesCount'];
    subredditFromJson(json['subredditInfo']);
    userFromJson(json['user']);
  }

  /// [json] : [Map] of the Subreddit Info that was returned by the API.
  ///
  /// intializing [subredditId] & [subredditName] of [json] Data.
  subredditFromJson(Map<String, dynamic> json) {
    subredditName = json['name'];
    subredditId = json['id'];
  }

  /// [json] : [Map] of the User Info that was returned by the API.
  ///
  /// intializing [userName] & [userId] & []of [userPhoto] Data.
  userFromJson(Map<String, dynamic> json) {
    userName = json['username'];
    String tempUserPhoto = json['photo'];
    userPhoto = tempUserPhoto.substring(1);
    userId = json['id'];
  }

  /// To Check Data of the Object from this Model Class [SavedPostsModel].
  printfunc() {
    print(
        'Post: id =$id ,text=$text , commentCount =$commentCount ,title=$title ,publishedDate=$publishedDate , subredditId =$subredditId ,subredditName=$subredditName , votesCount =$votesCount ,userName=$userName ,userPhoto=$userPhoto,userId =$userId ');
  }
}

/// This class helping in return Object contain List of [SavedPostsModel] Recived from Server.
class SavedPostsModelling {
  List<SavedPostsModel>? savedPosts;
  SavedPostsModelling() {
    savedPosts = [];
  }

  /// [jsons] : [List] of the Saved Posts that was returned by the API.
  ///
  /// intializing [savedPosts]
  /// Returns [SavedPostsModelling] object that contains the List data of [jsons].
  copysavedPostsFromJson(List<dynamic> jsons) {
    savedPosts = [];
    if (savedPosts != null) {
      for (var json in jsons) {
        savedPosts!.add(SavedPostsModel.fromJson((json)));
      }
      print('Saved Posts after Modilling');
      print(savedPosts!.length);
      for (var post in savedPosts!) {
        print(post.printfunc());
      }
    }
  }

  /// [json] : [Map] of the Saved Post Object that was returned by the API.
  ///
  /// intializing [data] of [json] Data.
  datafromJson(Map<String, dynamic> json) {
    copysavedPostsFromJson(json['data']);
  }
}
