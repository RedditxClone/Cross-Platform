import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/posts/remove_post_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';
import 'package:reddit/data/web_services/posts/post_actions_web_services.dart';

class MockPostActionsWebService extends Mock implements PostActionsWebServices {
}

void main() async {
  late MockPostActionsWebService mockPostActionsWebService;
  late PostActionsRepository postActionsRepository;
  late RemovePostCubit removePostCubit;

  group("Remove posts state test", () {
    setUp(() {
      mockPostActionsWebService = MockPostActionsWebService();
      postActionsRepository = PostActionsRepository(mockPostActionsWebService);
      removePostCubit = RemovePostCubit(postActionsRepository);
    });
    group("Signed out", () {
      blocTest<RemovePostCubit, RemovePostState>(
        'Post hide state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.hidePost("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return removePostCubit;
        },
        act: (RemovePostCubit cubit) {
          cubit.hidePost("123");
        },
        expect: () => [isA<RemovePostError>()],
      );
      blocTest<RemovePostCubit, RemovePostState>(
        'Post unhide state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.unhidePost("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return removePostCubit;
        },
        act: (RemovePostCubit cubit) {
          cubit.unhidePost("123");
        },
        expect: () => [isA<RemovePostError>()],
      );
      // Calling spamPost() function returns the correct state
      blocTest<RemovePostCubit, RemovePostState>(
        'Post delete state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.deletePost("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return removePostCubit;
        },
        act: (RemovePostCubit cubit) {
          cubit.deletePost("123");
        },
        expect: () => [isA<RemovePostError>()],
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
      blocTest<RemovePostCubit, RemovePostState>(
        'Post hide state emitted correctly  when user is logged in',
        setUp: () {
          when(() => mockPostActionsWebService.hidePost("123")).thenAnswer(
            (_) async => 201,
          );
        },
        build: () {
          return removePostCubit;
        },
        act: (RemovePostCubit cubit) {
          cubit.hidePost("123");
        },
        expect: () => [isA<Hidden>()],
      );
      blocTest<RemovePostCubit, RemovePostState>(
        'Post unhide state emitted correctly when user is logged in',
        setUp: () {
          when(() => mockPostActionsWebService.unhidePost("123")).thenAnswer(
            (_) async => 201,
          );
        },
        build: () {
          return removePostCubit;
        },
        act: (RemovePostCubit cubit) {
          cubit.unhidePost("123");
        },
        expect: () => [isA<Unhidden>()],
      );
      // Calling spamPost() function returns the correct state
      blocTest<RemovePostCubit, RemovePostState>(
        'Post delete state emitted correctly when user is logged in',
        setUp: () {
          when(() => mockPostActionsWebService.deletePost("123")).thenAnswer(
            (_) async => 200,
          );
        },
        build: () {
          return removePostCubit;
        },
        act: (RemovePostCubit cubit) {
          cubit.deletePost("123");
        },
        expect: () => [isA<Deleted>()],
      );
    });
  });
}
