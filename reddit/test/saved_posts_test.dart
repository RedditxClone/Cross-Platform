import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/cubit/saved_posts_cubit.dart';
import 'package:reddit/data/model/saved_posts_model.dart';
import 'package:reddit/data/repository/saved_posts_repo.dart';
import 'package:reddit/data/web_services/saved_posts_web_services.dart';

class MockDiscoverPageWebService extends Mock implements SavedPostsWebServices {
}

class MockFDiscoverPagesCubit extends MockCubit<SavedPostsState>
    implements SavedPostsCubit {}

void main() async {
  late MockDiscoverPageWebService mockDiscoverPageWebService;
  late SavedPostsRepository savedPostsRepository;
  late SavedPostsCubit savedPostsCubit;
  final Map<String, dynamic> postsListFromWebServices = {
    "data": [
      {
        "text": "First Post",
        "_id": "1",
        "commentCount": 300,
        "title": "In The Name Of Allah",
        "publishedDate": "2023-1-21",
        "votesCount": 777,
        "subredditInfo": {"name": "ElRayes_Group", "id": "1"},
        "user": {
          "username": "Omar_Khaled_2001",
          "photo": "/assets/icon/reddit.png",
          "id": "1"
        }
      },
      {
        "text": "string",
        "_id": "string",
        "commentCount": 0,
        "title": "string",
        "publishedDate": "2022-12-23T17:34:12.984Z",
        "votesCount": 0,
        "subredditInfo": {"name": "string", "id": "string"},
        "user": {"username": "string", "photo": "string", "id": "string"}
      }
    ]
  };

  final List<SavedPostsModel>? savedPostsListFromRepository = [
    SavedPostsModel(
        id: "1",
        text: "First Post",
        commentCount: 300,
        title: "In The Name Of Allah",
        publishedDate: "2023-1-21",
        subredditId: "1",
        subredditName: "ElRayes_Group",
        votesCount: 777,
        userName: "Omar_Khaled_2001",
        userPhoto: "/assets/icon/reddit.png",
        userId: "1"),
    SavedPostsModel(
        id: "string",
        text: "string",
        commentCount: 0,
        title: "string",
        publishedDate: "2022-12-23T17:34:12.984Z",
        subredditId: "string",
        subredditName: "string",
        votesCount: 0,
        userName: "string",
        userPhoto: "string",
        userId: "string"),
  ];

  group("State test", () {
    setUp(() {
      mockDiscoverPageWebService = MockDiscoverPageWebService();
      savedPostsRepository = SavedPostsRepository(
          savedPostsWebServices: mockDiscoverPageWebService);
      savedPostsCubit = SavedPostsCubit(savedPostsRepository);
    });
    // Calling getfDiscoverPages() function returns the correct state
    // fDiscoverPagesLoading means that the request is sent and we are waiting for the response
    // fDiscoverPagesLoaded means that the response is received and UI is built based on this responce
    blocTest<SavedPostsCubit, SavedPostsState>(
      'Random Posts loaded state is emitted correctly after getting Random Posts data from server',
      setUp: () {
        when(() => mockDiscoverPageWebService.getAllSavedPosts()).thenAnswer(
          (_) async => postsListFromWebServices,
        );
      },
      build: () {
        return savedPostsCubit;
      },
      act: (SavedPostsCubit cubit) => cubit.getAllSavedPosts(),
      expect: () => [isA<SavedPostsLoaded>()],
    );
    // Test if mapping from Json to model is correct
    group('Model test', () {
      test('Discover Page Model is generated correctly', () {
        SavedPostsModelling savedPostsModelling = SavedPostsModelling();
        savedPostsModelling.datafromJson(postsListFromWebServices);
        List<SavedPostsModel>? postsListFromModelling =
            savedPostsModelling.savedPosts;
        expect(
          postsListFromModelling![0],
          savedPostsListFromRepository![0],
        );
        expect(
          postsListFromModelling[1],
          savedPostsListFromRepository[1],
        );
      });
    });
  });
}
