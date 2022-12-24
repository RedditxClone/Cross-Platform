part of 'sent_screen_cubit.dart';

@immutable
abstract class SentScreenState {}

class SentScreenInitial extends SentScreenState {}

/// Messages Sent [sentMessages]is Recieved successfully
class SentScreenLoaded extends SentScreenState {
  final List<AllSentMessageModel> sentMessages;

  SentScreenLoaded(this.sentMessages);
}
