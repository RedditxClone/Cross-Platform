//TODO: Fix tests

import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/discover_page_cubit.dart';
import 'package:reddit/data/model/discover_page_model.dart';
import 'package:reddit/data/repository/discover_page_repo.dart';
import 'package:reddit/data/web_services/discover_page_web_services.dart';

class MockDiscoverPageWebService extends Mock
    implements DiscoverPageWebServices {}

class MockFDiscoverPagesCubit extends MockCubit<DiscoverPageState>
    implements DiscoverPageCubit {}

void main() async {
  late MockDiscoverPageWebService mockDiscoverPageWebService;
  late DiscoverPageRepository discoverPageRepository;
  late DiscoverPageCubit discoverPageCubit;
  final List<Map<String, dynamic>> postsListFromWebServices = [
    {
      'postId': '1',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 1'
    },
    {
      'postId': '2',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 2'
    },
    {
      'postId': '3',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 3'
    },
    {
      'postId': '4',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 4'
    },
    {
      'postId': '5',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 5'
    },
    {
      'postId': '6',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 6'
    },
    {
      'postId': '7',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 7'
    },
    {
      'postId': '8',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 8'
    },
    {
      'postId': '9',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 9'
    },
    {
      'postId': '10',
      'imageUrl':
          'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644',
      'subredditName': 'Post 10'
    }
  ];

  final List<DiscoverPageModel> postsListFromRepository = [
    DiscoverPageModel(
        postId: "1",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 1"),
    DiscoverPageModel(
        postId: "2",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 2"),
    DiscoverPageModel(
        postId: "3",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 3"),
    DiscoverPageModel(
        postId: "4",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 4"),
    DiscoverPageModel(
        postId: "5",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 5"),
    DiscoverPageModel(
        postId: "6",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 6"),
    DiscoverPageModel(
        postId: "7",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 7"),
    DiscoverPageModel(
        postId: "8",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 8"),
    DiscoverPageModel(
        postId: "9",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 9"),
    DiscoverPageModel(
        postId: "10",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 10")
  ];

  group("State test", () {
    setUp(() {
      mockDiscoverPageWebService = MockDiscoverPageWebService();
      discoverPageRepository = DiscoverPageRepository(
          discoverPageWebServices: mockDiscoverPageWebService);
      discoverPageCubit = DiscoverPageCubit(discoverPageRepository);
    });
    // Calling getfDiscoverPages() function returns the correct state
    // fDiscoverPagesLoading means that the request is sent and we are waiting for the response
    // fDiscoverPagesLoaded means that the response is received and UI is built based on this responce
    blocTest<DiscoverPageCubit, DiscoverPageState>(
      'Random Posts loaded state is emitted correctly after getting Random Posts data from server',
      setUp: () {
        when(() => mockDiscoverPageWebService.getAllRandomPosts()).thenAnswer(
          (_) async => postsListFromWebServices,
        );
      },
      build: () {
        return discoverPageCubit;
      },
      act: (DiscoverPageCubit cubit) => cubit.getAllRandomPosts(),
      expect: () => [isA<RandomPostsLoaded>()],
    );
    // Test if mapping from Json to model is correct
    group('Model test', () {
      test('Discover Page Model is generated correctly', () {
        List<DiscoverPageModel> postsListFromModelling =
            postsListFromWebServices
                .map((randomPost) => DiscoverPageModel.fromJson(randomPost))
                .toList();
        // for (var i = 0; i < 10; i++) {
        //   DiscoverPageModel postFromRepository = postsListFromRepository[i];
        //   String postFromRepository_postId = postFromRepository.postId;
        //   String postFromRepository_imageUrl = postFromRepository.imageUrl;
        //   String postFromRepository_subredditName =
        //       postFromRepository.subredditName;
        //   DiscoverPageModel postFromModelling = postsListFromModelling[i];
        //   String postFromModelling_postId = postFromModelling.postId;
        //   String postFromModelling_imageUrl = postFromModelling.imageUrl;
        //   String postFromModelling_subredditName =
        //       postFromModelling.subredditName;
        //   print("Random Post $i from repo:");
        //   print(
        //       "$postFromRepository , $postFromRepository_postId , $postFromRepository_imageUrl , $postFromRepository_subredditName");
        //   print("Random Post $i from Model:");
        //   print(
        //       "$postFromModelling , $postFromModelling_postId , $postFromModelling_imageUrl , $postFromModelling_subredditName");
        // }
        expect(
          postsListFromModelling[0],
          postsListFromRepository[0],
        );
        expect(
          postsListFromModelling[1],
          postsListFromRepository[1],
        );
        expect(
          postsListFromModelling[2],
          postsListFromRepository[2],
        );
        expect(
          postsListFromModelling[3],
          postsListFromRepository[3],
        );
        expect(
          postsListFromModelling[4],
          postsListFromRepository[4],
        );
        expect(
          postsListFromModelling[5],
          postsListFromRepository[5],
        );
        expect(
          postsListFromModelling[6],
          postsListFromRepository[6],
        );
        expect(
          postsListFromModelling[7],
          postsListFromRepository[7],
        );
        expect(
          postsListFromModelling[8],
          postsListFromRepository[8],
        );
        expect(
          postsListFromModelling[9],
          postsListFromRepository[9],
        );
      });
    });
  });
}
