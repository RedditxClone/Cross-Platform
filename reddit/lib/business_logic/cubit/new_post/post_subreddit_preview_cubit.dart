import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/model/post_model.dart';
import '../../../data/repository/new_post_repository.dart';

part 'post_subreddit_preview_state.dart';

class PostSubredditPreviewCubit extends Cubit<PostSubredditPreviewState> {
  PostSubredditPreviewCubit(this.createPostRepository)
      : super(PostSubredditPreviewCubitInitial());
  late CreatePostRepository createPostRepository;

  void submitPost(PostModel postModel) {
    if (isClosed) return;
    createPostRepository.submitPost(postModel).then((ifCreated) {
      if (ifCreated) {
        emit(CreatePostCreated());
        debugPrint("submitted successfully=============");
      } else {
        emit(CreatePostFailedToCreate());
      }
    });
  }

  void uIChanged() {
    if (isClosed) return;
    emit(UIChanged());
  }

  void createBloc() {}

  void postButtonPressed() {
    if (isClosed) return;
    emit(CreatePostPressed());
  }
}
