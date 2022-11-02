import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';

class MockAccountSettingsWebService extends Mock
    implements SettingsWebServices {}

class MockAccountSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

void main() async {
  late MockAccountSettingsWebService mockAccountSettingsWebService;
  late SettingsRepository accountSettingsRepository;
  late SettingsCubit accountSettingsCubit;

  final Map<String, dynamic> settingsFromWebServices = {
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
  };
  const Map<String, String> patchResponse = {
    'cover':
        'https://images.unsplash.com/photo-1504805572947-34fad45aed93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y292ZXIlMjBwaG90b3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'profile':
        'https://preview.keenthemes.com/metronic-v4/theme_rtl/assets/pages/media/profile/profile_user.jpg'
  };
  final settingsFromRepository = Settings(
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
          SettingsRepository(mockAccountSettingsWebService);
      accountSettingsCubit = SettingsCubit(accountSettingsRepository);
    });
    // Calling getAccountSettings() function returns the correct state
    // AccountSettingsLoading means that the request is sent and we are waiting for the response
    // AccountSettingsLoaded means that the response is received and UI is built based on this responce
    blocTest<SettingsCubit, SettingsState>(
      'Settings loaded state is emitted correctly after getting settings data from server',
      setUp: () {
        when(() => mockAccountSettingsWebService.getUserSettings()).thenAnswer(
          (_) async => settingsFromWebServices,
        );
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (SettingsCubit cubit) => cubit.getUserSettings(),
      expect: () => [isA<SettingsAvailable>()],
    );
    blocTest<SettingsCubit, SettingsState>(
      'Settings loaded state is emitted correctly after updating settings',
      setUp: () {
        when(() => mockAccountSettingsWebService.updatePrefs({'cover': ''}))
            .thenAnswer(
                (_) async => "{\"cover\": \"${patchResponse['cover']!}\"}");
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (SettingsCubit cubit) =>
          cubit.changeCoverphoto(settingsFromRepository, ''),
      expect: () => [isA<SettingsChanged>()],
    );
  });
  // Test if mapping from Json to model is correct
  group('Model test', () {
    test('Model is generated correctly', () {
      expect(
        Settings.fromjson(settingsFromWebServices),
        settingsFromRepository,
      );
    });
  });
}
