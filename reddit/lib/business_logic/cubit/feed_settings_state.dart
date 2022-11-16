part of 'feed_settings_cubit.dart';

@immutable
abstract class FeedSettingsState {}

class FeedSettingsInitial extends FeedSettingsState {}

/// Feed settings retrieved successfully from server and ready to be displayed
class FeedSettingsLoaded extends FeedSettingsState {
  final FeedSettingModel feedSettings;

  FeedSettingsLoaded(this.feedSettings);
}
