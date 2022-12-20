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
            return state.communities.isNotEmpty
                ? ListView.builder(
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
                                spacing: 15,
                                children: [
                                  Wrap(
                                    direction: Axis.vertical,
                                    spacing: 5,
                                    children: [
                                      InkWell(
                                        child: Wrap(
                                          spacing: 10,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 10,
                                              child: Logo(
                                                Logos.reddit,
                                                color: Colors.black,
                                                size: 15,
                                              ),
                                            ),
                                            Text(
                                              "r/${state.communities[index].name ?? ""}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          debugPrint("go to community");
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
                                                    .leaveCommunity(state
                                                        .communities[index]
                                                        .id!);
                                              } else {
                                                //call the function to join the community
                                                BlocProvider.of<
                                                            SearchCommunitiesCubit>(
                                                        context)
                                                    .joinCommunity(state
                                                        .communities[index]
                                                        .id!);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
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
                                              BlocProvider.of<
                                                          SearchCommunitiesCubit>(
                                                      context)
                                                  .leaveCommunity(state
                                                      .communities[index].id!);
                                            } else {
                                              //call the function to join the community
                                              BlocProvider.of<
                                                          SearchCommunitiesCubit>(
                                                      context)
                                                  .joinCommunity(state
                                                      .communities[index].id!);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
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
                  )
                : Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "No communities found !!",
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
