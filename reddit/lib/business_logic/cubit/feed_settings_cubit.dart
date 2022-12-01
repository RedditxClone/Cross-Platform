// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:reddit/data/model/feed_setting_model.dart';
import 'package:reddit/data/repository/feed_setting_repository.dart';

part 'feed_settings_state.dart';

/// Cubit for Reciveng data from Repositry.
///
/// Then Sending it to UI.
class FeedSettingsCubit extends Cubit<FeedSettingsState> {
  final FeedSettingRepository feedSettingsRepository;
  late FeedSettingModel feedSettings;

  FeedSettingsCubit(this.feedSettingsRepository) : super(FeedSettingsInitial());

  /// Gets feed settings data from repository.
  /// Emits the corresponding state for UI.
  void getFeedSettings() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    feedSettingsRepository.getFeedSettings().then((feedSettings) {
      // start the state existing in feed_setting_state
      // here you sent feedSettings list to feedSettings loaded state
      emit(FeedSettingsLoaded(feedSettings));
      this.feedSettings = feedSettings;
    });
  }

  /// Send data to repository to prepare the PATCH request.
  /// Emits the corresponding state for UI.
  void updateFeedSettings(FeedSettingModel newFeedSettings) {
    // To avoid state error when you leave the settings page
    if (isClosed) return;

    feedSettings = newFeedSettings;
    feedSettingsRepository.updateFeedSettings(newFeedSettings);
    emit(FeedSettingsLoaded(feedSettings));
  }
}
