import 'dart:convert';

import 'package:reddit/data/model/change_password_model.dart';

import '../web_services/account_settings_web_services.dart';
import '../model/account_settings_model.dart';

class AccountSettingsRepository {
  final AccountSettingsWebServices accountSettingsWebServices;

  AccountSettingsRepository(this.accountSettingsWebServices);

  /// Returns [AccountSettingsModel] object that contains the user's account settings
  /// after getting it from [AccountSettingsWebServices] and mapping it to the model.
  Future<AccountSettingsModel> getAccountSettings() async {
    final accSettings = await accountSettingsWebServices.getAccountSettings();
    print("Account settings from repo:");
    print("$accSettings");
    return AccountSettingsModel.fromJson(accSettings);
  }

  /// Map new settings to Json and send it to web services class to make the PATCH request.
  /// [newAccSettings] : The account settings model that will be updated.
  Future<void> updateAccountSettings(
      AccountSettingsModel newAccSettings) async {
    Map<String, dynamic> jsonMap = newAccSettings.toJson();
    await accountSettingsWebServices.updateAccountSettings(jsonMap);
  }

  /// Map new password model to Json and send it to web services [AccountSettingsWebServices.changePassword] to make the PATCH request.
  /// Returns [int] value the status code of the PATCH request:
  /// `200` : Password changed successfully
  /// `403` : Wrong password
  /// `401` : Unauthorized
  Future<int> changePassword(ChangePasswordModel changePasswordModel) async {
    Map<String, dynamic> jsonMap = changePasswordModel.toJson();
    return await accountSettingsWebServices.changePassword(jsonMap);
  }

  /// Calls web services [AccountSettingsWebServices.deleteAccount] to make the DELETE request.
  /// Returns [int] value the status code of the DELETE request:
  /// `200` : Account deleted successfully
  /// `401` : Unauthorized
  Future<int> deleteAccount() async {
    return await accountSettingsWebServices.deleteAccount();
  }
}
