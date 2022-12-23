import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/posts/posts_home_cubit.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';
import 'package:reddit/data/web_services/posts/posts_web_services.dart';

class MockPostsWebService extends Mock implements PostsWebServices {}

void main() {
  late MockPostsWebService mockPostsWebService;
  late PostsRepository postsHomeRepository;
  late PostsHomeCubit postsHomeCubit;
  const postsFromWebServices = [
    {
      "_id": "",
      "text": "",
      "votesCount": 0,
      "userId": "",
      "spammedBy": null,
      "spammedAt": null,
      "removedBy": null,
      "removedAt": null,
      "editCheckedBy": null,
      "commentCount": 0,
      "insightsCount": 0,
      "title": "New post",
      "nsfw": false,
      "spoiler": false,
      "commentsLocked": false,
      "approvedBy": null,
      "approvedAt": null,
      "postType": "text",
      "type": "Post",
      "publishedDate": "2022-12-22T14:25:50.435Z",
      "user": {
        "id": "",
        "photo": "",
        "username": "",
        "name": "",
        "isFollowed": false,
        "cakeDay": true
      },
      "replyNotifications": false,
      "images": [],
      "voteType": null,
      "isSaved": false,
      "subredditInfo": {
        "id": "",
        "name": "",
        "isJoin": true,
        "joinDate": null,
        "membersCount": 0,
        "isModerator": false
      }
    }
  ];
  final postsModelTest = PostsModel(
    sId: "",
    text: "",
    votesCount: 0,
    userId: "",
    spammedBy: null,
    spammedAt: null,
    removedBy: null,
    removedAt: null,
    editCheckedBy: null,
    commentCount: 0,
    title: "New post",
    nsfw: false,
    spoiler: false,
    commentsLocked: false,
    approvedBy: null,
    approvedAt: null,
    type: "Post",
    publishedDate: "2022-12-22T14:25:50.435Z",
    user: PostUser(
        id: "", photo: "", username: "", isFollowed: false, cakeDay: true),
    replyNotifications: false,
    images: [],
    voteType: null,
    isSaved: false,
    subreddit:
        PostSubreddit(id: "", name: "", isJoin: true, isModerator: false),
  );
  var postsFromRepository = <PostsModel>[];
  postsFromRepository.add(postsModelTest);

  group("Posts home state test", () {
    setUp(() {
      mockPostsWebService = MockPostsWebService();
      postsHomeRepository = PostsRepository(mockPostsWebService);
      postsHomeCubit = PostsHomeCubit(postsHomeRepository);
    });
    // Calling getTimelinePosts() function returns the correct state
    // PostsLoading means that the request is sent and we are waiting for the response
    // PostsLoaded means that the response is received and UI is built based on this responce
    blocTest<PostsHomeCubit, PostsHomeState>(
      'Posts in home page loaded state is emitted correctly after getting posts from server',
      setUp: () {
        when(() => mockPostsWebService.getTimelinePosts("hot", 1, 20))
            .thenAnswer(
          (_) async => postsFromWebServices,
        );
      },
      build: () {
        return postsHomeCubit;
      },
      act: (PostsHomeCubit cubit) =>
          cubit.getTimelinePosts(sort: "hot", page: 1, limit: 20),
      expect: () => [isA<PostsLoading>(), isA<PostsLoaded>()],
    );
  });
  PostsModel modelFromJson;
  // Test if mapping from Json to model is correct
  group('Posts model test', () {
    test('Posts home Model is generated correctly', () {
      modelFromJson =
          postsFromWebServices.map((e) => PostsModel.fromJson(e)).toList()[0];
      expect(modelFromJson.sId, postsModelTest.sId);
      expect(modelFromJson.approvedAt, postsModelTest.approvedAt);
      expect(modelFromJson.approvedBy, postsModelTest.approvedBy);
      expect(modelFromJson.commentCount, postsModelTest.commentCount);
      expect(modelFromJson.commentsLocked, postsModelTest.commentsLocked);
      expect(modelFromJson.editCheckedBy, postsModelTest.editCheckedBy);
      expect(modelFromJson.flair, postsModelTest.flair);
      expect(modelFromJson.images, postsModelTest.images);
      expect(modelFromJson.isSaved, postsModelTest.isSaved);
      expect(modelFromJson.nsfw, postsModelTest.nsfw);
      expect(modelFromJson.postId, postsModelTest.postId);
      expect(modelFromJson.publishedDate, postsModelTest.publishedDate);
      expect(modelFromJson.removedAt, postsModelTest.removedAt);
      expect(modelFromJson.removedBy, postsModelTest.removedBy);
      expect(
          modelFromJson.replyNotifications, postsModelTest.replyNotifications);
      expect(modelFromJson.spammedAt, postsModelTest.spammedAt);
      expect(modelFromJson.spammedBy, postsModelTest.spammedBy);
      expect(modelFromJson.spoiler, postsModelTest.spoiler);
      expect(modelFromJson.subreddit!.id, postsModelTest.subreddit!.id);
      expect(modelFromJson.subreddit!.isJoin, postsModelTest.subreddit!.isJoin);
      expect(modelFromJson.subreddit!.isModerator,
          postsModelTest.subreddit!.isModerator);
      expect(modelFromJson.subreddit!.name, postsModelTest.subreddit!.name);
      expect(modelFromJson.text, postsModelTest.text);
      expect(modelFromJson.title, postsModelTest.title);
      expect(modelFromJson.type, postsModelTest.type);
      expect(modelFromJson.user!.cakeDay, postsModelTest.user!.cakeDay);
      expect(modelFromJson.user!.id, postsModelTest.user!.id);
      expect(modelFromJson.user!.isFollowed, postsModelTest.user!.isFollowed);
      expect(modelFromJson.user!.photo, postsModelTest.user!.photo);
      expect(modelFromJson.user!.username, postsModelTest.user!.username);
      expect(modelFromJson.userId, postsModelTest.userId);
      expect(modelFromJson.visited, postsModelTest.visited);
      expect(modelFromJson.voteType, postsModelTest.voteType);
      expect(modelFromJson.votesCount, postsModelTest.votesCount);
    });
  });
}
