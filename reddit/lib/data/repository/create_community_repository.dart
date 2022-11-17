import 'package:reddit/data/web_services/create_community_web_services.dart';

class CreateCommunityRepository {
  final CreateCommunityWebServices communityWebServices;

  CreateCommunityRepository(this.communityWebServices);

  Future<bool> createCommunity(newCommunityData) async {
    final bool ifCreated =
        await communityWebServices.createCommunity(newCommunityData.toJson());
    return ifCreated;
  }

  Future<bool> getIfNameAvailable(String subredditName) async {
    final bool ifAvailable =
        await communityWebServices.getIfNameAvailable(subredditName);
    return ifAvailable;
  }
}
