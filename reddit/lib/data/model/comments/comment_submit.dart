class CommentSubmit {
  String? parentId;
  String? subredditId;
  String? postId;
  String? text;

  CommentSubmit({this.parentId, this.subredditId, this.postId, this.text});

  CommentSubmit.fromJson(Map<String, dynamic> json) {
    parentId = json['parentId'];
    subredditId = json['subredditId'];
    postId = json['postId'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentId'] = this.parentId;
    data['subredditId'] = this.subredditId;
    data['postId'] = this.postId;
    data['text'] = this.text;
    return data;
  }
}
