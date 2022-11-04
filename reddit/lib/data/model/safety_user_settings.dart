import 'package:flutter/foundation.dart';

/// Safety Settings data model
class SafetySettings {
  late String profile;
  late String cover;
  late String displayName;
  late String about;
  late bool nsfw;
  late bool allowPeopleToFollowYou;
  late bool activeInCommunitiesVisibility;
  late bool contentVisibility;
  late String disroptiveSettings;
  late List<dynamic> blocked;
  late bool showUnInSearch;
  late bool personalizeAllOfReddit;
  late bool personalizeAdsInformation;
  late bool personalizeAdsYourActivity;
  late bool personalizeRecGeneralLocation;
  late bool personalizeRecOurPartners;
  late bool useTwoFactorAuthentication;
  SafetySettings(
      {required this.profile,
      required this.cover,
      required this.displayName,
      required this.about,
      required this.nsfw,
      required this.allowPeopleToFollowYou,
      required this.activeInCommunitiesVisibility,
      required this.contentVisibility,
      required this.disroptiveSettings,
      required this.blocked,
      required this.showUnInSearch,
      required this.personalizeAllOfReddit,
      required this.personalizeAdsInformation,
      required this.personalizeAdsYourActivity,
      required this.personalizeRecGeneralLocation,
      required this.personalizeRecOurPartners,
      required this.useTwoFactorAuthentication});

  ///  Transform the data from json to Settings Class object
  SafetySettings.fromjson(Map<String, dynamic> json) {
    profile = json['profile'];
    cover = json['cover'];
    displayName = json['displayName'];
    about = json['about'];
    nsfw = json['nsfw'];
    allowPeopleToFollowYou = json['allowPeopleToFollowYou'];
    activeInCommunitiesVisibility = json['activeInCommunitiesVisibility'];
    contentVisibility = json['contentVisibility'];
    disroptiveSettings = json['disroptiveSettings'];
    blocked = json['blocked'];
    showUnInSearch = json['showUnInSearch'];
    personalizeAllOfReddit = json['personalizeAllOfReddit'];
    personalizeAdsInformation = json['personalizeAds_information'];
    personalizeAdsYourActivity = json['personalizeAds_yourActivity'];
    personalizeRecGeneralLocation = json['personalizeRec_generalLocation'];
    personalizeRecOurPartners = json['personalizeRec_ourPartners'];
    useTwoFactorAuthentication = json['useTwoFactorAuthentication'];
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SafetySettings &&
          profile == other.profile &&
          cover == other.cover &&
          displayName == other.displayName &&
          about == other.about &&
          nsfw == other.nsfw &&
          allowPeopleToFollowYou == other.allowPeopleToFollowYou &&
          activeInCommunitiesVisibility ==
              other.activeInCommunitiesVisibility &&
          contentVisibility == other.contentVisibility &&
          disroptiveSettings == other.disroptiveSettings &&
          listEquals(blocked, other.blocked) &&
          showUnInSearch == other.showUnInSearch &&
          personalizeAllOfReddit == other.personalizeAllOfReddit &&
          personalizeAdsInformation == other.personalizeAdsInformation &&
          personalizeAdsYourActivity == other.personalizeAdsYourActivity &&
          personalizeRecGeneralLocation ==
              other.personalizeRecGeneralLocation &&
          personalizeRecOurPartners == other.personalizeRecOurPartners &&
          useTwoFactorAuthentication == other.useTwoFactorAuthentication;
}
