import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_comments_cubit.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_communities_cubit.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_cubit.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_people_cubit.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_posts_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/search_models/search_comments_model.dart';
import 'package:reddit/data/model/search_models/search_communities_model.dart';
import 'package:reddit/data/model/search_models/search_post_model.dart';
import 'package:reddit/data/repository/search_repo.dart';

class MockSearchRepo extends Mock implements SearchRepo {}

void main() {
  late MockSearchRepo mockSearchRepo;
  late SearchCubit searchCubit;
  late SearchCommentsCubit searchCommentsCubit;
  late SearchCommunitiesCubit searchCommunitiesCubit;
  late SearchPostsCubit searchPostsCubit;
  late SearchPeopleCubit searchPeopleCubit;
  const List<List<Map<String, dynamic>>> suggestionsJson = [
    [
      {
        "_id": "639b40ade14bed80ef988757",
        "username": "1234",
        "profilePhoto": "assets/profilePhotos/639b40ade14bed80ef988757.jpeg",
        "coverPhoto": "",
        "about": "",
        "nsfw": false,
        "allowFollow": true,
        "cakeDay": true,
        "userId": "639b40ade14bed80ef988757",
        "followed": false
      },
    ],
    [
      {
        "_id": "639771faa875316ad8d9f3e4",
        "name": "bemoireddit",
        "over18": false,
        "flairList": [],
        "categories": [],
        "users": 1,
        "joined": false
      },
    ]
  ];
  final commentsList = <SearchCommentsModel>[
    SearchCommentsModel(
      id: "",
      text: "",
      upvotes: 0,
      creationDate: DateTime.now(),
      user: User(coverPhoto: ""),
      postOwner: User(coverPhoto: ""),
      post: null,
    ),
  ];
  final communitiesList = <SearchComminityModel>[
    SearchComminityModel(
      id: "",
      name: "",
      users: 0,
      joined: false,
      flairList: [],
      categories: [],
      creationDate: DateTime.now(),
    ),
  ];
  final postsList = <SearchPostModel>[
    SearchPostModel(
      id: "",
      title: "",
      votesCount: 0,
      creationDate: DateTime.now(),
      user: null,
      subreddit: null,
      images: [],
      commentsCount: 0,
      nsfw: false,
      spoiler: false,
      publishDate: null,
    ),
  ];
  final peopleList = <User>[
    User(coverPhoto: ""),
  ];
  group("Search state test", () {
    setUp(() {
      mockSearchRepo = MockSearchRepo();
      searchCubit = SearchCubit(mockSearchRepo);
    });

    blocTest<SearchCubit, SearchState>(
      'GetSuggestions State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockSearchRepo.getSuggestions("word")).thenAnswer(
          (_) async => suggestionsJson,
        );
      },
      build: () {
        return searchCubit;
      },
      act: (SearchCubit cubit) => cubit.getSuggestions("word"),
      expect: () => [isA<GetSuggestions>()],
    );
  });
  group("SearchCommentsCubit state test", () {
    setUp(() {
      mockSearchRepo = MockSearchRepo();
      searchCommentsCubit = SearchCommentsCubit(mockSearchRepo);
    });

    blocTest<SearchCommentsCubit, SearchCommentsState>(
      'GetSearchComments State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockSearchRepo.searchComments("word")).thenAnswer(
          (_) async => commentsList,
        );
      },
      build: () {
        return searchCommentsCubit;
      },
      act: (SearchCommentsCubit cubit) => cubit.searchComments("word"),
      expect: () => [isA<GetSearchComments>()],
    );
  });
  group("SearchCommunitiesCubit state test", () {
    setUp(() {
      mockSearchRepo = MockSearchRepo();
      searchCommunitiesCubit = SearchCommunitiesCubit(mockSearchRepo);
    });

    blocTest<SearchCommunitiesCubit, SearchCommunitiesState>(
      'GetSearchComments State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockSearchRepo.searchCommunities("word")).thenAnswer(
          (_) async => communitiesList,
        );
      },
      build: () {
        return searchCommunitiesCubit;
      },
      act: (SearchCommunitiesCubit cubit) => cubit.searchCommunities("word"),
      expect: () => [isA<GetSearchCommunities>()],
    );
  });
  group("searchPostsCubit state test", () {
    setUp(() {
      mockSearchRepo = MockSearchRepo();
      searchPostsCubit = SearchPostsCubit(mockSearchRepo);
    });

    blocTest<SearchPostsCubit, SearchPostsState>(
      'GetSearchPosts State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockSearchRepo.searchPosts("word", 0, 0)).thenAnswer(
          (_) async => postsList,
        );
      },
      build: () {
        return searchPostsCubit;
      },
      act: (SearchPostsCubit cubit) => cubit.searchPosts("word", 0, 0),
      expect: () => [isA<GetSearchPosts>()],
    );
  });
  group("SearchCommentsCubit state test", () {
    setUp(() {
      mockSearchRepo = MockSearchRepo();
      searchPeopleCubit = SearchPeopleCubit(mockSearchRepo);
    });

    blocTest<SearchPeopleCubit, SearchPeopleState>(
      'GetSearchPeople State is emitted after getting the data from the server',
      setUp: () {
        when(() => mockSearchRepo.searchPeople("word")).thenAnswer(
          (_) async => peopleList,
        );
      },
      build: () {
        return searchPeopleCubit;
      },
      act: (SearchPeopleCubit cubit) => cubit.searchPeople("word"),
      expect: () => [isA<GetSearchPeople>()],
    );
  });
}
