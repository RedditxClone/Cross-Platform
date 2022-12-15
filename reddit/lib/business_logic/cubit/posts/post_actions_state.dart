part of 'post_actions_cubit.dart';

@immutable
abstract class PostActionsState {}

class PostActionsInitial extends PostActionsState {}

class Saved extends PostActionsState {}

class Unsaved extends PostActionsState {}

class Hidden extends PostActionsState {}

class Unhidden extends PostActionsState {}

class Spammed extends PostActionsState {}

class PostActionsError extends PostActionsState {
  int statusCode;
  PostActionsError(this.statusCode);
}
