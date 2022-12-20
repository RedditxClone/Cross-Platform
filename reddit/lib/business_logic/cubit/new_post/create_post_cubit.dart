import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/subreddit_model.dart';

import '../../../data/model/post_model.dart';
import '../../../data/repository/new_post_repository.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  late CreatePostRepository createPostRepository;
  CreatePostCubit(this.createPostRepository) : super(CreatePostInitial());

  void submitPost(PostModel postModel) async {
    if (isClosed) return;
    final ifCreated = await createPostRepository.submitPost(postModel);
    if (ifCreated) {
      emit(CreatePostCreated());
      print("submitted successfully=============");
    } else {
      emit(CreatePostFailedToCreate());
    }
  }

  void getUserJoinedSubreddits() async {
    if (isClosed) return;
    final userJoinedSubreddits =
        await createPostRepository.getUserJoinedSubreddits();
    emit(UserJoinedSubredditsUploaded(userJoinedSubreddits));
  }

  void uIChanged() {
    if (isClosed) return;
    emit(UIChanged());
  }

  void nextButtonPressed() {
    if (isClosed) return;
    emit(NextButtonPressed());
  }

  void createBloc() {
    if (isClosed) return;
    emit(CreatePostCreateBloc());
  }

  void createButtonPressed() {
    if (isClosed) return;
    emit(CreatePostPressed());
  }

  void postButtonPressed() {}
}
