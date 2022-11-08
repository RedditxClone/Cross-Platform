import 'package:flutter/foundation.dart';

/// Safety Settings data model
class SafetySettings {
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
      {required this.disroptiveSettings,
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
    disroptiveSettings = json['badCommentAutoCollapse'];
    blocked = json['blocked'];
    showUnInSearch = json['showInSearch'];
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
