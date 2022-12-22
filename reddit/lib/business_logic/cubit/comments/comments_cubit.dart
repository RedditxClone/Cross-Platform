import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/repository/comments/comments_repository.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentsRepository commentsRepository;

  List<Comments>? comments;
  CommentsCubit(this.commentsRepository) : super(CommentsInitial());

  /// This function emits:
  /// state [CommentsLoading] to indicate that data is loading from the server.
  /// state [CommentsLoaded] when comments are loaded successfully.
  /// This function calls the function [CommentsRepository.getTimelinePosts] to get the timeline posts.
  void getThingComments(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    emit(CommentsLoading());
    commentsRepository.getThingComments(id).then((comments) {
      emit(CommentsLoaded(comments));
      this.comments = comments;
    });
  }
}
