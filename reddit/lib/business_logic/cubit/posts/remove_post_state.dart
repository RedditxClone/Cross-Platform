part of 'remove_post_cubit.dart';

@immutable
abstract class RemovePostState {}

class RemovePostInitial extends RemovePostState {}

class Hidden extends RemovePostState {}

class Unhidden extends RemovePostState {}

class RemovePostError extends RemovePostState {
  int statusCode;
  RemovePostError(this.statusCode);
}
