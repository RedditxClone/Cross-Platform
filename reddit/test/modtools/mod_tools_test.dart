import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/modtools/taffic_stats_model.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/modtools/modtools_repository.dart';
import 'package:reddit/data/web_services/modtools/modtools_webservices.dart';

class MockModtoolsWebService extends Mock implements ModToolsWebServices {}

class MockModtoolsCubit extends MockCubit<ModtoolsState>
    implements ModtoolsCubit {}

void main() async {
  late MockModtoolsWebService mockModtoolsWebService;
  late ModToolsRepository modToolsRepository;
  late ModtoolsCubit modToolsCubit;
  List<Map<String, dynamic>>? postsFromWebServices;
  List<dynamic>? statisticsFromWebServices;
  List<PostsModel> postsFromRepository;
  List<TrafficStats> statisticsFromRepository;
  List<dynamic>? approvedUsersFromWebServices;
  statisticsFromRepository = [TrafficStats(date: '', joined: 0, left: 0)];
  postsFromRepository = [
    PostsModel(
      sId: "",
      text: "",
      userId: "",
      title: "",
      type: "",
      publishedDate: "",
      replyNotifications: false,
      votesCount: 0,
      commentCount: 0,
      isSaved: false,
      nsfw: false,
      spoiler: false,
      commentsLocked: false,
      editCheckedBy: null,
      voteType: null,
      approvedBy: null,
      spammedBy: null,
      spammedAt: null,
      removedBy: null,
      removedAt: null,
      approvedAt: null,
      images: [],
      subreddit: PostSubreddit.fromJson({
        "id": "",
        "name": "",
        "isJoin": false,
        "joinDate": null,
        "membersCount": 0,
        "isModerator": false
      }),
      user: PostUser.fromJson({
        "id": "",
        "photo": "",
        "username": "",
        "name": "",
        "isFollowed": false,
        "cakeDay": true
      }),
    )
  ];
  group("State test", () {
    setUp(() {
      mockModtoolsWebService = MockModtoolsWebService();
      modToolsRepository = ModToolsRepository(mockModtoolsWebService);
      modToolsCubit = ModtoolsCubit(modToolsRepository);
      postsFromRepository = [
        PostsModel(
          sId: "",
          text: "",
          userId: "",
          title: "",
          type: "",
          publishedDate: "",
          replyNotifications: false,
          votesCount: 0,
          commentCount: 0,
          isSaved: false,
          nsfw: false,
          spoiler: false,
          commentsLocked: false,
          editCheckedBy: null,
          voteType: null,
          approvedBy: null,
          spammedBy: null,
          spammedAt: null,
          removedBy: null,
          removedAt: null,
          approvedAt: null,
          images: [],
          subreddit: PostSubreddit.fromJson({
            "id": "",
            "name": "",
            "isJoin": false,
            "joinDate": null,
            "membersCount": 0,
            "isModerator": false
          }),
          user: PostUser.fromJson({
            "id": "",
            "photo": "",
            "username": "",
            "name": "",
            "isFollowed": false,
            "cakeDay": true
          }),
        )
      ];
      postsFromWebServices = [
        {
          "_id": "",
          "text": "",
          "userId": "",
          "title": "",
          "type": "",
          "publishedDate": "",
          "votesCount": 0,
          "commentCount": 0,
          "nsfw": false,
          "spoiler": false,
          "commentsLocked": false,
          "isSaved": false,
          "replyNotifications": false,
          "spammedBy": null,
          "spammedAt": null,
          "removedBy": null,
          "removedAt": null,
          "editCheckedBy": null,
          "approvedBy": null,
          "approvedAt": null,
          "voteType": null,
          "images": [],
          "user": {
            "id": "",
            "photo": "",
            "username": "",
            "name": "",
            "isFollowed": false,
            "cakeDay": true
          },
          "subredditInfo": {
            "id": "",
            "name": "",
            "isJoin": false,
            "joinDate": null,
            "membersCount": 0,
            "isModerator": false
          }
        },
      ];

      statisticsFromWebServices = [
        {"date": "", "joined": 0, "left": 0}
      ];
      approvedUsersFromWebServices = [
        {
          "username": "",
          "date": "",
          "_id": "",
          "profilePhoto": "",
          "displayName": "",
          "about": ""
        }
      ];
    });
    // Calling getAccountSettings() function returns the correct state
    // AccountSettingsLoading means that the request is sent and we are waiting for the response
    // AccountSettingsLoaded means that the response is received and UI is built based on this responce
    blocTest<ModtoolsCubit, ModtoolsState>(
      'SpammedPostsReady state is emitted correctly after getting spammed posts from server',
      setUp: () {
        when(() => mockModtoolsWebService.getSpammedPosts('r/reddit'))
            .thenAnswer(
          (_) async => postsFromWebServices,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.getSpammedPosts('r/reddit'),
      expect: () => [isA<Loading>(), isA<SpammedPostsReady>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'EditedPostsReady state is emitted correctly after getting edited posts from server',
      setUp: () {
        when(() => mockModtoolsWebService.getEditedPosts('r/reddit'))
            .thenAnswer(
          (_) async => postsFromWebServices,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.getEditedPosts('r/reddit'),
      expect: () => [isA<Loading>(), isA<EditedPostsReady>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'UnmoderatedPostsReady state is emitted correctly after getting unmoderated posts from server',
      setUp: () {
        when(() => mockModtoolsWebService.getUnmoderatedPosts('r/reddit'))
            .thenAnswer(
          (_) async => postsFromWebServices,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.getUnmoderatedPosts('r/reddit'),
      expect: () => [isA<Loading>(), isA<UnmoderatedPostsReady>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'TrafficStatsAvailable state is emitted correctly after getting statistics from server',
      setUp: () {
        when(() => mockModtoolsWebService.getStatistics('r/reddit')).thenAnswer(
          (_) async => statisticsFromWebServices!,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.getStatistics('r/reddit'),
      expect: () => [isA<Loading>(), isA<TrafficStatsAvailable>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'ApprovedListAvailable state is emitted correctly after getting approved users list from server',
      setUp: () {
        when(() => mockModtoolsWebService.getApproved('subredditID'))
            .thenAnswer(
          (_) async => approvedUsersFromWebServices,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) => cubit.getApprovedUsers('subredditID'),
      expect: () => [isA<Loading>(), isA<ApprovedListAvailable>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'AddedToApprovedUsers state is emitted correctly after getting new approved users list from server',
      setUp: () {
        when(() =>
                mockModtoolsWebService.addApprovedUser('subredditID', 'user'))
            .thenAnswer(
          (_) async => 201,
        );
        when(() => mockModtoolsWebService.getApproved('subredditID'))
            .thenAnswer(
          (_) async => approvedUsersFromWebServices,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) =>
          cubit.addApprovedUser('subredditID', 'user'),
      expect: () => [isA<AddedToApprovedUsers>()],
    );
    blocTest<ModtoolsCubit, ModtoolsState>(
      'RemovedFromApprovedUsers state is emitted correctly after getting new approved users list from server',
      setUp: () {
        when(() => mockModtoolsWebService.removeApprovedUser(
            'subredditID', 'user')).thenAnswer(
          (_) async => 201,
        );
        when(() => mockModtoolsWebService.getApproved('subredditID'))
            .thenAnswer(
          (_) async => approvedUsersFromWebServices,
        );
      },
      build: () {
        return modToolsCubit;
      },
      act: (ModtoolsCubit cubit) =>
          cubit.removeApprovedUser('subredditID', 'user'),
      expect: () => [isA<RemovedFromApprovedUsers>()],
    );
  });
  // Test if mapping from Json to model is correct
  group('Model test', () {
    setUp(() {
      mockModtoolsWebService = MockModtoolsWebService();
      modToolsRepository = ModToolsRepository(mockModtoolsWebService);
      modToolsCubit = ModtoolsCubit(modToolsRepository);
      statisticsFromRepository = [TrafficStats(date: '', joined: 0, left: 0)];
      statisticsFromWebServices = [
        {"date": "", "joined": 0, "left": 0}
      ];
    });
    test('Traffic stats model is generated correctly', () {
      expect(
          statisticsFromWebServices!
              .map((i) => TrafficStats.fromJson(i))
              .toList(),
          statisticsFromRepository);
    });
  });
}
