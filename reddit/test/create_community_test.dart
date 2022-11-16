import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reddit/business_logic/cubit/create_community_cubit.dart';
import 'package:reddit/data/model/create_community_model.dart';
import 'package:reddit/data/repository/create_community_repository.dart';
import 'package:reddit/data/web_services/create_community_web_services.dart';

class MockCreateCommunityWebService extends Mock
    implements CreateCommunityWebServices {}

void main() async {
  late MockCreateCommunityWebService mockCreateCommunityWebService;
  late CreateCommunityRepository createCommunityRepository;
  late CreateCommunityCubit createCommunityCubit;

  final communityDataFromRepository = {
    "name": "redditx_",
    "type": "Public",
    "over18": false
  };

  final communityDataModel = CreateCommunityModel("redditx_", "Public", false);
  group("State test", () {
    setUp(() {
      mockCreateCommunityWebService = MockCreateCommunityWebService();
      createCommunityRepository =
          CreateCommunityRepository(mockCreateCommunityWebService);
      createCommunityCubit = CreateCommunityCubit(createCommunityRepository);
    });

    blocTest<CreateCommunityCubit, CreateCommunityState>(
      'subreddit created state is emitted after returning true',
      setUp: () {
        when(() => mockCreateCommunityWebService
            .createCommunity(communityDataFromRepository)).thenAnswer(
          (_) async => true,
        );
      },
      build: () {
        return createCommunityCubit;
      },
      act: (CreateCommunityCubit cubit) =>
          cubit.createCommunity(communityDataModel),
      expect: () => [isA<CreateCommunityCreated>()],
    );
    blocTest<CreateCommunityCubit, CreateCommunityState>(
      'subreddit failed to create state is emitted after returning false',
      setUp: () {
        when(() => mockCreateCommunityWebService
            .createCommunity(communityDataFromRepository)).thenAnswer(
          (_) async => false,
        );
      },
      build: () {
        return createCommunityCubit;
      },
      act: (CreateCommunityCubit cubit) =>
          cubit.createCommunity(communityDataModel),
      expect: () => [isA<CreateCommunityFailedToCreate>()],
    );
    blocTest<CreateCommunityCubit, CreateCommunityState>(
      'name available state is emitted after returning true',
      setUp: () {
        when(() => mockCreateCommunityWebService
            .getIfNameAvailable(communityDataModel.communityName)).thenAnswer(
          (_) async => true,
        );
      },
      build: () {
        return createCommunityCubit;
      },
      act: (CreateCommunityCubit cubit) =>
          cubit.checkIfNameAvailable(communityDataModel.communityName),
      expect: () => [isA<CreateCommunityNameAvailable>()],
    );

    blocTest<CreateCommunityCubit, CreateCommunityState>(
      'name unavailable state is emitted after returning false',
      setUp: () {
        when(() => mockCreateCommunityWebService
            .getIfNameAvailable(communityDataModel.communityName)).thenAnswer(
          (_) async => false,
        );
      },
      build: () {
        return createCommunityCubit;
      },
      act: (CreateCommunityCubit cubit) =>
          cubit.checkIfNameAvailable(communityDataModel.communityName),
      expect: () => [isA<CreateCommunityNameUnAvailable>()],
    );
  });
  // Test if mapping from Json to model is correct
  group('Model test', () {
    test('Create community Model is generated correctly', () {
      expect(
        CreateCommunityModel.fromJson(communityDataFromRepository),
        communityDataModel,
      );
    });

    test('Create community json is generated correctly', () {
      expect(
        communityDataModel.toJson(),
        communityDataFromRepository,
      );
    });
  });
}
