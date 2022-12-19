import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/model/comments/comment_submit.dart';
import 'package:reddit/data/repository/comments/comments_repository.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  final CommentsRepository commentsRepository;

  AddCommentCubit(this.commentsRepository) : super(AddCommentInitial());

  /// This function emits:
  /// state [CommentAdded] when the comment is added successfully.
  /// state [AddCommentError] when an error occurs.
  /// This function calls the function [CommentsRepository.addComment].
  void addComment(CommentSubmit commentSubmit) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(AddCommentError(403));
    } else {
      commentsRepository.addComment(commentSubmit).then((comment) {
        emit(CommentAdded(comment));
      });
    }
  }
}
