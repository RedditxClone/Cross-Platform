class AccountSettingsModel {
  late String countryCode;
  late bool enableFollowers;

  AccountSettingsModel.fromJson(Map<String, dynamic> json) {
    print("Account settings from model:");
    print("$json");
    countryCode = json['country_code'];
    enableFollowers = json['enable_followers'];
  }
}
