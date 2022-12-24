import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/message_screen_repository.dart';
import 'package:reddit/data/model/message_screen_model.dart';

part 'sent_screen_state.dart';

/// This Class Send  Massages Sent Data from  Repo to UI using request to the endpoint `baseUrl/message/me/sent` From Real API.
class SentScreenCubit extends Cubit<SentScreenState> {
  final MessageScreenRepository messageScreenRepository;
  late List<AllSentMessageModel> sentMessages;

  SentScreenCubit(this.messageScreenRepository) : super(SentScreenInitial());

  ///  This function Send Massages Sent Data from  Repo to UI.
  ///
  /// This function emits:
  /// state [SentScreenLoaded] after successfully Recieving the Data.
  /// This function calls the function [MessageScreenRepository.getAllSentMessageModel] to prepare the PATCH request.
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
