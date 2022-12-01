part of 'create_community_cubit.dart';

@immutable
abstract class CreateCommunityState {}

class CreateCommunityInitial extends CreateCommunityState {}
class CreateCommunityCreateBloc extends CreateCommunityState {
    final CreateCommunityModel createCommunityModel;
  CreateCommunityCreateBloc(this.createCommunityModel);

}
class CreateCommunityNameUnAvailable extends CreateCommunityState {}

class CreateCommunityNameAvailable extends CreateCommunityState {}

class CreateCommunityNameChange extends CreateCommunityState {}

class CreateCommunityTypeChange extends CreateCommunityState {}

class CreateCommunityAbove18Change extends CreateCommunityState {}

class CreateCommunityPressed extends CreateCommunityState {}

class CreateCommunityCreated extends CreateCommunityState {}
class CreateCommunityFailedToCreate extends CreateCommunityState {}

