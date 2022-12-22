import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/settings/safety_settings_cubit.dart';
import 'package:reddit/data/model/safety_user_settings.dart';
import 'package:reddit/data/repository/safety_settings_repository.dart';
import 'package:reddit/data/web_services/safety_settings_web_services.dart';

class MockSafetySettingsWebService extends Mock
    implements SafetySettingsWebServices {}

class MockSafetySettingsCubit extends MockCubit<SafetySettingsState>
    implements SafetySettingsCubit {}

void main() async {
  late MockSafetySettingsWebService mockSafetySettingsWebService;
  late SafetySettingsRepository safetySettingsRepository;
  late SafetySettingsCubit safetySettingsCubit;
  const settingsFromWebServices = {
    "badCommentAutoCollapse": "MEDIUM",
    "showInSearch": true,
    "personalizeAllOfReddit": false,
    "personalizeAdsInformation": true,
    "personalizeAdsYourActivity": false,
    "personalizeRecGeneralLocation": true,
    "personalizeRecOurPartners": true,
    "useTwoFactorAuthentication": false
  };
  final safetySettingsFromRepository = SafetySettings(
      disroptiveSettings: 'MEDIUM',
      blocked: [],
      showUnInSearch: true,
      personalizeAllOfReddit: false,
      personalizeAdsInformation: true,
      personalizeAdsYourActivity: false,
      personalizeRecGeneralLocation: true,
      personalizeRecOurPartners: true,
      useTwoFactorAuthentication: false);

  group("State test", () {
    setUp(() {
      mockSafetySettingsWebService = MockSafetySettingsWebService();
      safetySettingsRepository =
          SafetySettingsRepository(mockSafetySettingsWebService);
      safetySettingsCubit = SafetySettingsCubit(safetySettingsRepository);
    });

    /// Calling getAccountSettings() function returns the correct state
    /// SafetySettingsAvailable means that the response is received and UI is built based on this responce
    blocTest<SafetySettingsCubit, SafetySettingsState>(
      'Settings loaded state is emitted correctly after getting settings data from server',
      setUp: () {
        when(() => mockSafetySettingsWebService.getUserSettings()).thenAnswer(
          (_) async => settingsFromWebServices,
        );
        when(() => mockSafetySettingsWebService.getBlockedUsers()).thenAnswer(
          (_) async => [
            {
              "_id": "1",
              "blocked": {"_id": "0", "username": "dummy", "profilePhoto": ""}
            }
          ],
        );
      },
      build: () {
        return safetySettingsCubit;
      },
      act: (SafetySettingsCubit cubit) => cubit.getUserSettings(),
      expect: () => [isA<SafetySettingsAvailable>()],
    );
    blocTest<SafetySettingsCubit, SafetySettingsState>(
      'Settings loaded state is emitted correctly after updating settings',
      setUp: () {
        when(() => mockSafetySettingsWebService
                .updatePrefs({'disroptiveSettings': 'MEDIUM'}))
            .thenAnswer((_) async => 200);
      },
      build: () {
        return safetySettingsCubit;
      },
      act: (SafetySettingsCubit cubit) => cubit.updateSettings(
          safetySettingsFromRepository, {"disroptiveSettings": "MEDIUM"}),
      expect: () => [isA<SafetySettingsChanged>()],
    );
  });

  /// Test if mapping from Json to model is correct
  group('Model test', () {
    test('Model is generated correctly', () {
      expect(
        SafetySettings.fromjson(settingsFromWebServices),
        safetySettingsFromRepository,
      );
    });
  });
}
