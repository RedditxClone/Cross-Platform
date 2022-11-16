/// Community model
class CreateCommunityModel {
  late String communityName;
  late String communityType;
  late bool isAbove18;
  CreateCommunityModel(this.communityName, this.communityType, this.isAbove18);
  CreateCommunityModel.fromJson(Map<String, dynamic> json) {
    communityName = json['subredditID'];
    communityType = json['subreddtType'];
    isAbove18 = json['above_18'];
  }
  Map<String, dynamic> toJson() => {
        'subredditID': communityName,
        'subreddtType': communityType,
        'above_18': isAbove18,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateCommunityModel &&
          other.communityName == communityName &&
          other.communityType == communityType &&
          other.isAbove18 == isAbove18;
}
