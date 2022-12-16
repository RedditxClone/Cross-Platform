import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';

part 'remove_post_state.dart';

class RemovePostCubit extends Cubit<RemovePostState> {
  final PostActionsRepository postActionsRepository;
  RemovePostCubit(this.postActionsRepository) : super(RemovePostInitial());

  /// This function emits:
  /// state [Hidden] when the post is saved successfully.
  /// This function calls the function [PostActionsRepository.hidePost].
  void hidePost(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(RemovePostError(403));
    } else {
      postActionsRepository.hidePost(id).then((statusCode) {
        if (statusCode == 201) {
          emit(Hidden());
        } else {
          emit(RemovePostError(statusCode));
        }
      });
    }
  }

  /// This function emits:
  /// state [Deleted] when the post is saved successfully.
  /// This function calls the function [PostActionsRepository.deletePost].
  void deletePost(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(RemovePostError(403));
    } else {
      postActionsRepository.deletePost(id).then((statusCode) {
        if (statusCode == 200) {
          emit(Deleted());
        } else {
          emit(RemovePostError(statusCode));
        }
      });
    }
  }

  /// This function emits:
  /// state [Unaved] when the post is saved successfully.
  /// This function calls the function [PostActionsRepository.unhidePost].
  void unhidePost(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(RemovePostError(403));
    } else {
      postActionsRepository.unhidePost(id).then((statusCode) {
        if (statusCode == 201) {
          emit(Unhidden());
        } else {
          emit(RemovePostError(statusCode));
        }
      });
    }
  }
}
