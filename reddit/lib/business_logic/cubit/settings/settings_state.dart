part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

/// Abstract class that is the parent of all inherited children (states)
class SettingsInitial extends SettingsState {}

/// Emitted only once in the initial build of the profile settings page.
class SettingsAvailable extends SettingsState {
  final ProfileSettings settings;
  SettingsAvailable(this.settings);
}

/// Emitted on every update in the profile settings page.
class SettingsChanged extends SettingsState {
  final ProfileSettings settings;
  SettingsChanged(this.settings);
}

/// Emitted on every update in the profile settings page.
class PhotoChanged extends SettingsState {
  final String imageUrl;
  PhotoChanged(this.imageUrl);
}
