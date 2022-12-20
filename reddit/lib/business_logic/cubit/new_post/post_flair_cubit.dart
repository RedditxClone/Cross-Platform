import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/new_post_repository.dart';

part 'post_flair_state.dart';

class PostFlairCubit extends Cubit<PostFlairState> {
  late CreatePostRepository createPostRepository;
  PostFlairCubit(this.createPostRepository) : super(PostFlairCubitInitial());

  void uIChanged() {
    if (isClosed) return;
    emit(UIChanged());
  }

  void applyButtonPressed() {
    if (isClosed) return;
    emit(ApplyButtonPressed());
  }

  void createBloc() {
    if (isClosed) return;
    emit(CreatePostCreateBloc());
  }

  void cancelButtonPressed() {
    if (isClosed) return;
    emit(CancelButtonPressed());
  }

  void postButtonPressed() {}

  void flairChanged() {
    if (isClosed) return;
    emit(FlairChanged());
  }
}
