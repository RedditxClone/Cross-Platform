part of 'safety_settings_cubit.dart';

@immutable
abstract class SafetySettingsState {}

class SettingsInitial extends SafetySettingsState {}

// emitted on every update in the initial build of the safety settings page
class SafetySettingsAvailable extends SafetySettingsState {
  final SafetySettings settings;
  SafetySettingsAvailable(this.settings);
}

// emitted on every update in the safety settings page
class SafetySettingsChanged extends SafetySettingsState {
  final SafetySettings settings;
  SafetySettingsChanged(this.settings);
}

// emitted on every update in the safety settings page
class BlockListUpdated extends SafetySettingsState {
  final SafetySettings settings;
  final String name;
  BlockListUpdated(this.settings, this.name);
}
