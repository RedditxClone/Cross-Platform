import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/messages/messages_repository.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final MessagesRepository messageRepository;
  MessagesCubit(this.messageRepository) : super(MessagesInitial());

  /// This function emits :
  /// - [EmptyUsername] :  username is empty
  /// - [EmptySubject]  :  subject is empty
  /// - [EmptyBody]     :  body is empty (on mobile only)
  /// - [CouldNotSend]  :  the user you want to send this message is blocking you or he does not recieve private messages
  /// - [NoSuchUser]    :  the user you want to send this message does not exist
  /// - [MessageSent]   :  message created successfully
  void sendMessage(String subject, String body, String username) {
    if (isClosed) return;
    print('inside message cubit');
    Map<String, dynamic> messageData = {
      'subject': subject,
      'body': body,
    };
    if (username == '') {
      emit(EmptyUsername());
      return;
    }
    if (subject == '') {
      emit(EmptySubject());
      return;
    }
    if (!kIsWeb && body == '') {
      emit(EmptyBody());
      return;
    }
    messageRepository.sendMessage(messageData, username).then((statusCode) {
      if (statusCode == 201) {
        emit(MessageSent());
        return;
      } else if (statusCode == 403) {
        emit(CouldNotSend());
        return;
      } else {
        emit(NoSuchUser());
        return;
      }
    });
  }
}
