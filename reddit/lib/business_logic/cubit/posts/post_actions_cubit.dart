import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';

part 'post_actions_state.dart';

class PostActionsCubit extends Cubit<PostActionsState> {
  final PostActionsRepository postActionsRepository;
  PostActionsCubit(this.postActionsRepository) : super(PostActionsInitial());

  /// This function emits:
  /// state [Saved] when the post is saved successfully.
  /// This function calls the function [PostActionsRepository.savePost].
  void savePost(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(PostActionsError(403));
    } else {
      postActionsRepository.savePost(id).then((statusCode) {
        debugPrint("Save in cubit");
        debugPrint("$statusCode");
        if (statusCode == 201) {
          emit(Saved());
        } else {
          emit(PostActionsError(statusCode));
        }
      });
    }
  }

  /// This function emits:
  /// state [Unsaved] when the post is saved successfully.
  /// This function calls the function [PostActionsRepository.unsavePost].
  void unsavePost(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(PostActionsError(403));
    } else {
      postActionsRepository.unsavePost(id).then((statusCode) {
        if (statusCode == 201) {
          emit(Unsaved());
        } else {
          emit(PostActionsError(statusCode));
        }
      });
    }
  }

  /// This function emits:
  /// state [PostHidden] when the post is saved successfully.
  /// This function calls the function [PostActionsRepository.hidePost].
  void hidePost(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(PostActionsError(403));
    } else {
      postActionsRepository.hidePost(id).then((statusCode) {
        if (statusCode == 201) {
          emit(PostHidden());
        } else {
          emit(PostActionsError(statusCode));
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
      emit(PostActionsError(403));
    } else {
      postActionsRepository.unhidePost(id).then((statusCode) {
        if (statusCode == 201) {
          emit(PostUnhidden());
        } else {
          emit(PostActionsError(statusCode));
        }
      });
    }
  }

  /// This function emits:
  /// state [Spammed] when the post is saved successfully.
  /// This function calls the function [PostActionsRepository.spamPost].
  void spamPost(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(PostActionsError(403));
    } else {
      postActionsRepository.spamPost(id).then((statusCode) {
        if (statusCode == 201) {
          emit(Spammed());
        } else {
          emit(PostActionsError(statusCode));
        }
      });
    }
  }
}
