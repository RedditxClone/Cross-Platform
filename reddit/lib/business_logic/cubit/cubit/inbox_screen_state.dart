part of 'inbox_screen_cubit.dart';

@immutable
abstract class InboxScreenState {}

class InboxScreenInitial extends InboxScreenState {}

class InboxScreenLoaded extends InboxScreenState {
  final List<AllMessageInboxModel> messagesInbox;

  InboxScreenLoaded(this.messagesInbox);
}
