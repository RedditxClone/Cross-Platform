import 'dart:convert';

import 'package:reddit/data/model/change_password_model.dart';

import '../web_services/account_settings_web_services.dart';
import '../model/account_settings_model.dart';

class AccountSettingsRepository {
  final AccountSettingsWebServices accountSettingsWebServices;

  AccountSettingsRepository(this.accountSettingsWebServices);

  /// Gets settings from web services class and maps it to the model.
  /// The cubit (account_settings_cubit) calls this function
  Future<AccountSettingsModel> getAccountSettings() async {
    final accSettings = await accountSettingsWebServices.getAccountSettings();
    print("Account settings from repo:");
    print("$accSettings");
    return AccountSettingsModel.fromJson(jsonDecode(accSettings));
  }

  /// Map new settings to Json and send it to web services class to make the PATCH request.
  /// The cubit (account_settings_cubit) calls this function
  Future<void> updateAccountSettings(
      AccountSettingsModel newAccSettings) async {
    Map<String, dynamic> jsonMap = newAccSettings.toJson();
    await accountSettingsWebServices.updateAccountSettings(jsonMap);
  }

  /// Map new settings to Json and send it to web services class to make the PATCH request.
  /// The cubit (account_settings_cubit) calls this function
  Future<int> changePassword(ChangePasswordModel changePasswordModel) async {
    Map<String, dynamic> jsonMap = changePasswordModel.toJson();
    return await accountSettingsWebServices.changePassword(jsonMap);
  }
}
