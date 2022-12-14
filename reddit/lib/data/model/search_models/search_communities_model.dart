class SearchComminityModel {
  String? id;
  String? name;
  int? users; //user counts in the subreddit

  SearchComminityModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    users = json['users'];
  }
}
