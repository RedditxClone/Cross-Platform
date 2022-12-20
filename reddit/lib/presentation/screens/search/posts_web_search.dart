import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_posts_cubit.dart';
import 'package:reddit/constants/colors.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/search_repo.dart';
import 'package:reddit/data/web_services/search_web_service.dart';
import 'package:reddit/presentation/screens/search/search_web.dart';
import '../../../constants/theme_colors.dart';
import '../../../data/model/auth_model.dart';

class PostsWebSearch extends StatefulWidget {
  const PostsWebSearch({super.key});

  @override
  State<PostsWebSearch> createState() => _PostsWebSearchState();
}

class _PostsWebSearchState extends State<PostsWebSearch> {
  List<PopupMenuEntry> sortOptionsList = [
    PopupMenuItem(
      value: 0,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Relevance',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 1,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Hot',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 2,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Top',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 3,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'New',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 4,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Most Comments',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  ];
  List<PopupMenuEntry> timeOptionsList = [
    PopupMenuItem(
      value: 0,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'All Time',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 1,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past Year',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 2,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past Month',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 3,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past Week',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 4,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past 24 Hours',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 5,
      child: Row(
        children: const [
          SizedBox(width: 20),
          Text(
            'Past Hour',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    ),
  ];
  String sortOption = "Sort by";
  String sortTime = "Time";
  int sortIndex = 0;
  int timeIndex = 0;
  SearchRepo searchRepo = SearchRepo(SearchWebService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BlocBuilder<SearchPostsCubit, SearchPostsState>(
          builder: (context, state) {
            if (state is GetSearchPosts) {
              debugPrint("GetSearchPosts");
              return Row(
                children: [
                  PopupMenuButton(
                    tooltip: "Sort by",
                    color: defaultSecondaryColor,
                    position: PopupMenuPosition.under,
                    itemBuilder: (_) => sortOptionsList,
                    onSelected: (value) {
                      if (value == 0) {
                        sortOption = "Relevance";
                      } else if (value == 1) {
                        sortOption = "Hot";
                      } else if (value == 2) {
                        sortOption = "Top";
                      } else if (value == 3) {
                        sortOption = "New";
                      } else if (value == 4) {
                        sortOption = "Most Comments";
                      }
                      sortIndex = value as int;
                      debugPrint(
                          "searchTermPost: ${SearchWebState.selectedTerm}");
                      BlocProvider.of<SearchPostsCubit>(context).searchPosts(
                          SearchWebState.selectedTerm ?? "",
                          sortIndex,
                          timeIndex);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: textFeildColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            sortOption,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const Icon(Icons.arrow_downward_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  PopupMenuButton(
                    tooltip: "Time",
                    color: defaultSecondaryColor,
                    position: PopupMenuPosition.under,
                    itemBuilder: (_) => timeOptionsList,
                    onSelected: (value) {
                      if (value == 0) {
                        sortTime = "All Time";
                      } else if (value == 1) {
                        sortTime = "Past Year";
                      } else if (value == 2) {
                        sortTime = "Past Month";
                      } else if (value == 3) {
                        sortTime = "Past Week";
                      } else if (value == 4) {
                        sortTime = "Past 24 Hours";
                      } else if (value == 5) {
                        sortTime = "Past Hour";
                      }
                      timeIndex = value as int;
                      BlocProvider.of<SearchPostsCubit>(context).searchPosts(
                          SearchWebState.selectedTerm ?? "",
                          sortIndex,
                          timeIndex);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: textFeildColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            sortTime,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const Icon(Icons.arrow_downward_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox(
              height: 0,
            );
          },
        ),
      ),
      body: BlocBuilder<SearchPostsCubit, SearchPostsState>(
        builder: (context, state) {
          if (state is GetSearchPosts) {
            return state.posts.isNotEmpty
                ? ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: textFeildColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () {
                            if (UserData.isLoggedIn) {
                              searchRepo
                                  .getPostData(state.posts[index].id ?? '')
                                  .then((value) {
                                Navigator.of(context)
                                    .pushNamed(postPageRoute, arguments: {
                                  "post": PostsModel.fromJson(value),
                                  "subredditID":
                                      state.posts[index].subreddit!.id,
                                });
                              });
                            }
                          },
                          mouseCursor: UserData.isLoggedIn
                              ? SystemMouseCursors.click
                              : SystemMouseCursors.basic,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                spacing: 15,
                                children: [
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      TextButton.icon(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.transparent,
                                        ),
                                        icon: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 10,
                                          child: Logo(
                                            Logos.reddit,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                        label: Text(
                                          "r/${state.posts[index].subreddit!.name ?? ""}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () {
                                          //TODO: navigate to subreddit page
                                          debugPrint(
                                              "navigate to subreddit page from posts");
                                        },
                                      ),
                                      InkWell(
                                        child: Text(
                                          "u/${state.posts[index].user!.username ?? ""} ${state.posts[index].postedFrom} ago",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        onTap: () {
                                          //navigate to the profile user page
                                          if (UserData.isLoggedIn) {
                                            if (state.posts[index].user!
                                                    .userId ==
                                                UserData.user!.userId) {
                                              Navigator.pushNamed(
                                                  context, profilePageRoute);
                                            } else {
                                              Navigator.pushNamed(context,
                                                  otherProfilePageRoute,
                                                  arguments: state.posts[index]
                                                      .user!.username);
                                            }
                                          } else {
                                            Navigator.pushNamed(
                                                context, otherProfilePageRoute,
                                                arguments: state.posts[index]
                                                    .user!.username);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    state.posts[index].title ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                  Wrap(
                                    spacing: 10,
                                    children: [
                                      Text(
                                        "${state.posts[index].votesCount} upvotes",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "${state.posts[index].commentsCount} comments",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                child: state.posts[index].images!.isEmpty
                                    ? null
                                    : Image.network(
                                        imagesUrl +
                                            state.posts[index].images![0],
                                        height: kIsWeb ? 200 : 100,
                                        width: kIsWeb ? 200 : 100,
                                        fit: BoxFit.fill,
                                      ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "No Posts found !!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
          }
          return Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Start Serching ...",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
