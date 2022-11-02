part of 'email_settings_cubit.dart';

@immutable
abstract class EmailSettingsState {}

class EmailSettingsInitial extends EmailSettingsState {}

class EmailSettingsLoading extends EmailSettingsState {}

class EmailSettingsLoaded extends EmailSettingsState {
  final EmailSettings emailSettings;
  EmailSettingsLoaded(this.emailSettings);
}
