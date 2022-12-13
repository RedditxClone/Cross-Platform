import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository postsRepository;

  List<PostsModel>? posts;
  PostsCubit(this.postsRepository) : super(PostsInitial());

  /// This function emits:
  /// state [PostsLoading] to indicate that data is loading from the server.
  /// state [PostsLoaded] when account settings is loaded successfully.
  /// This function is called inside the initState of the account settings screens.
  /// This function calls the function [AccountSettingsRepository.getAccountSettings] to get the user's account settings.
  void getTimelinePosts() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    emit(PostsLoading());
    postsRepository.getTimelinePosts().then((posts) {
      // start the state existing in characters_state
      // here you sent characters list to characters loaded state
      emit(PostsLoaded(posts));
      this.posts = posts;
    });
  }
}
