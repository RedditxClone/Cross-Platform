class PostsModel {
  String? sId;
  String? text;
  int? votesCount;
  String? userId;
  bool? nsfw;
  bool? spoiler;
  List<String>? flair;
  List<String>? images;
  int? commentCount;
  String? title;
  String? publishedDate;
  String? postId;
  PostSubreddit? subreddit;
  PostUser? user;
  String? voteType;

  PostsModel(
      {this.sId,
      this.text,
      this.votesCount,
      this.userId,
      this.nsfw,
      this.spoiler,
      this.flair,
      this.images,
      this.commentCount,
      this.title,
      this.publishedDate,
      this.postId,
      this.subreddit,
      this.user,
      this.voteType});

  PostsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    votesCount = json['votesCount'];
    userId = json['userId'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    // flair = json['flair'].cast<String>();
    images = json['images'].cast<String>();
    commentCount = json['commentCount'];
    title = json['title'];
    publishedDate = json['publishedDate'];
    postId = json['postId'];
    subreddit = json['subredditInfo'] != null
        ? new PostSubreddit.fromJson(json['subredditInfo'])
        : null;
    user = json['user'] != null ? new PostUser.fromJson(json['user']) : null;
    voteType = json['voteType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['votesCount'] = this.votesCount;
    data['userId'] = this.userId;
    data['nsfw'] = this.nsfw;
    data['spoiler'] = this.spoiler;
    data['flair'] = this.flair;
    data['images'] = this.images;
    data['commentCount'] = this.commentCount;
    data['title'] = this.title;
    data['publishedDate'] = this.publishedDate;
    data['postId'] = this.postId;
    if (this.subreddit != null) {
      data['subreddit'] = this.subreddit!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['voteType'] = this.voteType;
    return data;
  }
}

class PostSubreddit {
  String? id;
  String? name;
  String? type;

  PostSubreddit({this.id, this.name, this.type});

  PostSubreddit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class PostUser {
  String? id;
  String? photo;
  String? username;

  PostUser({this.id, this.photo, this.username});

  PostUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['username'] = this.username;
    return data;
  }
}
