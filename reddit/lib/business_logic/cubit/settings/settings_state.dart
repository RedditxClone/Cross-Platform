part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsAvailable extends SettingsState {
  final Settings settings;

  SettingsAvailable(this.settings);
}
