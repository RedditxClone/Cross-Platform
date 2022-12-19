// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_comments_cubit.dart';

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
  Widget build(BuildContext context) {
    debugPrint("comments build");
    return Scaffold(
      body: BlocBuilder<SearchCommentsCubit, SearchCommentsState>(
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
                    title: InkWell(
                      onTap: () {
                        //navigate to the post page
                        debugPrint("navigate to the post page");
                      },
                      child: Wrap(
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
                              InkWell(
                                child: Text(
                                  "u/${state.comments[index].postOwner!.username ?? ""} ${state.comments[index].post!.postedFrom ?? ""} ago",
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
                            state.comments[index].post!.title ?? "",
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
                    ),
                    subtitle: ListTile(
                      style: ListTileStyle.list,
                      mouseCursor: SystemMouseCursors.click,
                      title: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 18, 35, 45),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 10,
                          children: [
                            Wrap(
                              spacing: 5,
                              children: [
                                Text(
                                  state.comments[index].user!.username ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  state.comments[index].commentFrom ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              state.comments[index].text ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "${state.comments[index].upvotes ?? 0} upvotes",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        //navigate to the comment
                        debugPrint("navigate to the comment");
                      },
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
