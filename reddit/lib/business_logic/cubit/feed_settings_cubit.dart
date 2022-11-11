// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:reddit/data/model/user_preferences_feed_setting_model.dart';
import 'package:reddit/data/repository/user_preferences_feed_setting_repository.dart';

part 'feed_settings_state.dart';

/// Cubit for Reciveng data from Repositry.
///
/// Then Sending it to UI.
class FeedSettingsCubit extends Cubit<FeedSettingsState> {
  final UserPreferencesFeedSettingRepository feedSettingsRepository;

  ///Data Status from Web Server.
  ///
  ///200
  ///201	-->> The preferences updated successfully.
  ///401	-->> Unautherized.
  late int status;

  FeedSettingsCubit(this.feedSettingsRepository) : super(FeedSettingsInitial());

  /// This cubit (feed_settings_cubit) calls this function as it in Repositry.
  int updateFeedSettings(bool adultContent, bool autoPlayMedia) {
    UserPreferencesFeedSettingModel newFeedSettings =
        UserPreferencesFeedSettingModel(
      adultContent: adultContent,
      autoPlayMedia: autoPlayMedia,
    );
    feedSettingsRepository.updateFeedSettings(newFeedSettings).then((status) {
      emit(FeedSettingsUpdated(state: status));
      this.status = status;
    });

    return status;
  }
}
