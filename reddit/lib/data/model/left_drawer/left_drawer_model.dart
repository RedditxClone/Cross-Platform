class LeftDrawerModel {
  String? name;
  String? image;
  bool? favorite;

  LeftDrawerModel({this.name, this.image, this.favorite});

  LeftDrawerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['favorite'] = favorite;
    return data;
  }
}
