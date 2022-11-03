import 'dart:convert';

import 'package:reddit/data/model/change_password_model.dart';

import '../web_services/account_settings_web_services.dart';
import '../model/account_settings_model.dart';

class AccountSettingsRepository {
  final AccountSettingsWebServices accountSettingsWebServices;

  AccountSettingsRepository(this.accountSettingsWebServices);
  // Gets settings from webservices class and maps it to the model,
  // the cubit (account_settings_cubit) calls this function
  Future<AccountSettingsModel> getAccountSettings() async {
    final accSettings = await accountSettingsWebServices.getAccountSettings();
    print("Account settings from repo:");
    print("$accSettings");
    return AccountSettingsModel.fromJson(jsonDecode(accSettings));
  }

  Future<void> updateAccountSettings(
      AccountSettingsModel newAccSettings) async {
    Map<String, dynamic> jsonMap = newAccSettings.toJson();
    await accountSettingsWebServices.updateAccountSettings(jsonMap);
  }

  Future<int> changePassword(ChangePasswordModel changePasswordModel) async {
    Map<String, dynamic> jsonMap = changePasswordModel.toJson();
    return await accountSettingsWebServices.changePassword(jsonMap);
  }
}
