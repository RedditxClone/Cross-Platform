import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/left_drawer/following_users_drawer_model.dart';
import 'package:reddit/data/model/left_drawer/joined_subreddits_drawer_model.dart';
import 'package:reddit/data/model/left_drawer/moderating_subreddits_left_drawer_model.dart';

import '../../../data/repository/left_drawer/left_drawer_repository.dart';

import 'dart:developer';
part 'left_drawer_state.dart';

/// This class is responsible for getting - updating drawer data on mobile.
class LeftDrawerCubit extends Cubit<LeftDrawerState> {
  final LeftDrawerRepository leftDrawerRepository;
  List<ModeratingSubredditsDrawerModel>? moderatingCommunities;
  List<JoinedSubredditsDrawerModel>? yourCommunities;
  FollowingUsersDrawerModel? following;
  List<FollowingUsersDrawerModel> favorites = <FollowingUsersDrawerModel>[];
  LeftDrawerCubit(this.leftDrawerRepository) : super(LeftDrawerInitial());

  /// This function emits:
  /// state [LeftDrawerDataLoaded] when left drawer data (moderatingCommunities [moderatingCommunities], joined communities [yourCommunities], following users [following], favorites [favorites]) are loaded successfully.
  ///
  /// This function calls the functions:
  /// [LeftDrawerRepository.getModeratingCommunities]
  /// [LeftDrawerRepository.getYourCommunities]
  /// [LeftDrawerRepository.getFollowingUsers]
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
      // favorites.clear();
      // for (var i = 0; i < yourCommunities!.length; i++) {
      //   if (yourCommunities![i].favorite!) {
      //     favorites.add(yourCommunities![i]);
      //   }
      // }
      // for (var i = 0; i < following!.length; i++) {
      //   if (following![i].favorite!) {
      //     favorites.add(following![i]);
      //   }
      // }
      // for (var i = 0; i < moderatingCommunities!.length; i++) {
      //   if (moderatingCommunities![i].favorite!) {
      //     favorites.add(following![i]);
      //   }
      // }
      // debugPrint("$following");
      emit(LeftDrawerDataLoaded(
          moderatingCommunities!, yourCommunities!, following!, []));
    });
  }

  /// [leftDrawerModel] : the community or the user that you want to add to favorites.
  /// This function emits:
  /// state [LeftDrawerDataLoaded] when [leftDrawerModel] is added to favorites successfully.
  // void addToFavorites(LeftDrawerModel leftDrawerModel) {
  //   favorites.add(leftDrawerModel);

  //   for (var i = 0; i < yourCommunities!.length; i++) {
  //     if (yourCommunities![i].name == leftDrawerModel.name) {
  //       yourCommunities![i].favorite = true;
  //       break;
  //     }
  //   }
  //   for (var i = 0; i < moderatingCommunities!.length; i++) {
  //     if (moderatingCommunities![i].name == leftDrawerModel.name) {
  //       moderatingCommunities![i].favorite = true;
  //       break;
  //     }
  //   }
  //   for (var i = 0; i < following!.length; i++) {
  //     if (following![i].name == leftDrawerModel.name) {
  //       following![i].favorite = true;
  //       break;
  //     }
  //   }
  //   emit(LeftDrawerDataLoaded(
  //       moderatingCommunities!, yourCommunities!, following!, favorites));
  // }

  /// [leftDrawerModel] : the community or the user that you want to remove from favorites.
  /// This function emits:
  /// state [LeftDrawerDataLoaded] when [leftDrawerModel] is removed from favorites successfully.
  // void removeFromFavorites(LeftDrawerModel leftDrawerModel) {
  //   String name = leftDrawerModel.name!;
  //   for (var i = 0; i < favorites.length; i++) {
  //     if (favorites[i].name == name) {
  //       log(favorites[i].name!);
  //       favorites.removeAt(i);
  //       log("Removed from fav");
  //       break;
  //     }
  //   }
  //   for (var i = 0; i < yourCommunities!.length; i++) {
  //     if (yourCommunities![i].name == leftDrawerModel.name) {
  //       yourCommunities![i].favorite = false;
  //     }
  //   }
  //   for (var i = 0; i < moderatingCommunities!.length; i++) {
  //     if (moderatingCommunities![i].name == leftDrawerModel.name) {
  //       moderatingCommunities![i].favorite = false;
  //     }
  //   }
  //   for (var i = 0; i < following!.length; i++) {
  //     if (following![i].name == leftDrawerModel.name) {
  //       following![i].favorite = false;
  //     }
  //   }

  //   emit(LeftDrawerDataLoaded(
  //       moderatingCommunities!, yourCommunities!, following!, favorites));
  // }
}
