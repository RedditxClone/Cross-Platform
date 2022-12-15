part of 'safety_settings_cubit.dart';

@immutable

/// Abstract class that is the parent of all inherited children (states)
abstract class SafetySettingsState {}

class SettingsInitial extends SafetySettingsState {}

/// Emitted only once in the initial build of the safety settings page.
class SafetySettingsAvailable extends SafetySettingsState {
  final SafetySettings settings;
  SafetySettingsAvailable(this.settings);
}

/// Emitted on every update in the safety settings page.
class SafetySettingsChanged extends SafetySettingsState {
  final SafetySettings settings;
  SafetySettingsChanged(this.settings);
}

/// Emitted on every block/unblock in the safety settings page.
class BlockListUpdated extends SafetySettingsState {
  final SafetySettings settings;
  final String name;
  BlockListUpdated(this.settings, this.name);
}

class ErrorOccured extends SafetySettingsState {}
