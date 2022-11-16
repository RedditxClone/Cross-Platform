import 'dart:convert';
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
          (_) async => {
            "blocked": ["mark"]
          },
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

  /// Check if the data shown on UI is the same as the data comming from server.
  /// Check if update settings function is called when updating any value from UI.
  // group("UI data matches response data", () {
  //   setUp(() {
  //     mockSafetySettingsCubit = MockSafetySettingsCubit();
  //     when(() => mockSafetySettingsCubit.state)
  //         .thenReturn(SafetySettingsAvailable(safetySettingsFromRepository));
  //   });
  //   testWidgets('Safety settings screen', (WidgetTester tester) async {
  //     await tester.pumpWidget(
  //       MultiBlocProvider(
  //         providers: [
  //           BlocProvider<SafetySettingsCubit>(
  //             create: (context) => mockSafetySettingsCubit,
  //           )
  //         ],
  //         child: const MaterialApp(
  //             home: Scaffold(
  //                 body: SingleChildScrollView(child: SafetySettingsWeb()))),
  //       ),
  //     );
  //     // Allow people to follow you toggle is displayed correctly
  //     expect(
  //         find.byWidgetPredicate((widget) =>
  //             widget is SwitchListTile &&
  //             widget.key == const Key("showUnInSearch") &&
  //             widget.value == safetySettingsFromRepository.showUnInSearch),
  //         findsOneWidget);
  //     // Update settings function is called after pressing on the switch
  //     await tester.ensureVisible(find.byKey(const Key("showUnInSearch")));
  //     await tester.pumpAndSettle();
  //     await tester.tap(find.byKey(const Key("showUnInSearch")));
  //     verify(() => mockSafetySettingsCubit.updateSettings(
  //             safetySettingsFromRepository,
  //             {"showInSearch": safetySettingsFromRepository.showUnInSearch}))
  //         .called(1);
  //   });
  // });
}
