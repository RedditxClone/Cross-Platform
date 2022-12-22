import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/posts/save_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/vote_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/posts/vote_model.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';
import 'package:reddit/data/web_services/posts/post_actions_web_services.dart';

class MockPostActionsWebService extends Mock implements PostActionsWebServices {
}

void main() async {
  late MockPostActionsWebService mockPostActionsWebService;
  late PostActionsRepository postActionsRepository;
  late SaveCubit saveCubit;

  group("Save post state test", () {
    setUp(() {
      mockPostActionsWebService = MockPostActionsWebService();
      postActionsRepository = PostActionsRepository(mockPostActionsWebService);
      saveCubit = SaveCubit(postActionsRepository);
    });
    group("Signed out", () {
      blocTest<SaveCubit, SaveState>(
        'Save state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.savePost("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return saveCubit;
        },
        act: (SaveCubit cubit) {
          cubit.savePost("123");
        },
        expect: () => [isA<SaveError>()],
      );
      blocTest<SaveCubit, SaveState>(
        'Unsave Post state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.unsavePost("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return saveCubit;
        },
        act: (SaveCubit cubit) {
          cubit.unsavePost("123");
        },
        expect: () => [isA<UnsaveError>()],
      );
    });
    group("Signed in", () {
      setUp(() {
        UserData.initUser({
          "token": "",
          "dontNotifyIds": [],
          "_id": "",
          "username": "",
          "email": "b",
          "authType": "user",
          "profilePhoto": "",
          "coverPhoto": "",
          "countryCode": "",
          "gender": "",
          "accountClosed": false,
          "displayName": "",
          "about": "",
          "socialLinks": [],
          "nsfw": false,
          "allowFollow": true,
          "contentVisibility": true,
          "activeInCommunitiesVisibility": false,
          "badCommentAutoCollapse": "off",
          "showInSearch": true,
          "adultContent": false,
          "autoPlayMedia": true,
          "personalizeAllOfReddit": true,
          "personalizeAdsInformation": true,
          "personalizeAdsYourActivity": true,
          "personalizeRecGeneralLocation": true,
          "personalizeRecOurPartners": true,
          "useTwoFactorAuthentication": true,
          "suggestedSort": "hot",
          "inboxMessages": true,
          "mentions": true,
          "commentsOnPost": true,
          "upvotePosts": true,
          "upvoteComments": true,
          "repliesComments": true,
          "activityComments": true,
          "activityOnThreads": true,
          "newFollowers": true,
          "newPostFlair": true,
          "newUserFlair": true,
          "pinnedPosts": true,
          "postsYouFollow": true,
          "commentsYouFollow": true,
          "redditAnnouncements": true,
          "cakeDay": true,
          "acceptPms": "everyone",
          "whitelisted": [],
          "safeBrowsingMode": false,
          "chatRequest": true,
          "newFollower": false,
          "unSubscribe": false,
          "savedPosts": [],
          "createdAt": "2022-12-22T18:24:10.012Z"
        });
      });

      blocTest<SaveCubit, SaveState>(
        'Save state emitted correctly when user is logged in and server responded with success',
        setUp: () {
          when(() => mockPostActionsWebService.savePost("123")).thenAnswer(
            (_) async => 200,
          );
        },
        build: () {
          return saveCubit;
        },
        act: (SaveCubit cubit) {
          cubit.savePost("123");
        },
        expect: () => [isA<Saved>()],
      );
      blocTest<SaveCubit, SaveState>(
        'Unsave state emitted correctly when user is logged in and server responded with success',
        setUp: () {
          when(() => mockPostActionsWebService.unsavePost("123")).thenAnswer(
            (_) async => 200,
          );
        },
        build: () {
          return saveCubit;
        },
        act: (SaveCubit cubit) {
          cubit.unsavePost("123");
        },
        expect: () => [isA<Unsaved>()],
      );
    });
  });
}
