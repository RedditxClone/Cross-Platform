import 'package:reddit/data/web_services/create_community_web_services.dart';

class CreateCommunityRepository {
  final CreateCommunityWebServices communityWebServices;

  CreateCommunityRepository(this.communityWebServices);

  Future<void> createCommunity(newCommunityData) async {
    await communityWebServices.createCommunity(newCommunityData.toJson());
  }

  Future<bool> getIfNameAvailable(String subredditName) async {
    final bool ifAvailable =
        await communityWebServices.getIfNameAvailable(subredditName);
    return ifAvailable;
  }
}
