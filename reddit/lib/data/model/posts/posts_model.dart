class PostsModel {
  String? sId;
  String? text;
  int? votesCount;
  String? userId;
  bool? nsfw;
  bool? spoiler;
  String? flair;
  List<String>? images;
  int? commentCount;
  String? title;
  String? publishedDate;
  String? postId;
  PostSubreddit? subreddit;
  PostUser? user;
  String? voteType;
  String? spammedBy;
  String? spammedAt;
  String? removedBy;
  String? removedAt;
  String? editCheckedBy;
  String? approvedBy;
  String? approvedAt;
  String? type;
  bool? commentsLocked;
  bool? visited;
  bool? replyNotifications;
  bool? isSaved;
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
      this.voteType,
      this.spammedBy,
      this.spammedAt,
      this.removedBy,
      this.removedAt,
      this.editCheckedBy,
      this.approvedBy,
      this.approvedAt,
      this.type,
      this.commentsLocked,
      this.visited,
      this.replyNotifications,
      this.isSaved});

  PostsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    votesCount = json['votesCount'];
    userId = json['userId'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    // flair = json['flair'];
    images = json['images'] == null ? [] : json['images'].cast<String>();
    commentCount = json['commentCount'];
    title = json['title'];
    publishedDate = json['publishedDate'];
    postId = json['postId'];
    subreddit = json['subredditInfo'] != null
        ? new PostSubreddit.fromJson(json['subredditInfo'])
        : null;
    user = json['user'] != null ? new PostUser.fromJson(json['user']) : null;
    voteType = json['voteType'];
    spammedBy = json['spammedBy'];
    spammedAt = json['spammedAt'];
    removedBy = json['removedBy'];
    removedAt = json['removedAt'];
    editCheckedBy = json['editCheckedBy'];
    approvedBy = json['approvedBy'];
    approvedAt = json['approvedAt'];
    type = json['type'];
    commentsLocked = json['commentsLocked'];
    visited = json['visited'];
    replyNotifications = json['replyNotifications'];
    isSaved = json['isSaved'];
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
    data['spammedBy'] = this.spammedBy;
    data['spammedAt'] = this.spammedAt;
    data['removedBy'] = this.removedBy;
    data['removedAt'] = this.removedAt;
    data['editCheckedBy'] = this.editCheckedBy;
    data['approvedBy'] = this.approvedBy;
    data['approvedAt'] = this.approvedAt;
    data['type'] = this.type;
    data['commentsLocked'] = this.commentsLocked;
    data['visited'] = this.visited;
    data['replyNotifications'] = this.replyNotifications;
    data['isSaved'] = this.isSaved;
    return data;
  }
}

class PostSubreddit {
  String? id;
  String? name;
  bool? isJoin;
  bool? isModerator;

  PostSubreddit({this.id, this.name, this.isJoin, this.isModerator});

  PostSubreddit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isJoin = json['isJoin'];
    isModerator = json['isModerator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isJoin'] = this.isJoin;
    data['isModerator'] = this.isModerator;
    return data;
  }
}

class PostUser {
  String? id;
  String? photo;
  String? username;
  bool? isFollowed;
  bool? cakeDay;
  PostUser({this.id, this.photo, this.username, this.isFollowed, this.cakeDay});

  PostUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    username = json['username'];
    isFollowed = json['isFollowed'];
    cakeDay = json['cakeDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['username'] = this.username;
    data['isFollowed'] = this.isFollowed;
    data['cakeDay'] = this.cakeDay;
    return data;
  }
}
