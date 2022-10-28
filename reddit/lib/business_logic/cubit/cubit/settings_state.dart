part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsAvailable extends SettingsState {
  final ProfileSettings profileSettings;

  SettingsAvailable(this.profileSettings);
}
