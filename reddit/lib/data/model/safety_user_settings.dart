import 'package:flutter/foundation.dart';

/// This class represents the data model of safety settings
class SafetySettings {
  late String disroptiveSettings;
  List<dynamic> blocked = [];
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

  /// [json] : [Map] of the user safety settings that was returned by the API.
  ///
  /// Returns [SafetySettings] object that contains the data of [json].
  SafetySettings.fromjson(Map<String, dynamic> json) {
    disroptiveSettings = json['badCommentAutoCollapse'];
    showUnInSearch = json['showInSearch'];
    personalizeAllOfReddit = json['personalizeAllOfReddit'];
    personalizeAdsInformation = json['personalizeAdsInformation'];
    personalizeAdsYourActivity = json['personalizeAdsYourActivity'];
    personalizeRecGeneralLocation = json['personalizeRecGeneralLocation'];
    personalizeRecOurPartners = json['personalizeRecOurPartners'];
    useTwoFactorAuthentication = json['useTwoFactorAuthentication'];
  }

  /// [other] : is a [SafetySettings] object that we want to compare with
  ///
  /// Returns a [bool] that represent the equivilance of two [SafetySettings] objects
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
