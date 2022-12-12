import 'dart:convert';
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
    testUser = User(
        userId: '1',
        name: 'mark_yasser',
        displayName: 'mark',
        email: 'mark@hotmail.com',
        coverPic: null,
        profilePic: null);
    UserData.initUser(testUser);
    settingsFromWebServices = {
      "profilephoto":
          "https://image.shutterstock.com/mosaic_250/2780032/1854697390/stock-photo-head-shot-young-attractive-businessman-in-glasses-standing-in-modern-office-pose-for-camera-1854697390.jpg",
      "coverphoto":
          "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/1-mcway-waterfall-with-small-cove-ingmar-wesemann.jpg",
      "nsfw": true,
      "displayName": "Markos",
      "about": "I am a computer engineer student",
      "allowFollow": false,
      "activeInCommunitiesVisibility": true,
      "contentVisibility": false
    };
    patchResponse = {
      'coverphoto':
          'https://images.unsplash.com/photo-1504805572947-34fad45aed93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y292ZXIlMjBwaG90b3xlbnwwfHwwfHw%3D&w=1000&q=80'
    };
    settingsFromRepository = ProfileSettings(
        profile:
            'https://image.shutterstock.com/mosaic_250/2780032/1854697390/stock-photo-head-shot-young-attractive-businessman-in-glasses-standing-in-modern-office-pose-for-camera-1854697390.jpg',
        cover:
            'https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/1-mcway-waterfall-with-small-cove-ingmar-wesemann.jpg',
        displayName: 'Markos',
        about: 'I am a computer engineer student',
        nsfw: true,
        allowPeopleToFollowYou: false,
        activeInCommunitiesVisibility: true,
        contentVisibility: false);
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
                mockAccountSettingsWebService.updateImage(file, 'coverphoto'))
            .thenAnswer(
                (_) async => {"coverphoto": "$patchResponse['coverphoto']"});
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (SettingsCubit cubit) =>
          cubit.changeCoverphoto(settingsFromRepository!, file),
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
      expect(
        ProfileSettings.fromjson(settingsFromWebServices!),
        settingsFromRepository,
      );
    });
  });
}
