class ProfileSettings {
  late String cover;
  late bool nsfw;
  late bool allowPeopleToFollowYou;
  late bool activeInCommunitiesVisibility;
  late bool contentVisibility;
  ProfileSettings() {
    cover = '';
    nsfw = false;
    allowPeopleToFollowYou = false;
    activeInCommunitiesVisibility = false;
    contentVisibility = false;
  }

  ProfileSettings.fromjson(Map<String, dynamic> json) {
    cover = json['cover'];
    nsfw = json['nsfw'];
    allowPeopleToFollowYou = json['allowPeopleToFollowYou'];
    activeInCommunitiesVisibility = json['activeInCommunitiesVisibility'];
    contentVisibility = json['contentVisibility'];
  }
}
