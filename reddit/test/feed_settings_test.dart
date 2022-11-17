import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/feed_settings_cubit.dart';
import 'package:reddit/data/model/feed_setting_model.dart';
import 'package:reddit/data/repository/feed_setting_repository.dart';
import 'package:reddit/data/web_services/feed_setting_web_services.dart';

class MockFeedSettingsWebService extends Mock
    implements FeedSettingWebServices {}

class MockFeedSettingsCubit extends MockCubit<FeedSettingsState>
    implements FeedSettingsCubit {}

void main() async {
  late MockFeedSettingsWebService mockFeedSettingsWebService;
  late FeedSettingRepository feedSettingsRepository;
  late FeedSettingsCubit feedSettingsCubit;
  const String settingsFromWebServices = '''{
  "adultContent": true,
  "autoPlayMedia": false
  }''';
  final settingsFromRepository =
      FeedSettingModel(adultContent: true, autoPlayMedia: false);

  group("State test", () {
    setUp(() {
      mockFeedSettingsWebService = MockFeedSettingsWebService();
      feedSettingsRepository = FeedSettingRepository(
          feedSettingsWebServices: mockFeedSettingsWebService);
      feedSettingsCubit = FeedSettingsCubit(feedSettingsRepository);
    });
    // Calling getfeedSettings() function returns the correct state
    // feedSettingsLoading means that the request is sent and we are waiting for the response
    // feedSettingsLoaded means that the response is received and UI is built based on this responce
    blocTest<FeedSettingsCubit, FeedSettingsState>(
      'Settings loaded state is emitted correctly after getting settings data from server',
      setUp: () {
        when(() => mockFeedSettingsWebService.getFeedSettings()).thenAnswer(
          (_) async => settingsFromWebServices,
        );
      },
      build: () {
        return feedSettingsCubit;
      },
      act: (FeedSettingsCubit cubit) => cubit.getFeedSettings(),
      expect: () => [isA<FeedSettingsLoaded>()],
    );
    blocTest<FeedSettingsCubit, FeedSettingsState>(
      'Settings loaded state is emitted correctly after updating settings',
      setUp: () {
        when(() => mockFeedSettingsWebService.updateFeedSetting(
            jsonDecode(settingsFromWebServices))).thenAnswer((_) async => 200);
      },
      build: () {
        return feedSettingsCubit;
      },
      act: (FeedSettingsCubit cubit) =>
          cubit.updateFeedSettings(settingsFromRepository),
      expect: () => [isA<FeedSettingsLoaded>()],
    );
    // Test if mapping from Json to model is correct
    group('Model test', () {
      test('feed Aettings Model is generated correctly', () {
        expect(
          FeedSettingModel.fromJson(jsonDecode(settingsFromWebServices)),
          settingsFromRepository,
        );
      });
    });
  });
}
