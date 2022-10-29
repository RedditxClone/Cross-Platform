/// # Settings data model
class Settings {
  late String profile;
  late String cover;
  late bool nsfw;
  late bool allowPeopleToFollowYou;
  late bool activeInCommunitiesVisibility;
  late bool contentVisibility;
  late String disroptiveSettings;
  late bool showUnInSearch;
  late bool personalizeAllOfReddit;
  late bool personalizeAds;
  late bool personalizeRecGeneralLocation;
  late bool personalizeRecOurPartners;
  Settings() {
    profile = '';
    cover = '';
    nsfw = true;
    allowPeopleToFollowYou = true;
    activeInCommunitiesVisibility = true;
    contentVisibility = true;
    disroptiveSettings = 'OFF';
    showUnInSearch = true;
    personalizeAllOfReddit = true;
    personalizeAds = true;
    personalizeRecGeneralLocation = true;
    personalizeRecOurPartners = true;
  }

  /// ### Transform the data from json to Settings Class object
  Settings.fromjson(Map<String, dynamic> json) {
    profile = json['profile'];
    cover = json['cover'];
    nsfw = json['nsfw'];
    allowPeopleToFollowYou = json['allowPeopleToFollowYou'];
    activeInCommunitiesVisibility = json['activeInCommunitiesVisibility'];
    contentVisibility = json['contentVisibility'];
    disroptiveSettings = json['disroptiveSettings'];
    showUnInSearch = json['showUnInSearch'];
    personalizeAllOfReddit = json['personalizeAllOfReddit'];
    personalizeAds = json['personalizeAds'];
    personalizeRecGeneralLocation = json['personalizeRec_generalLocation'];
    personalizeRecOurPartners = json['personalizeRec_ourPartners'];
  }
}
