// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/constants/colors.dart';

import '../../../business_logic/cubit/cubit/search/cubit/search_people_cubit.dart';
import '../../../data/model/auth_model.dart';

class PeopleWebSearch extends StatefulWidget {
  const PeopleWebSearch({super.key, this.searchTerm});
  final String? searchTerm;

  @override
  State<PeopleWebSearch> createState() => _PeopleWebSearchState(searchTerm);
}

class _PeopleWebSearchState extends State<PeopleWebSearch> {
  final String? searchTerm;

  _PeopleWebSearchState(this.searchTerm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchPeopleCubit, SearchPeopleState>(
        builder: (context, state) {
          if (state is GetSearchPeople) {
            return state.users.isNotEmpty
                ? ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      bool isFollowed = state.users[index].followed ?? false;
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
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      backgroundImage:
                                          state.users[index].profilePic != ''
                                              ? NetworkImage(state.users[index]
                                                      .profilePic ??
                                                  '')
                                              : null,
                                      child: state.users[index].profilePic == ''
                                          ? const Icon(
                                              Icons.person,
                                              size: 40,
                                            )
                                          : null,
                                    ),
                                    label: Text(
                                      "u/${state.users[index].username ?? ""}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: state.users[index].username!
                                                    .length >
                                                20
                                            ? 10
                                            : 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      //TODO:navigate to subreddit page
                                    },
                                  ),
                                  Text(
                                    state.users[index].about ?? "",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                              UserData.isLoggedIn
                                  ? BlocBuilder<SearchPeopleCubit,
                                      SearchPeopleState>(
                                      builder: (context, state2) {
                                        if (state2 is FollowUser) {
                                          isFollowed = state2.followed;
                                          return ElevatedButton(
                                            onPressed: () {
                                              //call the function to join the community
                                              //request to follow the other user only if the user is logged in
                                              if (isFollowed) {
                                                //unfollow the user
                                                BlocProvider.of<
                                                            SearchPeopleCubit>(
                                                        context)
                                                    .unfollow(state
                                                        .users[index].userId!);
                                              } else {
                                                //follow the user
                                                BlocProvider.of<
                                                            SearchPeopleCubit>(
                                                        context)
                                                    .follow(state
                                                        .users[index].userId!);
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
                                              isFollowed
                                                  ? "Unfollow"
                                                  : "Follow",
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
                                            //request to follow the other user only if the user is logged in
                                            if (isFollowed) {
                                              //unfollow the user
                                              BlocProvider.of<
                                                          SearchPeopleCubit>(
                                                      context)
                                                  .unfollow(state
                                                      .users[index].userId!);
                                            } else {
                                              //follow the user
                                              BlocProvider.of<
                                                          SearchPeopleCubit>(
                                                      context)
                                                  .follow(state
                                                      .users[index].userId!);
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
                                            isFollowed ? "Unfollow" : "Follow",
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
                            //navigate to the user page
                          },
                        ),
                      );
                    },
                  )
                : Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "No Users found !!",
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
