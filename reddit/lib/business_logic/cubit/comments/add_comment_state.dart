part of 'add_comment_cubit.dart';

@immutable
abstract class AddCommentState {}

class AddCommentInitial extends AddCommentState {}

class CommentAdded extends AddCommentState {
  Comments comment;
  CommentAdded(this.comment);
}

class AddCommentError extends AddCommentState {
  int statusCode;
  AddCommentError(this.statusCode);
}
