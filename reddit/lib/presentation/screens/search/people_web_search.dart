// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
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
            return ListView.builder(
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
                              icon: const CircleAvatar(
                                  //will be replaced with the user's profile picture
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                  )),
                              label: Text(
                                "u/${state.users[index].username ?? ""}",
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
                              // state.users[index].about ?? "",
                              "aboadassssssssssssssssssssssssssssssssssssssssssssssssssssut",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        UserData.isLoggedIn
                            ? BlocBuilder<SearchPeopleCubit, SearchPeopleState>(
                                builder: (context, state2) {
                                  if (state2 is FollowUser) {
                                    isFollowed = state2.followed;
                                    return ElevatedButton(
                                      onPressed: () {
                                        //call the function to join the community
                                        //request to follow the other user only if the user is logged in
                                        if (isFollowed) {
                                          //unfollow the user
                                          BlocProvider.of<SearchPeopleCubit>(
                                                  context)
                                              .unfollow(
                                                  state.users[index].username!);
                                        } else {
                                          //follow the user
                                          BlocProvider.of<SearchPeopleCubit>(
                                                  context)
                                              .follow(
                                                  state.users[index].username!);
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
                                        isFollowed ? "Unfollow" : "Follow",
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
                                        BlocProvider.of<SearchPeopleCubit>(
                                                context)
                                            .unfollow(
                                                state.users[index].userId!);
                                      } else {
                                        //follow the user
                                        BlocProvider.of<SearchPeopleCubit>(
                                                context)
                                            .follow(
                                                state.users[index].userId!);
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
