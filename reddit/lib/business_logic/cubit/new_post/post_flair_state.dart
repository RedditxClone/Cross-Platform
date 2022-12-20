part of 'post_flair_cubit.dart';

@immutable
abstract class PostFlairState {}

class PostFlairCubitInitial extends PostFlairState {}

class UIChanged extends PostFlairState {}

class FlairChanged extends PostFlairState {}

class CreatePostCreateBloc extends PostFlairState {}

class CancelButtonPressed extends PostFlairState {}

class ApplyButtonPressed extends PostFlairState {}
