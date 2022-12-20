import 'dart:convert';
import 'package:reddit/data/model/post_model.dart';

import '../web_services/history_page_web_services.dart';

class HistoryPageRepository {
  final HistoryPageWebServices subredditWebServices;

  HistoryPageRepository(this.subredditWebServices);

  Future<List<PostModel>> getPostsInHistoryPage(
      String mode) async {
    final List<PostModel> subredditsInPageModels = [];
    final List<dynamic> posts = jsonDecode(
        await subredditWebServices.getPostsInHistoryPage(mode));
    for (var element in posts) {
      PostModel.fromJson((element));
    }
    return subredditsInPageModels;
  }
}
