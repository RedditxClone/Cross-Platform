/// # Settings data model
class Settings {
  late String profile;
  late String cover;
  late String displayName;
  late String about;
  late bool nsfw;
  late bool allowPeopleToFollowYou;
  late bool activeInCommunitiesVisibility;
  late bool contentVisibility;
  late String disroptiveSettings;
  late bool showUnInSearch;
  late bool personalizeAllOfReddit;
  late bool personalizeAdsInformation;
  late bool personalizeAdsYourActivity;
  late bool personalizeRecGeneralLocation;
  late bool personalizeRecOurPartners;
  late bool useTwoFactorAuthentication;
  Settings(
      {profile = '',
      cover = '',
      displayName = '',
      about = '',
      nsfw = true,
      allowPeopleToFollowYou = true,
      activeInCommunitiesVisibility = true,
      contentVisibility = true,
      disroptiveSettings = 'OFF',
      showUnInSearch = true,
      personalizeAllOfReddit = true,
      personalizeAdsInformation = true,
      personalizeAdsYourActivity = true,
      personalizeRecGeneralLocation = true,
      personalizeRecOurPartners = true,
      useTwoFactorAuthentication = true});

  /// ### Transform the data from json to Settings Class object
  Settings.fromjson(Map<String, dynamic> json) {
    profile = json['profile'];
    cover = json['cover'];
    displayName = json['displayName'];
    about = json['about'];
    nsfw = json['nsfw'];
    allowPeopleToFollowYou = json['allowPeopleToFollowYou'];
    activeInCommunitiesVisibility = json['activeInCommunitiesVisibility'];
    contentVisibility = json['contentVisibility'];
    disroptiveSettings = json['disroptiveSettings'];
    showUnInSearch = json['showUnInSearch'];
    personalizeAllOfReddit = json['personalizeAllOfReddit'];
    personalizeAdsInformation = json['personalizeAds_information'];
    personalizeAdsYourActivity = json['personalizeAds_yourActivity'];
    personalizeRecGeneralLocation = json['personalizeRec_generalLocation'];
    personalizeRecOurPartners = json['personalizeRec_ourPartners'];
    useTwoFactorAuthentication = json['Use two-factor authentication'];
  }
}
