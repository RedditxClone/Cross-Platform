class Comments {
  String? sId;
  String? text;
  int? votesCount;
  String? parentId;
  String? spammedBy;
  String? spammedAt;
  String? postId;
  User? user;
  String? voteType;
  String? type;
  String? createdDate;
  List<Comments>? children;

  Comments(
      {this.sId,
      this.text,
      this.votesCount,
      this.parentId,
      this.spammedBy,
      this.spammedAt,
      this.postId,
      this.user,
      this.voteType,
      this.type,
      this.createdDate,
      this.children});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    votesCount = json['votesCount'];
    parentId = json['parentId'];
    spammedBy = json['spammedBy'];
    spammedAt = json['spammedAt'];
    postId = json['postId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    voteType = json['voteType'];
    type = json['type'];
    createdDate = json['createdDate'];
    if (json['children'] != null) {
      children = <Comments>[];
      json['children'].forEach((v) {
        children!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['votesCount'] = this.votesCount;
    data['parentId'] = this.parentId;
    data['spammedBy'] = this.spammedBy;
    data['spammedAt'] = this.spammedAt;
    data['postId'] = this.postId;
    data['type'] = this.type;
    data['createdDate'] = this.createdDate;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['voteType'] = this.voteType;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? photo;
  String? username;
  bool? isFollowed;
  bool? cakeDay;

  User({this.id, this.photo, this.username, this.isFollowed, this.cakeDay});

  User.fromJson(Map<String, dynamic> json) {
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
