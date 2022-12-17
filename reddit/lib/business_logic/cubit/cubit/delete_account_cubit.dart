import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final AccountSettingsRepository accountSettingsRepository;
  DeleteAccountCubit(this.accountSettingsRepository)
      : super(DeleteAccountInitial());

  /// This function emits:
  /// state [AccountDeleted] after successfully deleting the account.
  /// state [AccountDeleteError] if an error occurs.
  /// This function calls the function [AccountSettingsRepository.deleteAccount] to prepare the DELETE request.
  void deleteAccount() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    accountSettingsRepository.deleteAccount().then((value) {
      if (value == 200) {
        emit(AccountDeleted());
      } else {
        emit(AccountDeleteError(value));
      }
    });
  }
}
