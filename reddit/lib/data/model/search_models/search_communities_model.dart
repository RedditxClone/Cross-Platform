class SearchComminityModel {
  String? id;
  String? name;
  int? users; //user counts in the subreddit
  bool? joined;
  List<dynamic>? flairList;
  List<dynamic>? categories;
  DateTime? creationDate;


  SearchComminityModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    name = json['name'] ?? "";
    users = json['users'] ?? 0;
    joined = json['joined'] ?? false;
    flairList = json['flairList'] ?? [];
    categories = json['categories'] ?? [];
    creationDate =
        DateTime.parse(json['createdDate'] ?? DateTime.now().toString());
  }
}
