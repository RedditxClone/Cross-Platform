import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
import 'package:reddit/data/model/safety_user_settings.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';
import 'package:reddit/presentation/screens/safety_settings_web.dart';

class MockAccountSettingsWebService extends Mock
    implements SafetySettingsWebServices {}

class MockAccountSettingsCubit extends MockCubit<SafetySettingsState>
    implements SafetySettingsCubit {}

void main() async {
  late MockAccountSettingsWebService mockAccountSettingsWebService;
  late SafetySettingsRepository accountSettingsRepository;
  late SafetySettingsCubit accountSettingsCubit;
  late MockAccountSettingsCubit mockAccountSettingsCubit;
  const String settingsFromWebServices = '''{
    "profile":
        "https://image.shutterstock.com/mosaic_250/2780032/1854697390/stock-photo-head-shot-young-attractive-businessman-in-glasses-standing-in-modern-office-pose-for-camera-1854697390.jpg",
    "cover":
        "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/1-mcway-waterfall-with-small-cove-ingmar-wesemann.jpg",
    "nsfw": true,
    "displayName": "Markos",
    "about": "I am a computer engineer student",
    "allowPeopleToFollowYou": false,
    "activeInCommunitiesVisibility": true,
    "contentVisibility": false,
    "disroptiveSettings": "MEDIUM",
    "showUnInSearch": true,
    "blocked": ["@_Mark1"],
    "personalizeAllOfReddit": false,
    "personalizeAds_information": true,
    "personalizeAds_yourActivity": false,
    "personalizeRec_generalLocation": true,
    "personalizeRec_ourPartners": true,
    "useTwoFactorAuthentication": false
  }''';
  const Map<String, String> patchResponse = {
    'cover':
        'https://images.unsplash.com/photo-1504805572947-34fad45aed93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y292ZXIlMjBwaG90b3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'profile':
        'https://preview.keenthemes.com/metronic-v4/theme_rtl/assets/pages/media/profile/profile_user.jpg'
  };
  final settingsFromRepository = SafetySettings(
      profile:
          'https://image.shutterstock.com/mosaic_250/2780032/1854697390/stock-photo-head-shot-young-attractive-businessman-in-glasses-standing-in-modern-office-pose-for-camera-1854697390.jpg',
      cover:
          'https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/1-mcway-waterfall-with-small-cove-ingmar-wesemann.jpg',
      displayName: 'Markos',
      about: 'I am a computer engineer student',
      nsfw: true,
      allowPeopleToFollowYou: false,
      activeInCommunitiesVisibility: true,
      contentVisibility: false,
      disroptiveSettings: 'MEDIUM',
      blocked: ['@_Mark1'],
      showUnInSearch: true,
      personalizeAllOfReddit: false,
      personalizeAdsInformation: true,
      personalizeAdsYourActivity: false,
      personalizeRecGeneralLocation: true,
      personalizeRecOurPartners: true,
      useTwoFactorAuthentication: false);

  group("State test", () {
    setUp(() {
      mockAccountSettingsWebService = MockAccountSettingsWebService();
      accountSettingsRepository =
          SafetySettingsRepository(mockAccountSettingsWebService);
      accountSettingsCubit = SafetySettingsCubit(accountSettingsRepository);
    });
    // Calling getAccountSettings() function returns the correct state
    // AccountSettingsLoading means that the request is sent and we are waiting for the response
    // AccountSettingsLoaded means that the response is received and UI is built based on this responce
    blocTest<SafetySettingsCubit, SafetySettingsState>(
      'Settings loaded state is emitted correctly after getting settings data from server',
      setUp: () {
        when(() => mockAccountSettingsWebService.getUserSettings()).thenAnswer(
          (_) async => settingsFromWebServices,
        );
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (SafetySettingsCubit cubit) => cubit.getUserSettings(),
      expect: () => [isA<SafetySettingsAvailable>()],
    );
    blocTest<SafetySettingsCubit, SafetySettingsState>(
      'Settings loaded state is emitted correctly after updating settings',
      setUp: () {
        when(() => mockAccountSettingsWebService.updatePrefs({'cover': ''}))
            .thenAnswer(
                (_) async => "{\"cover\": \"${patchResponse['cover']!}\"}");
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (SafetySettingsCubit cubit) =>
          cubit.changeCoverphoto(settingsFromRepository, ''),
      expect: () => [isA<SafetySettingsChanged>()],
    );
  });
  // Test if mapping from Json to model is correct
  group('Model test', () {
    test('Model is generated correctly', () {
      expect(
        SafetySettings.fromjson(jsonDecode(settingsFromWebServices)),
        settingsFromRepository,
      );
    });
  });

  // Check if the data shown on UI is the same as the data comming from server.
  // Check if update settings function is called when updating any value from UI.
  group("UI data matches response data", () {
    setUp(() {
      mockAccountSettingsCubit = MockAccountSettingsCubit();
      when(() => mockAccountSettingsCubit.state)
          .thenReturn(SafetySettingsAvailable(settingsFromRepository));
    });
    testWidgets('Account settings screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<SafetySettingsCubit>(
              create: (context) => mockAccountSettingsCubit,
            )
          ],
          child: const MaterialApp(home: SafetySettingsWeb()),
        ),
      );
      // Allow people to follow you toggle is displayed correctly
      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key("showUnInSearch") &&
              widget.value == settingsFromRepository.showUnInSearch),
          findsOneWidget);
      // Update settings function is called after pressing on the switch
      await tester.ensureVisible(find.byKey(const Key("showUnInSearch")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("showUnInSearch")));
      verify(() => mockAccountSettingsCubit.updateSettings(
          {"showUnInSearch": settingsFromRepository.showUnInSearch})).called(1);
    });
  });
}
