import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/data/model/user_settings.dart';
import 'package:reddit/data/repository/settings_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';

class MockWebService extends Mock implements SettingsWebServices {}

void main() async {
  late MockWebService mockWebService;
  late SettingsRepository settingsRepository;
  late SettingsCubit settingsCubit;
  setUp(() {
    mockWebService = MockWebService();
    settingsRepository = SettingsRepository(mockWebService);
    settingsCubit = SettingsCubit(settingsRepository);
  });
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
    "personalizeAllOfReddit": false,
    "personalizeAds_information": true,
    "personalizeAds_yourActivity": false,
    "personalizeRec_generalLocation": true,
    "personalizeRec_ourPartners": true,
    "Use two-factor authentication": false
  }''';
  String data = settingsFromWebServices.toString();
  void arrangeWebServices() {
    when(() => mockWebService.getUserSettings()).thenAnswer(
      (_) async => data,
    );
  }

  blocTest<SettingsCubit, SettingsState>(
    'emits SettingsLoaded state correctly',
    setUp: () {
      arrangeWebServices();
    },
    build: () {
      return settingsCubit;
    },
    act: (SettingsCubit cubit) => cubit.getUserSettings(),
    expect: () => [isA<SettingsAvailable>()],
  );

  group('testing patch requests', () {
    test('change cover photo', () {});
    test('change profile photo', () {});
    test('change display name', () {});
    test('change about', () {});
    test('change allowPeopleToFollowYou', () {});
    test('change activeInCommunitiesVisibility', () {});
    test('change contentVisibility', () {});
    test('change nsfw', () {});
  });
}
