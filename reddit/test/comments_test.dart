import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/comments/comments_cubit.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/repository/comments/comments_repository.dart';
import 'package:reddit/data/web_services/comments/comments_web_services.dart';

class MockCommentsWebServices extends Mock implements CommentsWebServices {}

void main() {
  late MockCommentsWebServices mockCommentsWebServices;
  late CommentsRepository commentsRepository;
  late CommentsCubit commentsCubit;
  final commentsFromWebServices = [
    {
      "_id": "",
      "text": "Comment1",
      "votesCount": 1,
      "parentId": "",
      "spammedBy": null,
      "spammedAt": null,
      "postId": "",
      "user": {
        "id": "",
        "photo": "",
        "username": "",
        "isFollowed": false,
        "cakeDay": true
      },
      "postInfo": {"id": null, "title": null},
      "userPostInfo": {"username": null, "userId": null, "name": null},
      "voteType": "upvote",
      "children": []
    }
  ];
  final commentsModelTest = Comments(
    sId: "",
    text: "Comment1",
    votesCount: 1,
    parentId: "",
    spammedBy: null,
    spammedAt: null,
    postId: "",
    user:
        User(id: "", photo: "", username: "", isFollowed: false, cakeDay: true),
    voteType: "upvote",
    children: [],
  );
  var commentsFromRepository = <Comments>[];
  commentsFromRepository.add(commentsModelTest);

  group("Get comments state test", () {
    setUp(() {
      mockCommentsWebServices = MockCommentsWebServices();
      commentsRepository = CommentsRepository(mockCommentsWebServices);
      commentsCubit = CommentsCubit(commentsRepository);
    });
    blocTest<CommentsCubit, CommentsState>(
      'Comments loaded state is emitted correctly after getting comments from server',
      setUp: () {
        when(() => mockCommentsWebServices.getThingComments("123")).thenAnswer(
          (_) async => commentsFromWebServices,
        );
      },
      build: () {
        return commentsCubit;
      },
      act: (CommentsCubit cubit) => cubit.getThingComments("123"),
      expect: () => [isA<CommentsLoading>(), isA<CommentsLoaded>()],
    );
  });
  Comments modelFromJson;
  // Test if mapping from Json to model is correct
  group('Comment model test', () {
    test('Comment Model is generated correctly', () {
      modelFromJson =
          commentsFromWebServices.map((e) => Comments.fromJson(e)).toList()[0];
      expect(modelFromJson.sId, commentsModelTest.sId);
      expect(modelFromJson.children, commentsModelTest.children);
      expect(modelFromJson.createdDate, commentsModelTest.createdDate);
      expect(modelFromJson.parentId, commentsModelTest.parentId);
      expect(modelFromJson.postId, commentsModelTest.postId);
      expect(modelFromJson.spammedAt, commentsModelTest.spammedAt);
      expect(modelFromJson.spammedBy, commentsModelTest.spammedBy);
      expect(modelFromJson.text, commentsModelTest.text);
      expect(modelFromJson.type, commentsModelTest.type);
      expect(modelFromJson.user!.cakeDay, commentsModelTest.user!.cakeDay);
      expect(modelFromJson.user!.id, commentsModelTest.user!.id);
      expect(
          modelFromJson.user!.isFollowed, commentsModelTest.user!.isFollowed);
      expect(modelFromJson.user!.photo, commentsModelTest.user!.photo);
      expect(modelFromJson.user!.username, commentsModelTest.user!.username);
      expect(modelFromJson.text, commentsModelTest.text);
      expect(modelFromJson.type, commentsModelTest.type);
      expect(modelFromJson.voteType, commentsModelTest.voteType);
      expect(modelFromJson.votesCount, commentsModelTest.votesCount);
    });
  });
}
