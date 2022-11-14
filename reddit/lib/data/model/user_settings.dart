/// # Settings data model
class ProfileSettings {
  late String profile;
  late String cover;
  late String displayName;
  late String about;
  late bool nsfw;
  late bool allowPeopleToFollowYou;
  late bool activeInCommunitiesVisibility;
  late bool contentVisibility;
  ProfileSettings({
    required this.profile,
    required this.cover,
    required this.displayName,
    required this.about,
    required this.nsfw,
    required this.allowPeopleToFollowYou,
    required this.activeInCommunitiesVisibility,
    required this.contentVisibility,
  });

  /// ### Transform the data from json to Settings Class object
  ProfileSettings.fromjson(Map<String, dynamic> json) {
    profile = json['profilephoto'] ?? '';
    cover = json['coverphoto'] ?? '';
    displayName = json['displayName'] ?? '';
    about = json['about'] ?? '';
    nsfw = json['nsfw'];
    allowPeopleToFollowYou = json['allowFollow'];
    activeInCommunitiesVisibility = json['activeInCommunitiesVisibility'];
    contentVisibility = json['contentVisibility'];
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileSettings &&
          profile == other.profile &&
          cover == other.cover &&
          displayName == other.displayName &&
          about == other.about &&
          nsfw == other.nsfw &&
          allowPeopleToFollowYou == other.allowPeopleToFollowYou &&
          activeInCommunitiesVisibility ==
              other.activeInCommunitiesVisibility &&
          contentVisibility == other.contentVisibility;
}
