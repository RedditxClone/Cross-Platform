import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/discover_page_model.dart';
import 'package:reddit/data/repository/discover_page_repo.dart';

part 'discover_page_state.dart';

/// Cubit for Reciveng data from Repositry.
///
/// Then Sending it to UI.
class DiscoverPageCubit extends Cubit<DiscoverPageState> {
  final DiscoverPageRepository discoverPageRepository;
  late List<DiscoverPageModel> randomPostss;

  DiscoverPageCubit(this.discoverPageRepository) : super(DiscoverPageInitial());

  /// Gets Random Posts data from repository.
  /// Emits the corresponding state for UI.
  void getAllRandomPosts() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    discoverPageRepository.getAllRandomPosts().then((randomPostss) {
      // start the state existing in feed_setting_state
      // here you sent randomPostss list to randomPostss loaded state
      emit(RandomPostsLoaded(randomPostss));
      this.randomPostss = randomPostss;
    });
  }
}
