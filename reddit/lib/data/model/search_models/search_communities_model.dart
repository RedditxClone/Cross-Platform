class SearchComminityModel {
  String? id;
  String? name;
  int? users; //user counts in the subreddit
  bool? joined;
  List<dynamic>? flairList;
  List<dynamic>? categories;
  DateTime? creationDate;

  SearchComminityModel({
    required this.id,
    required this.name,
    required this.users,
    required this.joined,
    required this.flairList,
    required this.categories,
    required this.creationDate,
  });
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

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "users": users,
      "joined": joined,
      "flairList": flairList,
      "categories": categories,
      "createdDate": creationDate!.toString(),
    };
  }
}
