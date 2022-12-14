part of 'media_index_cubit.dart';

@immutable
abstract class MediaIndexState {}

class MediaIndexInitial extends MediaIndexState {
  int index;
  MediaIndexInitial(this.index);
}

class MediaIndexChanged extends MediaIndexState {
  int index;
  MediaIndexChanged(this.index);
}
