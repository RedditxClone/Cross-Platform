// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/cubit/search/cubit/search_communities_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';

import '../../../business_logic/cubit/cubit/search/cubit/search_cubit.dart';
import '../../../constants/colors.dart';

class CommunitiesWebSearch extends StatefulWidget {
  const CommunitiesWebSearch({super.key, this.searchTerm});
  final String? searchTerm;

  @override
  State<CommunitiesWebSearch> createState() =>
      _CommunitiesWebSearchState(searchTerm);
}

class _CommunitiesWebSearchState extends State<CommunitiesWebSearch> {
  final String? searchTerm;

  _CommunitiesWebSearchState(this.searchTerm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchCommunitiesCubit, SearchCommunitiesState>(
        builder: (context, state) {
          if (state is GetSearchCommunities) {
            return ListView.builder(
              itemCount: state.communities.length,
              itemBuilder: (context, index) {
                bool isJoined = state.communities[index].joined ?? false;
                return Container(
                  decoration: BoxDecoration(
                    color: textFeildColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    mouseCursor: SystemMouseCursors.click,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    "r/${state.communities[index].name ?? ""}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    //navigate to subreddit page
                                  },
                                ),
                                Text(
                                  "${state.communities[index].users ?? 0} members",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Created at ${state.communities[index].creationDate!.day} / ${state.communities[index].creationDate!.month} / ${state.communities[index].creationDate!.year}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        UserData.isLoggedIn
                            ? BlocBuilder<SearchCommunitiesCubit,
                                SearchCommunitiesState>(
                                builder: (context, state2) {
                                  if (state2 is JoinCommunity) {
                                    isJoined = state2.joined;
                                    return ElevatedButton(
                                      onPressed: () {
                                        //call the function to join the community
                                        if (isJoined) {
                                          //call the function to leave the community
                                          BlocProvider.of<
                                                      SearchCommunitiesCubit>(
                                                  context)
                                              .leaveCommunity(
                                                  state.communities[index].id!);
                                        } else {
                                          //call the function to join the community
                                          BlocProvider.of<
                                                      SearchCommunitiesCubit>(
                                                  context)
                                              .joinCommunity(
                                                  state.communities[index].id!);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 101, 99, 99),
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        isJoined ? "Joined" : "Join",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }
                                  return ElevatedButton(
                                    onPressed: () {
                                      //call the function to join the community
                                      if (isJoined) {
                                        //call the function to leave the community
                                        BlocProvider.of<SearchCommunitiesCubit>(
                                                context)
                                            .leaveCommunity(
                                                state.communities[index].id!);
                                      } else {
                                        //call the function to join the community
                                        BlocProvider.of<SearchCommunitiesCubit>(
                                                context)
                                            .joinCommunity(
                                                state.communities[index].id!);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 101, 99, 99),
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      isJoined ? "Joined" : "Join",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                    onTap: () {
                      //navigate to the subreddit page
                    },
                  ),
                );
              },
            );
          }
          return const Text(
            "Start Serching ...",
            style: TextStyle(color: Colors.white, fontSize: 20),
          );
        },
      ),
    );
  }
}
