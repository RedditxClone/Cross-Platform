import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/saved_posts_repo.dart';
import 'package:reddit/data/model/saved_posts_model.dart';

part 'saved_posts_state.dart';

/// This Class Send Saved Posts Data from  Repo to UI using request to the endpoint `baseUrl/user/post/save` From Real API.
class SavedPostsCubit extends Cubit<SavedPostsState> {
  late List<SavedPostsModel> savedPosts;
  final SavedPostsRepository savedPostsRepository;

  SavedPostsCubit(this.savedPostsRepository) : super(SavedPostsInitial());

  ///  This function Send Saved Posts Data from  Repo to UI.
  ///
  /// This function emits:
  /// state [SavedPostsLoaded] after successfully Recieving the Data.
  /// This function calls the function [SavedPostsRepository.getAllSavedPosts] to prepare the PATCH request.
  void getAllSavedPosts() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    savedPostsRepository.getAllSavedPosts().then((savedPosts) {
      this.savedPosts = savedPosts.savedPosts!;
      print('saved Posts after Cubit');
      print(this.savedPosts.length);
      for (var savedPost in this.savedPosts) {
        print(savedPost.printfunc());
      }
      emit(SavedPostsLoaded(savedPosts.savedPosts!));
      this.savedPosts = savedPosts.savedPosts!;
    });
  }
}
