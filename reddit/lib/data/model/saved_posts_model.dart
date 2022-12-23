// ignore_for_file: public_member_api_docs, sort_constructors_first
/// Model for Getting savedPosts from  "/api/user/post/save".
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

  subredditFromJson(Map<String, dynamic> json) {
    subredditName = json['name'];
    subredditId = json['id'];
  }

  userFromJson(Map<String, dynamic> json) {
    userName = json['username'];
    String tempUserPhoto = json['photo'];
    userPhoto = tempUserPhoto.substring(1);
    userId = json['id'];
  }

  printfunc() {
    print(
        'Post: id =$id ,text=$text , commentCount =$commentCount ,title=$title ,publishedDate=$publishedDate , subredditId =$subredditId ,subredditName=$subredditName , votesCount =$votesCount ,userName=$userName ,userPhoto=$userPhoto,userId =$userId ');
  }
}

class SavedPostsModelling {
  List<SavedPostsModel>? savedPosts;
  SavedPostsModelling() {
    savedPosts = [];
  }
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

  datafromJson(Map<String, dynamic> json) {
    copysavedPostsFromJson(json['data']);
  }
}
