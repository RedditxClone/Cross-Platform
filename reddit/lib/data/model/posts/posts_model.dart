class PostsModel {
  String? subredditId;
  String? title;
  String? text;
  bool? nsfw;
  bool? spoiler;
  List<String>? flair;
  String? publishedDate;
  String? userID;
  String? userName;
  String? subredditName;
  int? numComments;
  int? numVotes;
  bool? upVoted;
  bool? downVoted;
  PostsModel({
    this.subredditId,
    this.title,
    this.text,
    this.nsfw,
    this.spoiler,
    this.flair,
    this.publishedDate,
    this.userID,
    this.userName,
    this.subredditName,
    this.numComments,
    this.numVotes,
    this.upVoted,
    this.downVoted,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    subredditId = json['subredditId'];
    title = json['title'];
    text = json['text'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    flair = json['flair'].cast<String>();
    publishedDate = json['publishedDate'];
    userID = json['userID'];
    userName = json['userName'];
    subredditName = json['subredditName'];
    numComments = json['numComments'];
    numVotes = json['numVotes'];
    upVoted = json['upVoted'];
    downVoted = json['downVoted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subredditId'] = this.subredditId;
    data['title'] = this.title;
    data['text'] = this.text;
    data['nsfw'] = this.nsfw;
    data['spoiler'] = this.spoiler;
    data['flair'] = this.flair;
    data['publishedDate'] = this.publishedDate;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['subredditName'] = this.subredditName;
    data['numComments'] = this.numComments;
    data['numVotes'] = this.numVotes;
    data['upVoted'] = this.upVoted;
    data['downVoted'] = this.downVoted;
    return data;
  }
}
