import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/account_settings_model.dart';
import 'package:reddit/data/model/change_password_model.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';

part 'account_settings_state.dart';

/// This class is responsible for getting - updating account settings page on mobile or web.
class AccountSettingsCubit extends Cubit<AccountSettingsState> {
  final AccountSettingsRepository accountSettingsRepository;
  AccountSettingsModel? accountSettings;
  AccountSettingsCubit(this.accountSettingsRepository)
      : super(AccountSettingsInitial());

  /// This function emits:
  /// state [AccountSettingsLoading] to indicate that data is loading from the server.
  /// state [AccountSettingsLoaded] when account settings is loaded successfully.
  /// This function is called inside the initState of the account settings screens.
  /// This function calls the function [AccountSettingsRepository.getAccountSettings] to get the user's account settings.
  void getAccountSettings() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    emit(AccountSettingsLoading());
    accountSettingsRepository.getAccountSettings().then((accountSettings) {
      // start the state existing in characters_state
      // here you sent characters list to characters loaded state
      emit(AccountSettingsLoaded(accountSettings));
      this.accountSettings = accountSettings;
    });
  }

  /// [newAccSettings] : The account settings model that will be updated.
  /// This function emits state [AccountSettingsLoaded] after successfully updating the account settings.
  /// This function calls the function [AccountSettingsRepository.updateAccountSettings] to prepare the PATCH request.
  void updateAccountSettings(AccountSettingsModel newAccSettings) {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    // emit(AccountSettingsLoading());
    accountSettings = newAccSettings;
    accountSettingsRepository.updateAccountSettings(newAccSettings);
    emit(AccountSettingsLoaded(accountSettings!));
  }
}
