import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
  late VoteCubit voteCubit;
  final votesFromWebServices = {"votesCount": 1};
  final voteModelTest = VoteModel(votesCount: 1);
  group("Vote post/comment state test", () {
    setUp(() {
      mockPostActionsWebService = MockPostActionsWebService();
      postActionsRepository = PostActionsRepository(mockPostActionsWebService);
      voteCubit = VoteCubit(postActionsRepository);
    });
    group("Signed out", () {
      blocTest<VoteCubit, VoteState>(
        'Up vote state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.upVote("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return voteCubit;
        },
        act: (VoteCubit cubit) {
          cubit.upVote("123");
        },
        expect: () => [isA<VoteError>()],
      );
      // Calling hidePost() function returns the correct state
      blocTest<VoteCubit, VoteState>(
        'Unvote state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.unVote("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return voteCubit;
        },
        act: (VoteCubit cubit) {
          cubit.unVote("123");
        },
        expect: () => [isA<VoteError>()],
      );
      // Calling spamPost() function returns the correct state
      blocTest<VoteCubit, VoteState>(
        'Down vote state emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockPostActionsWebService.downVote("123")).thenAnswer(
            (_) async => 403,
          );
        },
        build: () {
          return voteCubit;
        },
        act: (VoteCubit cubit) {
          cubit.downVote("123");
        },
        expect: () => [isA<VoteError>()],
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
      blocTest<VoteCubit, VoteState>(
        'Up vote emitted correctly when user is logged in and server responded with success',
        setUp: () {
          when(() => mockPostActionsWebService.upVote("123")).thenAnswer(
            (_) async => votesFromWebServices,
          );
        },
        build: () {
          return voteCubit;
        },
        act: (VoteCubit cubit) {
          cubit.upVote("123");
        },
        expect: () => [isA<UpVoted>()],
      );
      blocTest<VoteCubit, VoteState>(
        'Unvote state emitted correctly when user is logged in and server responded with success',
        setUp: () {
          when(() => mockPostActionsWebService.unVote("123")).thenAnswer(
            (_) async => votesFromWebServices,
          );
        },
        build: () {
          return voteCubit;
        },
        act: (VoteCubit cubit) {
          cubit.unVote("123");
        },
        expect: () => [isA<UnVoted>()],
      );
      blocTest<VoteCubit, VoteState>(
        'Down vote state emitted correctly when user is logged in and server responded with success',
        setUp: () {
          when(() => mockPostActionsWebService.downVote("123")).thenAnswer(
            (_) async => votesFromWebServices,
          );
        },
        build: () {
          return voteCubit;
        },
        act: (VoteCubit cubit) {
          cubit.downVote("123");
        },
        expect: () => [isA<DownVoted>()],
      );
    });
  });
  VoteModel modelFromJson;

  group('Votes model test', () {
    test('Votes Model is generated correctly', () {
      modelFromJson = VoteModel.fromJson(votesFromWebServices);
      expect(modelFromJson.votesCount, voteModelTest.votesCount);
    });
  });
}
