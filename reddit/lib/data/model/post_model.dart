class PostModel {
  late String subredditId;
  late String title;
  late String text;
  late bool nsfw;
  late bool spoiler;
  late String flair;
  late DateTime publishedDate;
  PostModel(
      {required this.subredditId,
      required this.title,
      required this.text,
      required this.nsfw,
      required this.spoiler,
      required this.flair,
      required this.publishedDate});

  PostModel.fromJson(Map<String, dynamic> json) {
    subredditId = json['subredditId'];
    title = json['title'];
    text = json['text'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    flair = json['flair'];
    publishedDate = DateTime.parse(json['publishedDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subredditId'] = subredditId;
    data['title'] = title;
    if (text.isNotEmpty) {
      data['text'] = text;
    }
    data['nsfw'] = nsfw;
    data['spoiler'] = spoiler;
    if (flair.isNotEmpty) {
      data['flair'] = flair;
    }
    //data['publishedDate'] = publishedDate.toIso8601String();
    return data;
  }

  void copy(PostModel other) {
    subredditId = other.subredditId;
    title = other.title;
    text = other.text;
    nsfw = other.nsfw;
    spoiler = other.spoiler;
    flair = other.flair;
  }
}
