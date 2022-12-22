import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/posts/post_actions_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';
import 'package:reddit/data/web_services/posts/post_actions_web_services.dart';

class MockPostActionsWebService extends Mock implements PostActionsWebServices {
}

void main() async {
  late MockPostActionsWebService mockPostActionsWebService;
  late PostActionsRepository postActionsRepository;
  late PostActionsCubit postActionsCubit;

  group("Posts actions state test", () {
    setUp(() {
      mockPostActionsWebService = MockPostActionsWebService();
      postActionsRepository = PostActionsRepository(mockPostActionsWebService);
      postActionsCubit = PostActionsCubit(postActionsRepository);
    });
    group("Signed out", () {
      blocTest<PostActionsCubit, PostActionsState>(
        'Post hide state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.hidePost("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return postActionsCubit;
        },
        act: (PostActionsCubit cubit) {
          cubit.hidePost("123");
        },
        expect: () => [isA<PostActionsError>()],
      );
      // Calling hidePost() function returns the correct state
      blocTest<PostActionsCubit, PostActionsState>(
        'Post unhide state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.unhidePost("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return postActionsCubit;
        },
        act: (PostActionsCubit cubit) {
          cubit.unhidePost("123");
        },
        expect: () => [isA<PostActionsError>()],
      );
      // Calling spamPost() function returns the correct state
      blocTest<PostActionsCubit, PostActionsState>(
        'Post spam state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.spamPost("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return postActionsCubit;
        },
        act: (PostActionsCubit cubit) {
          cubit.spamPost("123");
        },
        expect: () => [isA<PostActionsError>()],
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
      blocTest<PostActionsCubit, PostActionsState>(
        'Post hide state emitted correctly when user is logged in and server responded with success',
        setUp: () {
          when(() => mockPostActionsWebService.hidePost("123")).thenAnswer(
            (_) async => 201,
          );
        },
        build: () {
          return postActionsCubit;
        },
        act: (PostActionsCubit cubit) {
          cubit.hidePost("123");
        },
        expect: () => [isA<PostHidden>()],
      );
    });
    blocTest<PostActionsCubit, PostActionsState>(
      'Post unhide state emitted correctly when user is logged in and server responded with success',
      setUp: () {
        when(() => mockPostActionsWebService.unhidePost("123")).thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return postActionsCubit;
      },
      act: (PostActionsCubit cubit) {
        cubit.unhidePost("123");
      },
      expect: () => [isA<PostUnhidden>()],
    );
    blocTest<PostActionsCubit, PostActionsState>(
      'Post spam state emitted correctly when user is logged in and server responded with success',
      setUp: () {
        when(() => mockPostActionsWebService.spamPost("123")).thenAnswer(
          (_) async => 201,
        );
      },
      build: () {
        return postActionsCubit;
      },
      act: (PostActionsCubit cubit) {
        cubit.spamPost("123");
      },
      expect: () => [isA<Spammed>()],
    );
  });
}
