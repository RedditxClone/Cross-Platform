part of 'email_settings_cubit.dart';
@immutable
abstract class EmailSettingsState {
  final EmailSettings emailSettings;
  const EmailSettingsState(this.emailSettings);
}

class EmailSettingsInitial extends EmailSettingsState {
  const EmailSettingsInitial(super.emailSettings);
}

class EmailSettingsLoaded extends EmailSettingsState {
  const EmailSettingsLoaded(emailSettings) : super(emailSettings);
}

class EmailSettingsUpdated extends EmailSettingsState {
  const EmailSettingsUpdated(emailSettings) : super(emailSettings);
}
