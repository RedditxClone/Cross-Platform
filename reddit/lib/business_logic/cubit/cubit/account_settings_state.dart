part of 'account_settings_cubit.dart';

@immutable
abstract class AccountSettingsState {}

class AccountSettingsInitial extends AccountSettingsState {}

/// Shows a loading indicator
class AccountSettingsLoading extends AccountSettingsState {}

/// Account settings retrieved successfully from server and ready to be displayed
class AccountSettingsLoaded extends AccountSettingsState {
  final AccountSettingsModel accSettings;

  AccountSettingsLoaded(this.accSettings);
}
