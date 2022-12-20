part of 'message_screen_cubit.dart';

@immutable
abstract class MessageScreenState {}

class MessageScreenInitial extends MessageScreenState {}

class AllMessagesLoaded extends MessageScreenState {
  final AllMessages allMessages;

  AllMessagesLoaded(this.allMessages);
}
