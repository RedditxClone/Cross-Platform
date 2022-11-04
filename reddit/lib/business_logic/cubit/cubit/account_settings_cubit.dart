import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/account_settings_model.dart';
import 'package:reddit/data/model/change_password_model.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';

part 'account_settings_state.dart';

class AccountSettingsCubit extends Cubit<AccountSettingsState> {
  final AccountSettingsRepository accountSettingsRepository;
  AccountSettingsModel? accountSettings;
  AccountSettingsCubit(this.accountSettingsRepository)
      : super(AccountSettingsInitial());

  /// Gets account settings data from repository.
  /// Emits the corresponding state for UI.
  void getAccountSettings() {
    emit(AccountSettingsLoading());
    accountSettingsRepository.getAccountSettings().then((accountSettings) {
      // start the state existing in characters_state
      // here you sent characters list to characters loaded state
      emit(AccountSettingsLoaded(accountSettings));
      this.accountSettings = accountSettings;
    });
  }

  /// Send data to repository to prepare the PATCH request.
  /// Emits the corresponding state for UI.
  void updateAccountSettings(AccountSettingsModel newAccSettings) {
    // emit(AccountSettingsLoading());
    accountSettings = newAccSettings;
    accountSettingsRepository.updateAccountSettings(newAccSettings);
    emit(AccountSettingsLoaded(accountSettings!));
  }

  /// Send data to repository to prepare the PATCH request.
  /// Emits the corresponding state for UI.
  void changePassword(ChangePasswordModel changePasswordModel) {
    accountSettingsRepository.changePassword(changePasswordModel).then((value) {
      if (value == 200) {
        // emit updated successfully state
        emit(PasswordUpdatedSuccessfully());
      } else if (value == 403) {
        // emit Wrong password state
        emit(WrongPassword());
      }
    });
  }
}
