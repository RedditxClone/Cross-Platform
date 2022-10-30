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
    return AccountSettingsModel.fromJson(accSettings);
  }

  Future<void> updateAccountSettings(
      AccountSettingsModel newAccSettings) async {
    Map<String, dynamic> jsonMap = newAccSettings.toJson();
    await accountSettingsWebServices.updateAccountSettings(jsonMap);
  }
}
