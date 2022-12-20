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
    subredditPageRepository.leaveSubreddit(subredditId).then((value) {
      if (value) {
        emit(JoinedSubreddit());
      } else {
        emit(FailedToJoin());
      }
    });
  }

  void getSubredditInfo(String subredditName) {
    emit(SubredditPageLoading());
    subredditPageRepository.getSubredditInfo(subredditName).then((value) {
      _subredditModel = value;
      print("subredditModel in cubit " + _subredditModel.toString());
      print(_subredditModel!.name);
      emit(SubredditPageLoaded(_subredditModel!));
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

  void updateSubredditIcon(String subredditName, Uint8List? pickedImage) {
    emit(SubredditIconUpdating());
    if (pickedImage == null) {
      emit(SubredditIconUpdateFailed());
    } else {
      subredditPageRepository.updateSubredditIcon(subredditName, pickedImage);
      // subredditPageRepository.getSubredditIcon(subredditName);
    }
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
    final ifJoined = await subredditPageRepository.getIfJoined(subredditId);
    if (ifJoined) {
      emit(InSubreddit());
    } else {
      emit(OutSubreddit());
    }
  }

  getIfMod(String subredditId) async {
    if (isClosed) return;
    final ifMod = await subredditPageRepository.getIfMod(subredditId);
    if (ifMod) {
      emit(Moderator());
    } else {
      emit(NotModerator());
    }
  }
}
