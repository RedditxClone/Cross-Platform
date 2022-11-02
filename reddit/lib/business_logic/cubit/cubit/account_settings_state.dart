part of 'account_settings_cubit.dart';

@immutable
abstract class AccountSettingsState {}

class AccountSettingsInitial extends AccountSettingsState {}

class AccountSettingsLoading extends AccountSettingsState {}

class AccountSettingsLoaded extends AccountSettingsState {
  final AccountSettingsModel accSettings;

  AccountSettingsLoaded(this.accSettings);
}

class WrongPassword extends AccountSettingsState {}

class PasswordUpdatedSuccessfully extends AccountSettingsState {}
