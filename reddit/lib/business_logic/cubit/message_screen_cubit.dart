import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/message_screen_repository.dart';
import 'package:reddit/data/model/message_screen_model.dart';

part 'message_screen_state.dart';

class MessageScreenCubit extends Cubit<MessageScreenState> {
  final MessageScreenRepository messageScreenRepository;
  late AllMessages allMessages;
  late List<AllMessageInboxModel> messagesInbox;
  late List<AllSentMessageModel> sentMessages;

  MessageScreenCubit(this.messageScreenRepository)
      : super(MessageScreenInitial());

  void getAllMessages() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    messageScreenRepository.getAllMessageInboxModel().then((messagesInbox) {
      this.messagesInbox = messagesInbox.messages!;
      print('Inbox data after Cubit');
      print(this.messagesInbox.length);
      for (var message in this.messagesInbox) {
        print(message.printfunc());
      }
      messageScreenRepository.getAllSentMessageModel().then((sentMessages) {
        this.sentMessages = sentMessages.messages!;
        print('Sent data after Cubit');
        print(this.sentMessages.length);
        for (var message in this.sentMessages) {
          print(message.printfunc());
        }
        AllMessages allMessages = AllMessages(
            inboxMessages: this.messagesInbox, sentMessages: this.sentMessages);
        emit(AllMessagesLoaded(allMessages));
        this.allMessages = allMessages;
      });
    });
  }
}
