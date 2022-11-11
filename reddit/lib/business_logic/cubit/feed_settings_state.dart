part of 'feed_settings_cubit.dart';

@immutable
abstract class FeedSettingsState {}

class FeedSettingsInitial extends FeedSettingsState {}

class FeedSettingsUpdated extends FeedSettingsState {
  final int state;
  FeedSettingsUpdated({
    required this.state,
  });
}
