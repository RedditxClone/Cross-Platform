import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/left_drawer/left_drawer_model.dart';

import '../../../data/repository/left_drawer/left_drawer_repository.dart';

part 'left_drawer_state.dart';

class LeftDrawerCubit extends Cubit<LeftDrawerState> {
  final LeftDrawerRepository leftDrawerRepository;
  List<LeftDrawerModel>? moderatingCommunities;
  List<LeftDrawerModel>? yourCommunities;
  List<LeftDrawerModel>? following;
  List<LeftDrawerModel> favorites = [];
  LeftDrawerCubit(this.leftDrawerRepository) : super(LeftDrawerInitial());
  void getLeftDrawerData() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    // emit(moderatingCommunitiesLoading());
    FutureGroup futureGroup = FutureGroup();
    futureGroup.add(leftDrawerRepository.getModeratingCommunities());
    futureGroup.add(leftDrawerRepository.getYourCommunities());
    futureGroup.add(leftDrawerRepository.getFollowingUsers());
    futureGroup.close();
    futureGroup.future.then((value) {
      moderatingCommunities = value[0];
      yourCommunities = value[1];
      following = value[2];
      emit(LeftDrawerDataLoaded(
          moderatingCommunities!, yourCommunities!, following!));
    });
  }

  void getModeratingCommunities() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    // emit(moderatingCommunitiesLoading());
    leftDrawerRepository
        .getModeratingCommunities()
        .then((moderatingCommunities) {
      // start the state existing in characters_state
      // here you sent characters list to characters loaded state
      emit(ModeratingCommunitiesLoaded(moderatingCommunities));
      this.moderatingCommunities = moderatingCommunities;
    });
  }

  void getYourCommunities() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    // emit(moderatingCommunitiesLoading());
    leftDrawerRepository.getYourCommunities().then((yourCommunities) {
      // start the state existing in characters_state
      // here you sent characters list to characters loaded state
      emit(YourCommunitiesLoaded(yourCommunities));
      this.yourCommunities = yourCommunities;
    });
  }

  void getFollowingUsers() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    // emit(moderatingCommunitiesLoading());
    leftDrawerRepository.getFollowingUsers().then((following) {
      // start the state existing in characters_state
      // here you sent characters list to characters loaded state
      emit(FollowingUsersLoaded(following));
      this.following = following;
    });
  }

  void getFavourites() {
    // To avoid state error when you leave the settings page
    if (isClosed) return;
    // emit(moderatingCommunitiesLoading());
    leftDrawerRepository.getFollowingUsers().then((following) {
      // start the state existing in characters_state
      // here you sent characters list to characters loaded state
      emit(FollowingUsersLoaded(following));
      this.following = following;
    });
  }
}
