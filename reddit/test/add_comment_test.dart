import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/comments/add_comment_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/model/comments/comment_submit.dart';
import 'package:reddit/data/repository/comments/comments_repository.dart';
import 'package:reddit/data/web_services/comments/comments_web_services.dart';

class MockCommentsWebServices extends Mock implements CommentsWebServices {}

void main() async {
  late MockCommentsWebServices mockCommentsWebServices;
  late CommentsRepository commentsRepository;
  late AddCommentCubit addCommentCubit;
  final commentSubmitModelJson = {
    "parentId": "",
    "subredditId": "",
    "postId": "",
    "text": "Comment"
  };
  final commentsModelJson = {
    "text": "Comment",
    "votesCount": 0,
    "parentId": "",
    "spammedBy": null,
    "spammedAt": null,
    "postId": "",
    "_id": "",
    "type": "Comment",
    "createdDate": "2022-12-22T19:58:18.364Z",
  };
  final commentSubmitModel =
      CommentSubmit(parentId: "", subredditId: "", postId: "", text: "Comment");
  final commentsModel = Comments(
    text: "Comment",
    votesCount: 0,
    parentId: "",
    spammedBy: null,
    spammedAt: null,
    postId: "",
    sId: "",
    type: "Comment",
    createdDate: "2022-12-22T19:58:18.364Z",
  );
  group("Add comment state test", () {
    setUp(() {
      mockCommentsWebServices = MockCommentsWebServices();
      commentsRepository = CommentsRepository(mockCommentsWebServices);
      addCommentCubit = AddCommentCubit(commentsRepository);
    });
    group("Signed out", () {
      blocTest<AddCommentCubit, AddCommentState>(
        'Add comment emitted correctly when user is not logged in',
        setUp: () {
          when(() => mockCommentsWebServices.addComment(commentSubmitModelJson))
              .thenAnswer(
            (_) async => commentsModelJson,
          );
        },
        build: () {
          return addCommentCubit;
        },
        act: (AddCommentCubit cubit) {
          cubit.addComment(commentSubmitModel);
        },
        expect: () => [isA<AddCommentError>()],
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

      blocTest<AddCommentCubit, AddCommentState>(
        'Add comment state emitted correctly when user is logged in and server responded with success',
        setUp: () {
          when(() => mockCommentsWebServices.addComment(commentSubmitModelJson))
              .thenAnswer(
            (_) async => commentsModelJson,
          );
        },
        build: () {
          return addCommentCubit;
        },
        act: (AddCommentCubit cubit) {
          cubit.addComment(commentSubmitModel);
        },
        expect: () => [isA<CommentAdded>()],
      );
    });
  });
  Map<String, dynamic> submitModelToJson;

  group('Comments model test', () {
    test('Submit comment model generated correctly', () {
      submitModelToJson = commentSubmitModel.toJson();
      expect(submitModelToJson["parentId"], commentSubmitModelJson["parentId"]);
      expect(submitModelToJson["subredditId"],
          commentSubmitModelJson["subredditId"]);
      expect(submitModelToJson["postId"], commentSubmitModelJson["postId"]);
      expect(submitModelToJson["text"], commentSubmitModelJson["text"]);
    });
  });
}
