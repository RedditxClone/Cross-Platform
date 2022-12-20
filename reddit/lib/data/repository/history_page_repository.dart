import 'dart:convert';
import 'package:reddit/data/model/posts/posts_model.dart';

import '../web_services/history_page_web_services.dart';

class HistoryPageRepository {
  final HistoryPageWebServices subredditWebServices;

  HistoryPageRepository(this.subredditWebServices);

  Future<List<PostsModel>> getPostsInHistoryPage(String mode) async {
    final List<PostsModel> subredditsInPageModels = [];
    final List<dynamic> posts =
        (await subredditWebServices.getPostsInHistoryPage(mode));
    for (var element in posts) {
      PostsModel.fromJson((element));
    }
    return subredditsInPageModels;
  }
}
