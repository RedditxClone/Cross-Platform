part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessageSent extends MessagesState {}

class EmptyUsername extends MessagesState {}

class EmptySubject extends MessagesState {}

class EmptyBody extends MessagesState {}

class NoSuchUser extends MessagesState {}

class CouldNotSend extends MessagesState {}
