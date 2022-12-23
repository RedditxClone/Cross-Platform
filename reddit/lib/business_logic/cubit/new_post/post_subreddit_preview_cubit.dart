import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

  void submitPostWeb(PostModel postModel) {
    if (isClosed) return;
    createPostRepository.submitPostWeb(postModel).then((response) {
      if (response.statusCode == 201) {
        emit(createdInWeb(response.data['_id']));
        debugPrint("submitted successfully");
      } else {
        emit(errorInCreationWeb(response.statusMessage()));
      }
    });
  }

  void postImageAndVideo(PostModel postModel, Uint8List media) {
    if (isClosed) return;
    createPostRepository.submitPostWeb(postModel).then((response) {
      if (response.statusCode == 201) {
        createPostRepository
            .postImageAndVideo(response.data['_id'], media)
            .then((response) {
          if (response.statusCode == 201 &&
              response.data['status'] == 'success') {
            emit(createdInWeb(response.data['_id']));
            debugPrint("submitted successfully");
          } else {
            emit(errorInCreationWeb(response.statusMessage()));
          }
        });
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
