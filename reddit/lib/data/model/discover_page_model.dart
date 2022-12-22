// ignore_for_file: public_member_api_docs, sort_constructors_first
/// Model for Updating User Preferences (feed settings) sending to "/api/user/me/prefs".
class DiscoverPageModel {
  late String postId;
  late String imageUrl;
  late String subredditName;

  DiscoverPageModel({
    required this.postId,
    required this.imageUrl,
    required this.subredditName,
  });

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoverPageModel &&
          postId == other.postId &&
          imageUrl == other.imageUrl &&
          subredditName == other.subredditName;

  /// Map settings comming from web services to the model.
  ///
  /// The repository (discover_page_repository) calls this function.
  /// It's parameter is json item to be sent to Web Server.
  DiscoverPageModel.fromJson(Map<String, dynamic> json) {
    postId = json['id'];
    String tempImageUrl = json['image'];
    imageUrl = tempImageUrl.substring(1);
    nameFromJson(json['subredditInfo']);
  }
  nameFromJson(Map<String, dynamic> json) {
    subredditName = json['name'];
  }
}
