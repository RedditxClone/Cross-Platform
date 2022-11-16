class PostModel {
  late String subredditId;
  late String title;
  late String text;
  late bool nsfw;
  late bool spoiler;
  late List<String> flairs;

  PostModel(
      {required this.subredditId,
      required this.title,
      required this.text,
      required this.nsfw,
      required this.spoiler,
      required this.flairs});

  PostModel.fromJson(Map<String, dynamic> json) {
    subredditId = json['subredditId'];
    title = json['title'];
    text = json['text'];
    nsfw = json['nsfw'];
    spoiler = json['spoiler'];
    flairs = (json['flairs']).cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subredditId'] = subredditId;
    data['title'] = title;
    data['text'] = text;
    data['nsfw'] = nsfw;
    data['spoiler'] = spoiler;
    data['flairs'] = flairs;
    return data;
  }

  void copy(PostModel other) {
    subredditId = other.subredditId;
    title = other.title;
    text = other.text;
    nsfw = other.nsfw;
    spoiler = other.spoiler;
    flairs = other.flairs;
  }
}

