import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/left_drawer/left_drawer_cubit.dart';
import 'package:reddit/data/model/left_drawer/following_users_drawer_model.dart';
import 'package:reddit/data/model/left_drawer/joined_subreddits_drawer_model.dart';
import 'package:reddit/data/model/left_drawer/moderating_subreddits_left_drawer_model.dart';
import 'package:reddit/data/repository/left_drawer/left_drawer_repository.dart';
import 'package:reddit/data/web_services/left_drawer/left_drawer_web_services.dart';

class MockLeftDrawerWebService extends Mock implements LeftDrawerWebServices {}

void main() {
  late MockLeftDrawerWebService mockLeftDrawerWebService;
  late LeftDrawerRepository leftDrawerRepository;
  late LeftDrawerCubit leftDrawerCubit;
  const followingFromWebServices = {
    "data": [
      {"_id": "", "username": "", "profilePhoto": ""}
    ],
    "meta": {
      "page": 1,
      "limit": 15,
      "itemCount": 3,
      "pageCount": 1,
      "hasPreviousPage": false,
      "hasNextPage": false
    }
  };
  const moderatingCommunitiesFromWebServices = [
    {
      "_id": "",
      "name": "",
      "over18": false,
      "flairList": [],
      "categories": [],
      "createdDate": "2022-12-15T06:27:30.805Z",
      "users": 0,
    }
  ];
  const joinedCommunitiesFromWebServices = [
    {
      "_id": "",
      "name": "",
      "type": "public",
      "usersPermissions": 0,
      "acceptPostingRequests": false,
      "allowPostCrosspost": true,
      "collapseDeletedComments": false,
      "commentScoreHideMins": 0,
      "archivePosts": false,
      "allowMultipleImages": true,
      "spoilersEnabled": true,
      "suggestedCommentSort": "None",
      "acceptFollowers": true,
      "over18": false,
      "allowImages": true,
      "allowVideos": true,
      "acceptingRequestsToJoin": true,
      "communityTopics": [],
      "requirePostFlair": false,
      "postTextBodyRule": 0,
      "restrictPostTitleLength": false,
      "banPostBodyWords": false,
      "postBodyBannedWords": [],
      "banPostTitleWords": false,
      "postTitleBannedWords": [],
      "requireWordsInPostTitle": false,
      "postGuidelines": "",
      "welcomeMessageEnabled": false,
      "flairList": [],
      "moderators": [],
      "categories": [],
      "__v": 0,
      "description": "This is a new Description",
      "users": 0
    }
  ];

  final followingModelTest = FollowingUsersDrawerModel(
    data: [Data(sId: "", username: "", profilePhoto: "")],
    meta: Meta(
        page: 1,
        limit: 15,
        itemCount: 3,
        pageCount: 1,
        hasPreviousPage: false,
        hasNextPage: false),
  );
  final moderatingCommunitiesModelTest = ModeratingSubredditsDrawerModel(
    sId: "",
    name: "",
    over18: false,
    flairList: [],
    categories: [],
    createdDate: "2022-12-15T06:27:30.805Z",
    users: 0,
  );
  final joinedCommunitiesModelTest = JoinedSubredditsDrawerModel(
    sId: "",
    name: "",
    type: "public",
    usersPermissions: 0,
    acceptPostingRequests: false,
    allowPostCrosspost: true,
    collapseDeletedComments: false,
    commentScoreHideMins: 0,
    archivePosts: false,
    allowMultipleImages: true,
    spoilersEnabled: true,
    suggestedCommentSort: "None",
    acceptFollowers: true,
    over18: false,
    allowImages: true,
    allowVideos: true,
    acceptingRequestsToJoin: true,
    communityTopics: [],
    requirePostFlair: false,
    postTextBodyRule: 0,
    restrictPostTitleLength: false,
    banPostBodyWords: false,
    postBodyBannedWords: [],
    banPostTitleWords: false,
    postTitleBannedWords: [],
    requireWordsInPostTitle: false,
    postGuidelines: "",
    welcomeMessageEnabled: false,
    flairList: [],
    moderators: [],
    categories: [],
    description: "This is a new Description",
  );
  // var postsFromRepository = <PostsModel>[];
  // postsFromRepository.add(postsModelTest);

  group("Left drawer state test", () {
    setUp(() {
      mockLeftDrawerWebService = MockLeftDrawerWebService();
      leftDrawerRepository = LeftDrawerRepository(mockLeftDrawerWebService);
      leftDrawerCubit = LeftDrawerCubit(leftDrawerRepository);
    });
    blocTest<LeftDrawerCubit, LeftDrawerState>(
      'Left drawer loaded state is emitted correctly after getting data from server',
      setUp: () {
        when(() => mockLeftDrawerWebService.getFollowingUsers()).thenAnswer(
          (_) async => followingFromWebServices,
        );
        when(() => mockLeftDrawerWebService.getModeratingCommunities())
            .thenAnswer(
          (_) async => moderatingCommunitiesFromWebServices,
        );
        when(() => mockLeftDrawerWebService.getYourCommunities()).thenAnswer(
          (_) async => joinedCommunitiesFromWebServices,
        );
      },
      build: () {
        return leftDrawerCubit;
      },
      act: (LeftDrawerCubit cubit) => cubit.getLeftDrawerData(),
      expect: () => [isA<LeftDrawerDataLoaded>()],
    );
  });
  FollowingUsersDrawerModel followingFromJson;
  ModeratingSubredditsDrawerModel moderatingFromJson;
  JoinedSubredditsDrawerModel joinedFromJson;
  // Test if mapping from Json to model is correct
  group('Left drawer models test', () {
    test('Following users Model is generated correctly', () {
      followingFromJson =
          FollowingUsersDrawerModel.fromJson(followingFromWebServices);
      expect(followingFromJson.data![0].profilePhoto,
          followingModelTest.data![0].profilePhoto);
      expect(followingFromJson.data![0].sId, followingModelTest.data![0].sId);
      expect(followingFromJson.data![0].username,
          followingModelTest.data![0].username);

      expect(followingFromJson.meta!.hasNextPage,
          followingModelTest.meta!.hasNextPage);
      expect(followingFromJson.meta!.hasPreviousPage,
          followingModelTest.meta!.hasPreviousPage);
      expect(followingFromJson.meta!.itemCount,
          followingModelTest.meta!.itemCount);
      expect(followingFromJson.meta!.limit, followingModelTest.meta!.limit);
      expect(followingFromJson.meta!.page, followingModelTest.meta!.page);
      expect(followingFromJson.meta!.pageCount,
          followingModelTest.meta!.pageCount);
    });
    test('Moderating subreddits Model is generated correctly', () {
      moderatingFromJson = ModeratingSubredditsDrawerModel.fromJson(
          moderatingCommunitiesFromWebServices[0]);
      expect(moderatingFromJson.sId, moderatingCommunitiesModelTest.sId);
      expect(moderatingFromJson.name, moderatingCommunitiesModelTest.name);
      expect(moderatingFromJson.over18, moderatingCommunitiesModelTest.over18);
      expect(moderatingFromJson.flairList,
          moderatingCommunitiesModelTest.flairList);
      expect(moderatingFromJson.categories,
          moderatingCommunitiesModelTest.categories);
      expect(moderatingFromJson.createdDate,
          moderatingCommunitiesModelTest.createdDate);
      expect(moderatingFromJson.users, moderatingCommunitiesModelTest.users);
    });
    test('Joined subreddits Model is generated correctly', () {
      joinedFromJson = JoinedSubredditsDrawerModel.fromJson(
          joinedCommunitiesFromWebServices[0]);
      expect(joinedFromJson.sId, joinedCommunitiesModelTest.sId);
      expect(joinedFromJson.name, joinedCommunitiesModelTest.name);
      expect(joinedFromJson.over18, joinedCommunitiesModelTest.over18);
      expect(joinedFromJson.flairList, joinedCommunitiesModelTest.flairList);
      expect(joinedFromJson.categories, joinedCommunitiesModelTest.categories);
      expect(joinedFromJson.acceptFollowers,
          joinedCommunitiesModelTest.acceptFollowers);
      expect(joinedFromJson.acceptPostingRequests,
          joinedCommunitiesModelTest.acceptPostingRequests);
      expect(joinedFromJson.acceptingRequestsToJoin,
          joinedCommunitiesModelTest.acceptingRequestsToJoin);
      expect(
          joinedFromJson.allowImages, joinedCommunitiesModelTest.allowImages);
      expect(joinedFromJson.allowMultipleImages,
          joinedCommunitiesModelTest.allowMultipleImages);
      expect(joinedFromJson.allowPostCrosspost,
          joinedCommunitiesModelTest.allowPostCrosspost);
      expect(
          joinedFromJson.allowVideos, joinedCommunitiesModelTest.allowVideos);
      expect(
          joinedFromJson.archivePosts, joinedCommunitiesModelTest.archivePosts);
      expect(joinedFromJson.banPostBodyWords,
          joinedCommunitiesModelTest.banPostBodyWords);
      expect(joinedFromJson.banPostTitleWords,
          joinedCommunitiesModelTest.banPostTitleWords);
      expect(joinedFromJson.collapseDeletedComments,
          joinedCommunitiesModelTest.collapseDeletedComments);
      expect(joinedFromJson.commentScoreHideMins,
          joinedCommunitiesModelTest.commentScoreHideMins);
      expect(joinedFromJson.communityTopics,
          joinedCommunitiesModelTest.communityTopics);
      expect(
          joinedFromJson.description, joinedCommunitiesModelTest.description);
      expect(joinedFromJson.flairList, joinedCommunitiesModelTest.flairList);
      expect(joinedFromJson.moderators, joinedCommunitiesModelTest.moderators);
      expect(joinedFromJson.name, joinedCommunitiesModelTest.name);
      expect(joinedFromJson.over18, joinedCommunitiesModelTest.over18);
      expect(joinedFromJson.postBodyBannedWords,
          joinedCommunitiesModelTest.postBodyBannedWords);
      expect(joinedFromJson.postGuidelines,
          joinedCommunitiesModelTest.postGuidelines);
      expect(joinedFromJson.postTextBodyRule,
          joinedCommunitiesModelTest.postTextBodyRule);
      expect(joinedFromJson.postTitleBannedWords,
          joinedCommunitiesModelTest.postTitleBannedWords);
      expect(joinedFromJson.requirePostFlair,
          joinedCommunitiesModelTest.requirePostFlair);
      expect(joinedFromJson.requireWordsInPostTitle,
          joinedCommunitiesModelTest.requireWordsInPostTitle);
      expect(joinedFromJson.restrictPostTitleLength,
          joinedCommunitiesModelTest.restrictPostTitleLength);

      expect(joinedFromJson.spoilersEnabled,
          joinedCommunitiesModelTest.spoilersEnabled);
      expect(joinedFromJson.suggestedCommentSort,
          joinedCommunitiesModelTest.suggestedCommentSort);
      expect(joinedFromJson.type, joinedCommunitiesModelTest.type);
      expect(joinedFromJson.usersPermissions,
          joinedCommunitiesModelTest.usersPermissions);
      expect(joinedFromJson.welcomeMessageEnabled,
          joinedCommunitiesModelTest.welcomeMessageEnabled);
    });
  });
}
