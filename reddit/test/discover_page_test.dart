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
  const List<String> settingsListFromWebServices = [
    '''{
        "postId": "1",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 1"
    }''',
    '''{
        "postId": "2",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 2"
    }''',
    '''{
        "postId": "3",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 3"
    }''',
    '''{
        "postId": "4",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 4"
    }''',
    '''{
        "postId": "5",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 5"
    }''',
    '''{
        "postId": "6",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 6"
    }''',
    '''{
        "postId": "7",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 7"
    }''',
    '''{
        "postId": "8",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 8"
    }''',
    '''{
        "postId": "9",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 9"
    }''',
    '''{
        "postId": "10",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 10"
    }'''
  ];
  const String settingsFromWebServices = '''[
    {
        "postId": "1",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 1"
    },
    {
        "postId": "2",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 2"
    },
    {
        "postId": "3",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 3"
    },
    {
        "postId": "4",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 4"
    },
    {
        "postId": "5",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 5"
    },
    {
        "postId": "6",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 6"
    },
    {
        "postId": "7",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 7"
    },
    {
        "postId": "8",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 8"
    },
    {
        "postId": "9",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 9"
    },
    {
        "postId": "10",
        "imageUrl": "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        "subredditName": "Post 10"
    }
]''';

  final List<DiscoverPageModel> settingsFromRepository = [
    DiscoverPageModel(
        postId: "0",
        imageUrl:
            "https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644",
        subredditName: "Post 0"),
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
        subredditName: "Post 9")
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
          (_) async => settingsFromWebServices,
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
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[0])),
          settingsFromRepository[0],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[1])),
          settingsFromRepository[1],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[2])),
          settingsFromRepository[2],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[3])),
          settingsFromRepository[3],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[4])),
          settingsFromRepository[4],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[5])),
          settingsFromRepository[5],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[6])),
          settingsFromRepository[6],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[7])),
          settingsFromRepository[7],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[8])),
          settingsFromRepository[8],
        );
        expect(
          DiscoverPageModel.fromJson(
              jsonDecode(settingsListFromWebServices[9])),
          settingsFromRepository[9],
        );
      });
    });
  });
}
