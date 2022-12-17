import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/change_password_model.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AccountSettingsRepository accountSettingsRepository;
  ChangePasswordCubit(this.accountSettingsRepository)
      : super(ChangePasswordInitial());

  /// [changePasswordModel] : The password model that will be updated.
  /// This function emits:
  /// state [PasswordUpdatedSuccessfully] after successfully updating the password.
  /// state [WrongPassword] if the old password is wrong.
  /// This function calls the function [AccountSettingsRepository.changePassword] to prepare the PATCH request.
  void changePassword(ChangePasswordModel changePasswordModel) {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
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
