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
  late MockAccountSettingsWebService mockProfileSettingsWebService;
  late SettingsRepository profileSettingsRepository;
  late SettingsCubit profileSettingsCubit;
  File file = File('/test/asd.jpg');
  User? testUser;
  ProfileSettings? settingsFromRepository;
  Map<String, String>? patchResponse1;
  Map<String, String>? patchResponse2;
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
    patchResponse1 = {'coverPhoto': ''};
    patchResponse2 = {'profilePhoto': ''};
    UserData.user = testUser;
    UserData.profileSettings = settingsFromRepository;
  });

  group("State test", () {
    setUp(() {
      mockProfileSettingsWebService = MockAccountSettingsWebService();
      profileSettingsRepository =
          SettingsRepository(mockProfileSettingsWebService);
      profileSettingsCubit = SettingsCubit(profileSettingsRepository);
    });
    blocTest<SettingsCubit, SettingsState>(
      'Settings loaded state is emitted correctly after getting settings data from server',
      setUp: () {
        when(() => mockProfileSettingsWebService.getUserSettings()).thenAnswer(
          (_) async => settingsFromWebServices,
        );
      },
      build: () {
        return profileSettingsCubit;
      },
      act: (SettingsCubit cubit) => cubit.getUserSettings(),
      expect: () => [isA<SettingsAvailable>()],
    );
    blocTest<SettingsCubit, SettingsState>(
      'Settings loaded state is emitted correctly after updating settings',
      setUp: () {
        when(() =>
                mockProfileSettingsWebService.updateImage(file.path, 'cover'))
            .thenAnswer(
                (_) async => {"coverPhoto": "$patchResponse1['coverPhoto']"});
      },
      build: () {
        return profileSettingsCubit;
      },
      act: (SettingsCubit cubit) =>
          cubit.changeCoverphoto(settingsFromRepository!, file.path),
      expect: () => [isA<SettingsChanged>()],
    );
    blocTest<SettingsCubit, SettingsState>(
      'Settings loaded state is emitted correctly after updating settings',
      setUp: () {
        when(() =>
                mockProfileSettingsWebService.updateImage(file.path, 'profile'))
            .thenAnswer((_) async =>
                {"profilePhoto": "$patchResponse2['profilePhoto']"});
      },
      build: () {
        return profileSettingsCubit;
      },
      act: (SettingsCubit cubit) =>
          cubit.changeProfilephoto(settingsFromRepository!, file.path),
      expect: () => [isA<SettingsChanged>()],
    );
  });
  // Test if mapping from Json to model is correct
  group('Model test', () {
    setUp(() {
      mockProfileSettingsWebService = MockAccountSettingsWebService();
      profileSettingsRepository =
          SettingsRepository(mockProfileSettingsWebService);
      profileSettingsCubit = SettingsCubit(profileSettingsRepository);
    });
    test('Model is generated correctly', () {
      expect(ProfileSettings.fromjson(settingsFromWebServices!),
          settingsFromRepository);
    });
  });
}
