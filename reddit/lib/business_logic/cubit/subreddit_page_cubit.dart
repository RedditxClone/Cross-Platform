import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/subreddit_model.dart';
import '../../data/model/post_model.dart';
import '../../data/repository/subreddit_page_repository.dart';

part 'subreddit_page_state.dart';

class SubredditPageCubit extends Cubit<SubredditPageState> {
  final SubredditPageRepository subredditPageRepository;
  SubredditModel? _subredditModel;
  List<PostModel>? _postsInPageModels;
  String? _subredditIcon;
  List<String>? _subredditModerators;
  String? _subredditDescription;

  SubredditPageCubit(this.subredditPageRepository)
      : super(SubredditPageInitial());

  // void getPostsInPage(String subreddit, String mode) {
  //   emit(PostsInPageLoading());

  //   subredditPageRepository.getPostsInPage(subreddit, mode).then((value) {
  //     _postsInPageModels = value;
  //     emit(PostsInPageLoaded(_postsInPageModels!));
  //   });
  // }

  void leaveSubreddit(subredditId) {
    subredditPageRepository.leaveSubreddit(subredditId).then((value) {
      if (value) {
        emit(LeftSubreddit());
      } else {
        emit(FailedToLeave());
      }
    });
  }

  void joinSubreddit(subredditId) {
    subredditPageRepository.joinSubreddit(subredditId).then((value) {
      if (value) {
        emit(JoinedSubreddit());
      } else {
        emit(FailedToJoin());
      }
    });
  }

  void getSubredditInfo(String subredditId) {
    emit(SubredditPageLoading());
    subredditPageRepository.getSubredditInfo(subredditId).then((value) {
      _subredditModel = value;
      print(_subredditModel.toString());
      subredditPageRepository.getIfJoined(subredditId).then((isJoined) {
        subredditPageRepository.getIfMod(subredditId).then((isMod) {
          emit(SubredditPageLoaded(_subredditModel!, isMod, isJoined));
        });
      });
    });
  }

  // void getSubredditIcon(String subredditName) {
  //   subredditPageRepository.getSubredditIcon(subredditName).then((value) {
  //     _subredditIcon = value;
  //     emit(SubredditIconLoaded(_subredditIcon!));
  //   });
  // }

  // void getSubredditDescription(String subredditName) {
  //   subredditPageRepository
  //       .getSubredditDescription(subredditName)
  //       .then((value) {
  //     _subredditIcon = value;
  //     emit(SubredditDescriptionLoaded(_subredditDescription!));
  //   });
  // }

  void updateSubredditIcon(String subredditId, Uint8List pickedImage) {
    emit(SubredditIconUpdating());

    if (isClosed) {
      return;
    } else {
      subredditPageRepository
          .updateSubredditIcon(subredditId, pickedImage)
          .then((image) {
        debugPrint(image);
        emit(SubredditIconUpdated(image));
      });
    }

    // void getSubredditModerators(String subreddit) {
    //   emit(SubredditModeratorsLoading());

    //   subredditPageRepository.getSubredditModerators(subreddit).then((value) {
    //     _subredditModerators = value;
    //     emit(SubredditModeratorsLoaded(_subredditModerators!));
    //   });
    // }

    getIfJoined(String subredditId) async {
      if (isClosed) return;
      subredditPageRepository.getIfJoined(subredditId).then((value) {
        if (value) {
          emit(InSubreddit());
        } else {
          emit(OutSubreddit());
        }
      });
    }

    getIfMod(String subredditId) async {
      if (isClosed) return;
      subredditPageRepository.getIfMod(subredditId).then((value) {
        if (value) {
          emit(Moderator());
        } else {
          emit(NotModerator());
        }
      });
    }
  }
}
