import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/account_settings_model.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';

part 'account_settings_state.dart';

class AccountSettingsCubit extends Cubit<AccountSettingsState> {
  final AccountSettingsRepository accountSettingsRepository;
  AccountSettingsModel? accountSettings;
  AccountSettingsCubit(this.accountSettingsRepository)
      : super(AccountSettingsInitial());
  // gets characters from repository and sends it to the state (ui)
  void getAccountSettings() {
    emit(AccountSettingsLoading());
    accountSettingsRepository.getAccountSettings().then((accountSettings) {
      // start the state existing in characters_state
      // here you sent characters list to characters loaded state
      emit(AccountSettingsLoaded(accountSettings));
      this.accountSettings = accountSettings;
    });
  }

  void updateAccountSettings(AccountSettingsModel newAccSettings) {
    // emit(AccountSettingsLoading());
    accountSettings = newAccSettings;
    accountSettingsRepository.updateAccountSettings(newAccSettings);
    emit(AccountSettingsLoaded(accountSettings!));
  }
}
