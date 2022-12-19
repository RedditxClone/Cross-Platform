import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_posts_cubit.dart';
import 'package:reddit/constants/colors.dart';
import '../../../constants/theme_colors.dart';

class PostsWebSearch extends StatefulWidget {
  final String? searchTerm;
  const PostsWebSearch({super.key, this.searchTerm});

  @override
  // ignore: no_logic_in_create_state
  State<PostsWebSearch> createState() => _PostsWebSearchState(searchTerm);
}

class _PostsWebSearchState extends State<PostsWebSearch> {
  final String? searchTerm;
  _PostsWebSearchState(this.searchTerm);

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

  @override
  void initState() {
    super.initState();
    if (searchTerm != null && searchTerm!.isNotEmpty) {
      BlocProvider.of<SearchPostsCubit>(context)
          .searchPosts(searchTerm ?? "", sortIndex, timeIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      BlocProvider.of<SearchPostsCubit>(context)
                          .searchPosts(searchTerm ?? "", sortIndex, timeIndex);
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
                      BlocProvider.of<SearchPostsCubit>(context)
                          .searchPosts(searchTerm ?? "", sortIndex, timeIndex);
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
            return ListView.builder(
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
                      //navigate to post page
                    },
                    mouseCursor: SystemMouseCursors.click,
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
                                    //navigate to subreddit page
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
                                  // imagesUrl + state.posts[index].images![0],
                                  'https://i.redd.it/n0gyalhf192a1.jpg',
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
