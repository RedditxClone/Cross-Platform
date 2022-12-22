import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
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
  File file = File('/test/asd.jpg');
  User? testUser;
  ProfileSettings? settingsFromRepository;
  Map<String, String>? patchResponse;
  Map<String, dynamic>? settingsFromWebServices;
  setUp(() {
    testUser = User.fromJson({
      "_id": "2",
      "profilePhoto": "",
      "coverPhoto": "",
      "username": "ahmed123",
      "createdAt": "2022-12-17T20:16:17.143Z",
      "isBlocked": false,
      "isFollowed": true,
      "about": "",
      "displayName": "",
      "socialLinks": [],
      "nsfw": false
    });
    settingsFromWebServices = {
      "coverPhoto": "",
      "profilePhoto": "",
      "displayName": "Markos",
      "about": "i am mark yasser, computer eng student",
      "nsfw": true,
      "allowFollow": true,
      "contentVisibility": true,
      "activeInCommunitiesVisibility": true,
    };
    settingsFromRepository = ProfileSettings(
        profile: '',
        cover: '',
        displayName: 'Markos',
        about: 'i am mark yasser, computer eng student',
        nsfw: true,
        allowPeopleToFollowYou: true,
        activeInCommunitiesVisibility: true,
        contentVisibility: true);
    patchResponse = {'coverphoto': ''};
    UserData.user = testUser;
    UserData.profileSettings = settingsFromRepository;
  });

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
        when(() =>
                mockAccountSettingsWebService.updateImage(file.path, 'cover'))
            .thenAnswer(
                (_) async => {"coverPhoto": "$patchResponse['coverPhoto']"});
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (SettingsCubit cubit) =>
          cubit.changeCoverphoto(settingsFromRepository!, file.path),
      expect: () => [isA<SettingsChanged>()],
    );
  });
  // Test if mapping from Json to model is correct
  group('Model test', () {
    setUp(() {
      mockAccountSettingsWebService = MockAccountSettingsWebService();
      accountSettingsRepository =
          SettingsRepository(mockAccountSettingsWebService);
      accountSettingsCubit = SettingsCubit(accountSettingsRepository);
    });
    test('Model is generated correctly', () {
      expect(ProfileSettings.fromjson(settingsFromWebServices!),
          settingsFromRepository);
    });
  });
}
