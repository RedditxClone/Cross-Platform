part of 'email_settings_bloc.dart';

@immutable
abstract class EmailSettingsState {}

class EmailSettingsInitial extends EmailSettingsState {}

class EmailSettingsLoaded extends EmailSettingsState {
  final List<bool> initialValues;

  EmailSettingsLoaded(this.initialValues);
}

class EmailSettingsChanged extends EmailSettingsState {}
