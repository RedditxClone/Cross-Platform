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
  List<LeftDrawerModel> favorites = <LeftDrawerModel>[];
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
      favorites.clear();
      for (var i = 0; i < yourCommunities!.length; i++) {
        if (yourCommunities![i].favorite!) {
          favorites.add(yourCommunities![i]);
        }
      }
      for (var i = 0; i < following!.length; i++) {
        if (following![i].favorite!) {
          favorites.add(following![i]);
        }
      }
      // for (var i = 0; i < moderatingCommunities!.length; i++) {
      //   if (moderatingCommunities![i].favorite!) {
      //     favorites.add(following![i]);
      //   }
      // }
      emit(LeftDrawerDataLoaded(
          moderatingCommunities!, yourCommunities!, following!, favorites));
    });
  }

  void addToFavorites(LeftDrawerModel leftDrawerModel) {
    favorites.add(leftDrawerModel);

    for (var i = 0; i < yourCommunities!.length; i++) {
      if (yourCommunities![i].name == leftDrawerModel.name) {
        yourCommunities![i].favorite = true;
      }
    }
    for (var i = 0; i < moderatingCommunities!.length; i++) {
      if (moderatingCommunities![i].name == leftDrawerModel.name) {
        moderatingCommunities![i].favorite = true;
      }
    }
    for (var i = 0; i < following!.length; i++) {
      if (following![i].name == leftDrawerModel.name) {
        following![i].favorite = true;
      }
    }
    emit(LeftDrawerDataLoaded(
        moderatingCommunities!, yourCommunities!, following!, favorites));
  }

  void removeFromFavorites(LeftDrawerModel leftDrawerModel) {
    favorites.remove(leftDrawerModel);
    for (var i = 0; i < yourCommunities!.length; i++) {
      if (yourCommunities![i].name == leftDrawerModel.name) {
        yourCommunities![i].favorite = false;
      }
    }
    for (var i = 0; i < moderatingCommunities!.length; i++) {
      if (moderatingCommunities![i].name == leftDrawerModel.name) {
        moderatingCommunities![i].favorite = false;
      }
    }
    for (var i = 0; i < following!.length; i++) {
      if (following![i].name == leftDrawerModel.name) {
        following![i].favorite = false;
      }
    }

    emit(LeftDrawerDataLoaded(
        moderatingCommunities!, yourCommunities!, following!, favorites));
  }
}
