// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../business_logic/cubit/cubit/search/cubit/search_cubit.dart';
import '../../../constants/colors.dart';

class CommentsWebSearch extends StatefulWidget {
  const CommentsWebSearch({super.key, this.searchTerm});
  final String? searchTerm;

  @override
  State<CommentsWebSearch> createState() => _CommentsWebSearchState(searchTerm);
}

class _CommentsWebSearchState extends State<CommentsWebSearch> {
  final String? searchTerm;

  _CommentsWebSearchState(this.searchTerm);

  @override
  void initState() {
    super.initState();
    if (searchTerm != null && searchTerm!.isNotEmpty) {
      BlocProvider.of<SearchCubit>(context).searchComments(searchTerm ?? "");
      debugPrint("Search Term: $searchTerm");
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("comments build");
    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is GetSearchComments) {
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: textFeildColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    title: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 10,
                          children: [
                            Wrap(
                              spacing: 10,
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
                                    "r/${state.comments[index].subreddit!.name ?? ""}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    //navigate to subreddit page
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                  ),
                                  child: Text(
                                    "Posted by u/${state.comments[index].user!.username ?? ""} ${state.comments[index].post!.postedFrom ?? ""} ago",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {
                                    //navigate to the profile user page
                                  },
                                ),
                              ],
                            ),
                            Wrap(
                              children: [
                                Text(
                                  state.comments[index].post!.title ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Wrap(
                          spacing: 10,
                          children: [
                            Text(
                              "${state.comments[index].upvotes ?? 0} upvotes",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "${state.comments[index].post!.commentsCount ?? 0} comments",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    onTap: () {
                      //navigate to the comment page
                    },
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
