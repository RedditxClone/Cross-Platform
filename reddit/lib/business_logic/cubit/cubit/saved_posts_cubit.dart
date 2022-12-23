import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/repository/saved_posts_repo.dart';
import 'package:reddit/data/model/saved_posts_model.dart';

part 'saved_posts_state.dart';

class SavedPostsCubit extends Cubit<SavedPostsState> {
  late List<SavedPostsModel> savedPosts;
  final SavedPostsRepository savedPostsRepository;

  SavedPostsCubit(this.savedPostsRepository) : super(SavedPostsInitial());

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
