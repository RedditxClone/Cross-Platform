import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/data/model/account_settings_model.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';
import 'package:reddit/data/web_services/account_settings_web_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import '../lib/presentation/screens/account_settings_screen.dart';

class MockAccountSettingsWebService extends Mock
    implements AccountSettingsWebServices {}

class MockAccountSettingsCubit extends MockCubit<AccountSettingsState>
    implements AccountSettingsCubit {}

void main() async {
  late MockAccountSettingsWebService mockAccountSettingsWebService;
  late AccountSettingsRepository accountSettingsRepository;
  late AccountSettingsCubit accountSettingsCubit;
  late MockAccountSettingsCubit mockAccountSettingsCubit;
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
  final settingsFromRepository = AccountSettingsModel(
      gender: "M",
      enableFollowers: true,
      over18: true,
      numComments: 0,
      emailUpvotePost: true,
      emailUpvoteComment: true,
      emailMessages: true,
      defaultCommentSort: 0,
      showFlair: true,
      countryCode: "EG");

  // test('initial state of SettingsCubit',
  //   () {
  //     arrangeWebServices();
  //     final future = charactersCubit.getAllCharacters();
  //     expect(charactersCubit.state, isA<CharactersLoaded>());
  //     // charactersCubit.charactersList[0].char_id = 2;
  //     expect(charactersCubit.charactersList, settingsFromRepository);
  //   }
  // );

  group("State test", () {
    setUp(() {
      mockAccountSettingsWebService = MockAccountSettingsWebService();
      accountSettingsRepository =
          AccountSettingsRepository(mockAccountSettingsWebService);
      accountSettingsCubit = AccountSettingsCubit(accountSettingsRepository);
    });
    // Calling getAccountSettings() function returns the correct state
    // AccountSettingsLoading means that the request is sent and we are waiting for the response
    // AccountSettingsLoaded means that the response is received and UI is built based on this responce
    blocTest<AccountSettingsCubit, AccountSettingsState>(
      'Settings loaded state is emitted correctly after getting settings data from server',
      setUp: () {
        when(() => mockAccountSettingsWebService.getAccountSettings())
            .thenAnswer(
          (_) async => settingsFromWebServices,
        );
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (AccountSettingsCubit cubit) => cubit.getAccountSettings(),
      expect: () =>
          [isA<AccountSettingsLoading>(), isA<AccountSettingsLoaded>()],
    );
    blocTest<AccountSettingsCubit, AccountSettingsState>(
      'Settings loaded state is emitted correctly after updating settings',
      setUp: () {
        when(() => mockAccountSettingsWebService.updateAccountSettings(
            settingsFromWebServices)).thenAnswer((_) async => 200);
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (AccountSettingsCubit cubit) =>
          cubit.updateAccountSettings(settingsFromRepository),
      expect: () => [isA<AccountSettingsLoaded>()],
    );
    // blocTest<AccountSettingsCubit, AccountSettingsState>(
    //   'Settings not loaded correclty',
    //   setUp: () {
    //     when(() => mockAccountSettingsWebService.getAccountSettings()).thenAnswer(
    //       (_) async => <String, dynamic>{},
    //     );
    //   },
    //   build: () {
    //     return accountSettingsCubit;
    //   },
    //   act: (AccountSettingsCubit cubit) => cubit.getAccountSettings(),
    //   expect: () => [isA<AccountSettingsLoading>()],
    // );
  });
  group('Model test', () {
    test('Model is generated correctly', () {
      expect(
        AccountSettingsModel.fromJson(settingsFromWebServices),
        settingsFromRepository,
      );
    });
  });
  group("UI data matches response data", () {
    setUp(() {
      mockAccountSettingsCubit = MockAccountSettingsCubit();
      when(() => mockAccountSettingsCubit.state)
          .thenReturn(AccountSettingsLoaded(settingsFromRepository));
    });
    testWidgets('Account settings screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AccountSettingsCubit>(
              create: (context) => mockAccountSettingsCubit,
            )
          ],
          child: const MaterialApp(home: AccountSettingsScreen()),
        ),
      );
      // Gender is displayed correctly
      expect(find.text(settingsFromRepository.gender == "M" ? "Man" : "Woman"),
          findsOneWidget);
      // Country is displayed correctly
      expect(
          find.text(settingsFromRepository.countryCode == "EG" ? 'Egypt' : ""),
          findsOneWidget);
      // Allow people to follow you toggle is displayed correctly
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Switch &&
              widget.key == const Key("allow_people_to_follow_you") &&
              widget.value == settingsFromRepository.enableFollowers),
          findsOneWidget);
      // Update settings function is called after pressing on the switch
      await tester
          .ensureVisible(find.byKey(const Key("allow_people_to_follow_you")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("allow_people_to_follow_you")));
      verify(() => mockAccountSettingsCubit
          .updateAccountSettings(settingsFromRepository)).called(1);
    });
  });
}
