import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/email_settings_cubit.dart';
import 'package:reddit/data/model/email_settings.dart';
import 'package:reddit/data/repository/email_settings_repo.dart';
import 'package:reddit/data/web_services/email_settings_web_services.dart';
import 'package:reddit/presentation/screens/email_settings_web.dart';

class MockEmailSettingsWebService extends Mock
    implements EmailSettingsWebServices {}

class MockEmailSettingsCubit extends MockCubit<EmailSettingsState>
    implements EmailSettingsCubit {}

void main() async {
  late MockEmailSettingsWebService mockEmailSettingsWebService;
  late EmailSettingsRepository emailSettingsRepository;
  late EmailSettingsCubit emailSettingsCubit;
  late MockEmailSettingsCubit mockEmailSettingsCubit;

  final Map<String, dynamic> settingsFromWebServices = {
    "inboxMessages": true,
    "newUserFlair": true,
    "comments_on_post": true,
    "repliesComments": true,
    "upvotePosts": true,
    "upvoteComments": true,
    "mentions": true,
    "newFollowers": true,
  };

  final settingsFromRepository = EmailSettings(
    inboxMessages: true,
    newUserWelcome: true,
    commentsOnPost: true,
    repliesToComments: true,
    upvotesOnPost: true,
    upvotesOnComments: true,
    usernameMentions: true,
    newFollowers: true,
  );

  group("State test", () {
    setUp(() {
      mockEmailSettingsWebService = MockEmailSettingsWebService();
      emailSettingsRepository =
          EmailSettingsRepository(mockEmailSettingsWebService);
      emailSettingsCubit = EmailSettingsCubit(emailSettingsRepository);
    });
    // Calling getemailSettings() function returns the correct state
    // emailSettingsLoading means that the request is sent and we are waiting for the response
    // emailSettingsLoaded means that the response is received and UI is built based on this responce
    blocTest<EmailSettingsCubit, EmailSettingsState>(
      'Settings loading, loaded states are emitted correctly after getting settings data from server',
      setUp: () {
        when(() => mockEmailSettingsWebService.getEmailSettings()).thenAnswer(
          (_) async => settingsFromWebServices,
        );
      },
      build: () {
        return emailSettingsCubit;
      },
      act: (EmailSettingsCubit cubit) => cubit.getEmailSettings(),
      expect: () => [isA<EmailSettingsLoading>(), isA<EmailSettingsLoaded>()],
    );
    blocTest<EmailSettingsCubit, EmailSettingsState>(
      'Settings updated, loaded states are emitted correctly after updating settings',
      setUp: () {
        when(() => mockEmailSettingsWebService.updateEmailSettings(
            settingsFromWebServices)).thenAnswer((_) async => 200);
      },
      build: () {
        return emailSettingsCubit;
      },
      act: (EmailSettingsCubit cubit) =>
          cubit.updateEmailSettings(settingsFromRepository),
      expect: () => [isA<EmailSettingsUpdated>(), isA<EmailSettingsLoaded>()],
    );
  });
  // Test if mapping from Json to model is correct
  group('Model test', () {
    test('Model is generated correctly', () {
      expect(
        EmailSettings.fromJson(settingsFromWebServices),
        settingsFromRepository,
      );
    });
  });
}
