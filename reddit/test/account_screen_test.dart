import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/data/model/account_settings_model.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';
import 'package:reddit/data/web_services/account_settings_web_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockWebService extends Mock implements AccountSettingsWebServices {}

void main() async {
  late MockWebService mockWebService;
  // late AccountSettingsWebServices accountSettingsWebServices;
  late AccountSettingsRepository accountSettingsRepository;
  late AccountSettingsCubit accountSettingsCubit;
  setUp(() {
    mockWebService = MockWebService();
    // accountSettingsWebServices = AccountSettingsWebServices();
    accountSettingsRepository = AccountSettingsRepository(mockWebService);
    accountSettingsCubit = AccountSettingsCubit(accountSettingsRepository);
  });
  final Map<String, dynamic> settingsFromWebServices = {
    "gender": "M",
    "enable_followers": true,
    "over_18": true,
    "num_comments": 0,
    "email_upvote_post": true,
    "email_upvote_comment": true,
    "email_messages": true,
    "default_comment_sort": 0,
    "show_flair": true,
    "country_code": "EG"
  };
  // final settingsFromRepository = AccountSettingsModel(
  //     gender: "M",
  //     enableFollowers: true,
  //     over18: true,
  //     numComments: 0,
  //     emailUpvotePost: true,
  //     emailUpvoteComment: true,
  //     emailMessages: true,
  //     defaultCommentSort: 0,
  //     showFlair: true,
  //     countryCode: "EG");

  void arrangeWebServices() {
    when(() => mockWebService.getAccountSettings()).thenAnswer(
      (_) async => settingsFromWebServices,
    );
    // when(() => mockWebService.updateAccountSettings(settingsFromWebServices))
    //     .thenAnswer(
    //   (_) {}),
    // );
  }

  // test('Mapping from response to model', () async {
  //   arrangeWebServices();
  //   AccountSettingsModel res =
  //       await accountSettingsRepository.getAccountSettings();
  //   expect(res, settingsFromRepository);
  // });
  // test('initial state of SettingsCubit',
  //   () {
  //     arrangeWebServices();
  //     final future = charactersCubit.getAllCharacters();
  //     expect(charactersCubit.state, isA<CharactersLoaded>());
  //     // charactersCubit.charactersList[0].char_id = 2;
  //     expect(charactersCubit.charactersList, settingsFromRepository);
  //   }
  // );
  // blocTest(
  //   'emits [] when nothing is added',
  //   build: () => charactersCubit,
  //   // seed: () => List<dynamic>,
  //   expect: () => [isA<CharactersLoaded>()],
  // );

  blocTest<AccountSettingsCubit, AccountSettingsState>(
    'emits settings loaded',
    setUp: () {
      arrangeWebServices();
    },
    build: () {
      return accountSettingsCubit;
    },
    act: (AccountSettingsCubit cubit) => cubit.getAccountSettings(),
    expect: () => [isA<AccountSettingsLoaded>()],
  );
}
