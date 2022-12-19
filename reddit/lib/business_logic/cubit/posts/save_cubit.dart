import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';

part 'save_state.dart';

class SaveCubit extends Cubit<SaveState> {
  final PostActionsRepository postActionsRepository;
  SaveCubit(this.postActionsRepository) : super(SaveInitial());

  /// This function emits:
  /// state [Saved] when the post is saved successfully.
  /// This function calls the function [PostActionsRepository.savePost].
  void savePost(String id) {
    // To avoid state error when you leave the page
    if (isClosed) return;
    if (UserData.user == null) {
      emit(SaveError(403));
    } else {
      postActionsRepository.savePost(id).then((statusCode) {
        debugPrint("Save in cubit");
        debugPrint("$statusCode");
        if (statusCode == 200) {
          emit(Saved());
        } else {
          emit(SaveError(statusCode));
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
      emit(UnsaveError(403));
    } else {
      postActionsRepository.unsavePost(id).then((statusCode) {
        if (statusCode == 200) {
          emit(Unsaved());
        } else {
          emit(UnsaveError(statusCode));
        }
      });
    }
  }
}
