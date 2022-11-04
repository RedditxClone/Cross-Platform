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
    'inbox_messages': true,
    'chat_requests': true,
    'new_user_welcome': true,
    'comments_on_post': true,
    'replies_to_comments': true,
    'upvotes_on_post': true,
    'upvotes_on_comments': true,
    'username_mentions': true,
    'new_followers': true,
    'daily_digest': true,
    'weekly_recap': true,
    'community_discovery': true,
    'unsubscribe_emails': false,
  };
  final settingsFromRepository = EmailSettings(
    inboxMessages: true,
    chatRequests: true,
    newUserWelcome: true,
    commentsOnPost: true,
    repliesToComments: true,
    upvotesOnPost: true,
    upvotesOnComments: true,
    usernameMentions: true,
    newFollowers: true,
    dailyDigest: true,
    weeklyRecap: true,
    communityDiscovery: true,
    unsubscribeEmails: false,
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
      'Settings loaded state is emitted correctly after getting settings data from server',
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
      'Settings loaded state is emitted correctly after updating settings',
      setUp: () {
        when(() => mockEmailSettingsWebService.updateEmailSettings(
            settingsFromWebServices)).thenAnswer((_) async => 200);
      },
      build: () {
        return emailSettingsCubit;
      },
      act: (EmailSettingsCubit cubit) =>
          cubit.updateEmailSettings(settingsFromRepository),
      expect: () => [isA<EmailSettingsLoaded>()],
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
  // Check if the data shown on UI is the same as the data comming from server.
  // Check if update settings function is called when updating any value from UI.
  group("UI data matches response data", () {
    setUp(() {
      mockEmailSettingsCubit = MockEmailSettingsCubit();
      when(() => mockEmailSettingsCubit.state)
          .thenReturn(EmailSettingsLoaded(settingsFromRepository));
    });
    testWidgets('email settings screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<EmailSettingsCubit>(
              create: (context) => mockEmailSettingsCubit,
            )
          ],
          child: const MaterialApp(home: EmailSettingsWeb()),
        ),
      );

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('inbox_messages') &&
              widget.value == settingsFromRepository.inboxMessages),
          findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('chat_requests') &&
              widget.value == settingsFromRepository.chatRequests),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('new_user_welcome') &&
              widget.value == settingsFromRepository.newUserWelcome),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('comments_on_post') &&
              widget.value == settingsFromRepository.commentsOnPost),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('replies_to_comments') &&
              widget.value == settingsFromRepository.repliesToComments),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('upvotes_on_post') &&
              widget.value == settingsFromRepository.upvotesOnPost),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('upvotes_on_comments') &&
              widget.value == settingsFromRepository.upvotesOnComments),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('username_mentions') &&
              widget.value == settingsFromRepository.usernameMentions),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('new_followers') &&
              widget.value == settingsFromRepository.newFollowers),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('daily_digest') &&
              widget.value == settingsFromRepository.dailyDigest),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('weekly_recap') &&
              widget.value == settingsFromRepository.weeklyRecap),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('community_discovery') &&
              widget.value == settingsFromRepository.communityDiscovery),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) =>
              widget is SwitchListTile &&
              widget.key == const Key('unsubscribe_emails') &&
              widget.value == settingsFromRepository.unsubscribeEmails),
          findsOneWidget);

      // Update settings function is called after pressing on the switch
      await tester.ensureVisible(find.byKey(const Key("inbox_messages")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("inbox_messages")));
      verify(() => mockEmailSettingsCubit
          .updateEmailSettings(settingsFromRepository)).called(1);
    });
  });
}
