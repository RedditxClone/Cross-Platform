import 'package:flutter/material.dart';
import 'package:reddit/data/web_services/create_community_web_services.dart';

class CreateCommunityRepository {
  final CreateCommunityWebServices communityWebServices;

  CreateCommunityRepository(this.communityWebServices);

  Future<bool> createCommunity(newCommunityData) async {
    debugPrint("in repo");
    Map<String, dynamic> data = newCommunityData.toJson();
    debugPrint("before call web services");
    final bool ifCreated = await communityWebServices.createCommunity(data);
    return ifCreated;
  }

  Future<bool> getIfNameAvailable(String subredditName) async {
    final bool ifAvailable =
        await communityWebServices.getIfNameAvailable(subredditName);
    return ifAvailable;
  }
}
