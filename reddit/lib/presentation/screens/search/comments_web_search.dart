// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_comments_cubit.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../data/model/auth_model.dart';
import '../../../data/model/posts/posts_model.dart';
import '../../../data/repository/search_repo.dart';
import '../../../data/web_services/search_web_service.dart';

class CommentsWebSearch extends StatefulWidget {
  const CommentsWebSearch({super.key});

  @override
  State<CommentsWebSearch> createState() => _CommentsWebSearchState();
}

class _CommentsWebSearchState extends State<CommentsWebSearch> {
  _CommentsWebSearchState();
  SearchRepo searchRepo = SearchRepo(SearchWebService());

  @override
  Widget build(BuildContext context) {
    debugPrint("comments build");
    return Scaffold(
      body: BlocBuilder<SearchCommentsCubit, SearchCommentsState>(
        builder: (context, state) {
          if (state is GetSearchComments) {
            return state.comments.isNotEmpty
                ? ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: textFeildColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          mouseCursor: UserData.isLoggedIn
                              ? SystemMouseCursors.click
                              : SystemMouseCursors.basic,
                          title: InkWell(
                            onTap: () {
                              //navigate to the post page
                              if (UserData.isLoggedIn) {
                                searchRepo
                                    .getPostData(
                                        state.comments[index].post!.id ?? '')
                                    .then((value) {
                                  Navigator.of(context)
                                      .pushNamed(postPageRoute, arguments: {
                                    "post": PostsModel.fromJson(value),
                                    "subredditID":
                                        state.comments[index].subreddit!.id,
                                  });
                                });
                              }
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
                                        //TODO: navigate to subreddit page
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
                                        if (UserData.isLoggedIn) {
                                          if (state.comments[index].postOwner!
                                                  .userId ==
                                              UserData.user!.userId) {
                                            Navigator.pushNamed(
                                                context, profilePageRoute);
                                          } else {
                                            Navigator.pushNamed(
                                                context, otherProfilePageRoute,
                                                arguments: state.comments[index]
                                                    .postOwner!.username);
                                          }
                                        } else {
                                          Navigator.pushNamed(
                                              context, otherProfilePageRoute,
                                              arguments: state.comments[index]
                                                  .postOwner!.username);
                                        }
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
                            mouseCursor: UserData.isLoggedIn
                                ? SystemMouseCursors.click
                                : SystemMouseCursors.basic,
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
                                      InkWell(
                                        onTap: () {
                                          //navigate to the profile user page
                                          if (UserData.isLoggedIn) {
                                            if (state.comments[index].user!
                                                    .userId ==
                                                UserData.user!.userId) {
                                              Navigator.pushNamed(
                                                  context, profilePageRoute);
                                            } else {
                                              Navigator.pushNamed(context,
                                                  otherProfilePageRoute,
                                                  arguments: state
                                                      .comments[index]
                                                      .user!
                                                      .username);
                                            }
                                          } else {
                                            Navigator.pushNamed(
                                                context, otherProfilePageRoute,
                                                arguments: state.comments[index]
                                                    .user!.username);
                                          }
                                        },
                                        child: Text(
                                          state.comments[index].user!
                                                  .username ??
                                              "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
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
                              //navigate to the post page
                              if (UserData.isLoggedIn) {
                                searchRepo
                                    .getPostData(
                                        state.comments[index].post!.id ?? '')
                                    .then((value) {
                                  Navigator.of(context)
                                      .pushNamed(postPageRoute, arguments: {
                                    "post": PostsModel.fromJson(value),
                                    "subredditID":
                                        state.comments[index].subreddit!.id,
                                  });
                                });
                              }
                            },
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "No Comments found !!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
            ;
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
