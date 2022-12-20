import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/model/email_settings.dart';

import '../../data/repository/email_settings_repo.dart';

part 'email_settings_state.dart';

class EmailSettingsCubit extends Cubit<EmailSettingsState> {
  EmailSettingsCubit(this.emailSettingsRepository)
      : super(EmailSettingsInitial());

  final EmailSettingsRepository emailSettingsRepository;
  EmailSettings? _emailSettings;

  void getEmailSettings() {
    if (isClosed) return;
    emit(EmailSettingsLoading());

    emailSettingsRepository.getEmailSettings().then(
      (value) {
        _emailSettings = value;
        emit(EmailSettingsLoaded(_emailSettings!));
      },
    );
  }

  void updateEmailSettings(EmailSettings updatedEmailSettings) {
    if (isClosed) return;
    _emailSettings = updatedEmailSettings;
    emailSettingsRepository.updateEmailSettings(updatedEmailSettings);
    emit(EmailSettingsUpdated());
    emit(EmailSettingsLoaded(_emailSettings!));
  }
}

// class AccountSettingsCubit extends Cubit<AccountSettingsState> {
//   final AccountSettingsRepository accountSettingsRepository;
//   AccountSettingsModel? accountSettings;
//   AccountSettingsCubit(this.accountSettingsRepository)
//       : super(AccountSettingsInitial());
//   // gets characters from repository and sends it to the state (ui)
//   void getAccountSettings() {
//     accountSettingsRepository.getAccountSettings().then((accountSettings) {
//       // start the state existing in characters_state
//       // here you sent characters list to characters loaded state
//       emit(AccountSettingsLoaded(accountSettings));
//       this.accountSettings = accountSettings;
//     });
//   }

//   void updateAccountSettings(AccountSettingsModel newAccSettings) {
//     // emit(AccountSettingsLoading());
//     accountSettings = newAccSettings;
//     accountSettingsRepository.updateAccountSettings(newAccSettings);
//     emit(AccountSettingsLoaded(accountSettings!));
//   }
// }
