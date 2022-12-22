import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'media_index_state.dart';

class MediaIndexCubit extends Cubit<MediaIndexState> {
  int index;
  MediaIndexCubit(this.index) : super(MediaIndexInitial(index));
  void changeMediaIndex(int index) {
    this.index = index;
    emit(MediaIndexChanged(this.index));
  }
}
