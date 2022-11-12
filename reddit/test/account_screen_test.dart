import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/cubit/account_settings_cubit.dart';
import 'package:reddit/data/model/account_settings_model.dart';
import 'package:reddit/data/model/change_password_model.dart';
import 'package:reddit/data/repository/account_settings_repository.dart';
import 'package:reddit/data/web_services/account_settings_web_services.dart';
import 'package:reddit/presentation/screens/account_settings/account_settings_screen.dart';

class MockAccountSettingsWebService extends Mock
    implements AccountSettingsWebServices {}

class MockAccountSettingsCubit extends MockCubit<AccountSettingsState>
    implements AccountSettingsCubit {}

void main() async {
  late MockAccountSettingsWebService mockAccountSettingsWebService;
  late AccountSettingsRepository accountSettingsRepository;
  late AccountSettingsCubit accountSettingsCubit;
  late MockAccountSettingsCubit mockAccountSettingsCubit;
  const String settingsFromWebServices = '''{
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
  }''';
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
  final changePasswordModel =
      ChangePasswordModel(oldPassword: "123", newPassword: "456");
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
            jsonDecode(settingsFromWebServices))).thenAnswer((_) async => 200);
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (AccountSettingsCubit cubit) =>
          cubit.updateAccountSettings(settingsFromRepository),
      expect: () => [isA<AccountSettingsLoaded>()],
    );
    blocTest<AccountSettingsCubit, AccountSettingsState>(
      'Password updated successfullt state is emitted correctly after if server responded with 200',
      setUp: () {
        when(() => mockAccountSettingsWebService
                .changePassword({"oldPassword": "123", "newPassword": "456"}))
            .thenAnswer((_) async => 200);
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (AccountSettingsCubit cubit) =>
          cubit.changePassword(changePasswordModel),
      expect: () => [isA<PasswordUpdatedSuccessfully>()],
    );
    blocTest<AccountSettingsCubit, AccountSettingsState>(
      'Wrong password state is emitted correctly after if server responded with 403',
      setUp: () {
        when(() => mockAccountSettingsWebService
                .changePassword({"oldPassword": "123", "newPassword": "456"}))
            .thenAnswer((_) async => 403);
      },
      build: () {
        return accountSettingsCubit;
      },
      act: (AccountSettingsCubit cubit) =>
          cubit.changePassword(changePasswordModel),
      expect: () => [isA<WrongPassword>()],
    );
  });
  // Test if mapping from Json to model is correct
  group('Model test', () {
    test('Account Aettings Model is generated correctly', () {
      expect(
        AccountSettingsModel.fromJson(jsonDecode(settingsFromWebServices)),
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
          child: MaterialApp(
              home: AccountSettingsScreen(const {
            "username": "bemoierian",
            "email": "bemoi.erian@gmail.com",
            "gender": true
          })),
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
