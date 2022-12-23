import '../../model/posts/posts_model.dart';
import '../../web_services/posts/posts_web_services.dart';

class PostsRepository {
  final PostsWebServices postsDrawerWebServices;

  PostsRepository(this.postsDrawerWebServices);

  /// Returns [List] of [PostsModel] object that contains the timeline posts whether your are logged in or logged out
  /// after getting it from [PostsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getTimelinePosts(
      String sort, int page, int limit) async {
    final posts =
        await postsDrawerWebServices.getTimelinePosts(sort, page, limit);
    // debugPrint("Timeline posts from repo:");
    // debugPrint("$posts");
    return List<PostsModel>.from(posts.map((i) => PostsModel.fromJson(i)));
  }

  /// Returns [List] of [PostsModel] object that contains the popular posts whether your are logged in or logged out
  /// after getting it from [PostsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getPopularPosts(
      String sort, int page, int limit) async {
    final posts =
        await postsDrawerWebServices.getPopularPosts(sort, page, limit);
    // debugPrint("Popular posts from repo:");
    // debugPrint("$posts");
    return List<PostsModel>.from(posts.map((i) => PostsModel.fromJson(i)));
  }

  /// Returns [List] of [PostsModel] object that contains a user's profile posts whether your are logged in or logged out
  /// after getting it from [PostsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getUserPosts(
      String id, String sort, int page, int limit) async {
    final posts =
        await postsDrawerWebServices.getUserPosts(id, sort, page, limit);
    // debugPrint("Popular posts from repo:");
    // debugPrint("$posts");
    return List<PostsModel>.from(posts.map((i) => PostsModel.fromJson(i)));
  }

  /// Returns [List] of [PostsModel] object that contains the logged in user's profile posts
  /// after getting it from [PostsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getMyProfilePosts(
      String sort, int page, int limit) async {
    final posts =
        await postsDrawerWebServices.getMyProfilePosts(sort, page, limit);
    // debugPrint("My profile posts from repo:");
    // debugPrint("$posts");
    return List<PostsModel>.from(posts.map((i) => PostsModel.fromJson(i)));
  }

  /// Returns [List] of [PostsModel] object that contains the subreddit posts whether your are logged in or logged out
  /// after getting it from [PostsWebServices] and mapping it to the model list.
  Future<List<PostsModel>> getSubredditPosts(
      String name, String sort, int page, int limit) async {
    final posts =
        await postsDrawerWebServices.getSubredditPosts(name, sort, page, limit);
    // debugPrint("My profile posts from repo:");
    // debugPrint("$posts");
    return List<PostsModel>.from(posts.map((i) => PostsModel.fromJson(i)));
  }
}
