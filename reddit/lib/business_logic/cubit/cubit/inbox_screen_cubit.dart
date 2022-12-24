import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/message_screen_repository.dart';
import 'package:reddit/data/model/message_screen_model.dart';

part 'inbox_screen_state.dart';

/// This Class Send Inbox Massages Data from  Repo to UI using request to the endpoint `baseUrl/message/me/message` From Real API.
class InboxScreenCubit extends Cubit<InboxScreenState> {
  final MessageScreenRepository messageScreenRepository;
  late List<AllMessageInboxModel> messagesInbox;

  InboxScreenCubit(this.messageScreenRepository) : super(InboxScreenInitial());

  ///  This function Send Inbox Massages Data from  Repo to UI.
  ///
  /// This function emits:
  /// state [InboxScreenLoaded] after successfully Recieving the Data.
  /// This function calls the function [MessageScreenRepository.getAllMessageInboxModel] to prepare the PATCH request.
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
