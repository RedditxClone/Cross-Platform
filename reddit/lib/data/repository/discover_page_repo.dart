// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:reddit/data/model/discover_page_model.dart';

import '../web_services/discover_page_web_services.dart';

/// Repo for Reciveng data from Web Server.
///
/// Then Model it.
/// Then Sending it to Cubit.
class DiscoverPageRepository {
  final DiscoverPageWebServices discoverPageWebServices;

  DiscoverPageRepository({
    required this.discoverPageWebServices,
  });

  /// Gets feed settings from web services class and maps it to the model.
  ///
  /// The cubit (discover_page_cubit) calls this function.
  Future<List<DiscoverPageModel>> getAllRandomPosts() async {
    final randomPosts = await discoverPageWebServices.getAllRandomPosts();
    print("All Random Posts from repo:");
    print("$randomPosts");
    if (randomPosts != []) {
      return randomPosts
          .map((randomPost) => DiscoverPageModel.fromJson(randomPost))
          .toList();
    } else {
      return [];
    }
  }
}
