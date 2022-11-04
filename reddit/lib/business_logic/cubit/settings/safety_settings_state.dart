part of 'safety_settings_cubit.dart';

@immutable
abstract class SafetySettingsState {}

class SettingsInitial extends SafetySettingsState {}

class SafetySettingsAvailable extends SafetySettingsState {
  final SafetySettings settings;
  SafetySettingsAvailable(this.settings);
}

class SafetySettingsChanged extends SafetySettingsState {
  final SafetySettings settings;
  SafetySettingsChanged(this.settings);
}
