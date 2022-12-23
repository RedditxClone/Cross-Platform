import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/new_post_repository.dart';

part 'post_to_state.dart';

class PostToCubit extends Cubit<PostToState> {
  PostToCubit(this.createPostRepository) : super(PostToCubitInitial());
  late CreatePostRepository createPostRepository;

  void getUserJoinedSubreddits() async {
    if (isClosed) return;
    emit(UserJoinedSubredditsUploading());
    final userJoinedSubreddits =
        await createPostRepository.getUserJoinedSubreddits();
    emit(UserJoinedSubredditsUploaded(
        kIsWeb ? userJoinedSubreddits.toSet() : userJoinedSubreddits));
  }

  void uIChanged() {
    if (isClosed) return;
    emit(UIChanged());
  }

  void createBloc() {}
}
