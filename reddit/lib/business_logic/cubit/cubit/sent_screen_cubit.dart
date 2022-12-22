import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/message_screen_repository.dart';
import 'package:reddit/data/model/message_screen_model.dart';

part 'sent_screen_state.dart';

class SentScreenCubit extends Cubit<SentScreenState> {
  final MessageScreenRepository messageScreenRepository;
  late List<AllSentMessageModel> sentMessages;
  SentScreenCubit(this.messageScreenRepository) : super(SentScreenInitial());

  void getAllSentMessages() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    messageScreenRepository.getAllSentMessageModel().then((sentMessages) {
      this.sentMessages = sentMessages.messages!;
      print('Sent data after Cubit');
      print(this.sentMessages.length);
      for (var message in this.sentMessages) {
        print(message.printfunc());
      }
      emit(SentScreenLoaded(sentMessages.messages!));
      this.sentMessages = sentMessages.messages!;
    });
  }
}
