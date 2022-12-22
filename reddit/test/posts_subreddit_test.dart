import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/posts/posts_subreddit_cubit.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/posts/posts_repository.dart';
import 'package:reddit/data/web_services/posts/posts_web_services.dart';

class MockPostsWebService extends Mock implements PostsWebServices {}

void main() async {
  late MockPostsWebService mockPostsWebService;
  late PostsRepository postsHomeRepository;
  late PostsSubredditCubit postsSubredditCubit;
  const postsFromWebServices = [
    {
      "_id": "63a468ee8030bcf173731e93",
      "text": "thet is a new post",
      "votesCount": 0,
      "userId": "638f9b2231186b7fd21bae78",
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
        "id": "638f9b2231186b7fd21bae78",
        "photo": "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
        "username": "bemoi1",
        "name": "bemoi_erian",
        "isFollowed": false,
        "cakeDay": true
      },
      "replyNotifications": false,
      "images": [],
      "voteType": null,
      "isSaved": false,
      "subredditInfo": {
        "id": "639771faa875316ad8d9f3e4",
        "name": "bemoireddit",
        "isJoin": true,
        "joinDate": null,
        "membersCount": 0,
        "isModerator": false
      }
    }
  ];
  final postsModelTest = PostsModel(
    sId: "63a468ee8030bcf173731e93",
    text: "thet is a new post",
    votesCount: 0,
    userId: "638f9b2231186b7fd21bae78",
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
        id: "638f9b2231186b7fd21bae78",
        photo: "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
        username: "bemoi1",
        isFollowed: false,
        cakeDay: true),
    replyNotifications: false,
    images: [],
    voteType: null,
    isSaved: false,
    subreddit: PostSubreddit(
        id: "639771faa875316ad8d9f3e4",
        name: "bemoireddit",
        isJoin: true,
        isModerator: false),
  );

  group("Posts my profile state test", () {
    setUp(() {
      mockPostsWebService = MockPostsWebService();
      postsHomeRepository = PostsRepository(mockPostsWebService);
      postsSubredditCubit = PostsSubredditCubit(postsHomeRepository);
    });
    // Calling getMyProfilePosts() function returns the correct state
    // PostsLoading means that the request is sent and we are waiting for the response
    // PostsLoaded means that the response is received and UI is built based on this responce
    blocTest<PostsSubredditCubit, PostsSubredditState>(
      'Posts in my profile loaded state is emitted correctly after getting posts from server',
      setUp: () {
        when(() =>
                mockPostsWebService.getSubredditPosts("reddit1", "hot", 1, 20))
            .thenAnswer(
          (_) async => postsFromWebServices,
        );
      },
      build: () {
        return postsSubredditCubit;
      },
      act: (PostsSubredditCubit cubit) =>
          cubit.getSubredditPosts("reddit1", sort: "hot", page: 1, limit: 20),
      expect: () => [isA<SubredditPostsLoading>(), isA<SubredditPostsLoaded>()],
    );
  });
  // Test if mapping from Json to model is correct
  PostsModel modelFromJson;
  group('Posts model test', () {
    test('Posts subreddit page Model is generated correctly', () {
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
