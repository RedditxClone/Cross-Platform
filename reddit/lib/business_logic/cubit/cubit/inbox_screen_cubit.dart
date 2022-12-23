import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/message_screen_repository.dart';
import 'package:reddit/data/model/message_screen_model.dart';

part 'inbox_screen_state.dart';

class InboxScreenCubit extends Cubit<InboxScreenState> {
  final MessageScreenRepository messageScreenRepository;
  late List<AllMessageInboxModel> messagesInbox;

  InboxScreenCubit(this.messageScreenRepository) : super(InboxScreenInitial());
  void getAllMessageInboxModel() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    messageScreenRepository.getAllMessageInboxModel().then((messagesInbox) {
      this.messagesInbox = messagesInbox.messages!;
      print('Inbox data after Cubit');
      print(this.messagesInbox.length);
      for (var message in this.messagesInbox) {
        print(message.printfunc());
      }
      emit(InboxScreenLoaded(messagesInbox.messages!));
      this.messagesInbox = messagesInbox.messages!;
    });
  }
}
