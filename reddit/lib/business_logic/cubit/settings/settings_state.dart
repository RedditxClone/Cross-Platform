part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsAvailable extends SettingsState {
  final ProfileSettings settings;
  SettingsAvailable(this.settings);
}

class SettingsChanged extends SettingsState {
  final ProfileSettings settings;
  SettingsChanged(this.settings);
}

// class ChangeCoverPhoto extends SettingsState {
//   final String coverPhoto;
//   ChangeCoverPhoto(this.coverPhoto);
// }

// class UpdateBooleans extends SettingsState {
//   final bool val;
//   UpdateBooleans(this.val);
// }
