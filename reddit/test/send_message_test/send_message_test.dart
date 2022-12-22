import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/messages/messages_cubit.dart';
import 'package:reddit/data/repository/messages/messages_repository.dart';
import 'package:reddit/data/web_services/messages/messages_web_services.dart';

class MockMessagesWebService extends Mock implements MessagesWebServices {}

class MockMessagesCubit extends MockCubit<MessagesState>
    implements MessagesCubit {}

void main() async {
  late MockMessagesWebService mocksendMessageWebService;
  late MessagesRepository sendMessageRepository;

  late MessagesCubit messagesCubit;
  late Map<String, dynamic> messageData;
  group("State test", () {
    setUp(() {
      mocksendMessageWebService = MockMessagesWebService();
      sendMessageRepository = MessagesRepository(mocksendMessageWebService);
      messagesCubit = MessagesCubit(sendMessageRepository);
      messageData = {"subject": "subject", "body": "body"};
    });

    blocTest<MessagesCubit, MessagesState>(
      'MessageSent state is emitted correctly after getting user info correctly from server',
      setUp: () {
        when(() =>
                mocksendMessageWebService.sendMessage(messageData, 'username'))
            .thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return messagesCubit;
      },
      act: (MessagesCubit cubit) =>
          cubit.sendMessage("subject", "body", 'username'),
      expect: () => [isA<MessageSent>()],
    );
  });
}
