import 'package:flutter/material.dart';
import 'package:reddit/data/web_services/create_community_web_services.dart';

import '../model/subreddit_model.dart';

class CreateCommunityRepository {
  final CreateCommunityWebServices communityWebServices;

  CreateCommunityRepository(this.communityWebServices);

  Future<SubredditModel?> createCommunity(newCommunityData) async {
    debugPrint("in repo");
    Map<String, dynamic> data = newCommunityData.toJson();
    debugPrint("before call web services");
    final response = await communityWebServices.createCommunity(data);
    if (response != null && response.statusCode == 201) {
      debugPrint("response != null");
      SubredditModel subredditModel = SubredditModel.fromJson(response.data);
      debugPrint("${subredditModel.createdDate}");
      return subredditModel;
    }
    return null;
  }

  Future<bool> getIfNameAvailable(String subredditName) async {
    final bool ifAvailable =
        await communityWebServices.getIfNameAvailable(subredditName);
    return ifAvailable;
  }
}
