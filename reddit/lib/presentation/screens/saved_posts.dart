import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/presentation/screens/saved_tab_bar.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/constants/colors.dart';

import 'package:reddit/data/model/saved_posts_model.dart';
import 'package:reddit/business_logic/cubit/cubit/saved_posts_cubit.dart';

class SavedPosts extends StatefulWidget {
  const SavedPosts({super.key});

  @override
  State<SavedPosts> createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {
  late List<SavedPostsModel> savedPosts;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SavedPostsCubit>(context).getAllSavedPosts();
  }

  Widget createAllSavedPostsContainer(
      String id,
      String title,
      int votesCount,
      int commentCount,
      String subredditId,
      String subredditName,
      String userName,
      String userId,
      String userPhoto,
      String publishedDate,
      String text,
      Color c) {
    return Container(
      color: const Color.fromARGB(0, 0, 0, 0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(0, 0, 0, 0),
              ),
            ),
            Expanded(
              flex: 70,
              child: Container(
                color: c,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: c,
                      ),
                    ),
                    Expanded(
                      flex: 100,
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            //Title Row
                            Expanded(
                              child: SizedBox(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Logo(
                                      Logos.reddit,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  title: Column(
                                    children: [
                                      Row(children: <Widget>[
                                        //Massage info Row
                                        Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Text(
                                              "r/$subredditName ",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 15, 116, 12),
                                              ),
                                            )),
                                      ]),
                                      Row(children: <Widget>[
                                        //Massage info Row
                                        Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Text(
                                              "u/$userName ",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 15, 116, 12),
                                              ),
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              " . $publishedDate ago",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 105, 105, 105),
                                              ),
                                            )),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                          Column(
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  child: Column(
                                    children: [
                                      Row(children: <Widget>[
                                        //Post title Row
                                        Expanded(
                                          child: SizedBox(
                                              child: Text(
                                            title,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 213, 208, 208),
                                            ),
                                          )),
                                        ),
                                      ]),
                                      Row(children: <Widget>[
                                        //Post Body Row
                                        Expanded(
                                          child: SizedBox(
                                              child: Text(
                                            text,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 213, 208, 208),
                                            ),
                                          )),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 5, bottom: 30),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.arrow_upward,
                                                color: Colors.grey)),
                                        Text("$votesCount",
                                            style:
                                                const TextStyle(fontSize: 17)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.arrow_downward,
                                                color: Colors.grey)),
                                        const SizedBox(width: 10),
                                      ]),
                                      Row(children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.comment_outlined,
                                                color: Colors.grey)),
                                        Text("$commentCount Comments",
                                            style:
                                                const TextStyle(fontSize: 17)),
                                      ]),
                                      Row(children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.share,
                                                color: Colors.grey)),
                                        const Text("Share",
                                            style: TextStyle(fontSize: 17)),
                                      ]),
                                      Row(children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.save,
                                                color: Colors.grey)),
                                        const Text("Unsave",
                                            style: TextStyle(fontSize: 17)),
                                      ]),
                                      Row(children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.grey)),
                                        const Text("Hide",
                                            style: TextStyle(fontSize: 17)),
                                      ]),
                                      Row(children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.flag,
                                                color: Colors.grey)),
                                        const Text("Report",
                                            style: TextStyle(fontSize: 17)),
                                      ]),
                                    ]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        color: c,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAllSavedPostsContainerWidgets(
      List<SavedPostsModel> savedPostsList) {
    return Column(
        children: savedPostsList
            .map((savedPost) => createAllSavedPostsContainer(
                savedPost.id,
                savedPost.title,
                savedPost.votesCount,
                savedPost.commentCount,
                savedPost.subredditId,
                savedPost.subredditName,
                savedPost.userName,
                savedPost.userId,
                savedPost.userPhoto,
                savedPost.publishedDate,
                savedPost.text,
                const Color.fromARGB(255, 27, 26, 26)))
            .toList());
  }

  Widget getAllSavedPosts(List<SavedPostsModel> savedPostsList) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 100),
        child: Column(children: <Widget>[
          getAllSavedPostsContainerWidgets(savedPostsList)
        ]),
      ),
    );
  }

  Widget _savedPostsBody(context, List<SavedPostsModel> savedPosts) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width - 1200 > 0
                  ? MediaQuery.of(context).size.width - 1200
                  : 0),
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width - 1200 > 0
                ? 800
                : MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: cardsColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getAllSavedPosts(savedPosts),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 1200 > 0
                  ? MediaQuery.of(context).size.width - 1200
                  : 0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          automaticallyImplyLeading: false,
          backgroundColor: defaultAppbarBackgroundColor,
          title: const AppBarWebLoggedIn(screen: 'Saved')),
      body: BlocBuilder<SavedPostsCubit, SavedPostsState>(
        builder: (context, state) {
          if (state is SavedPostsLoaded) {
            savedPosts = (state).savedPosts;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SavedTabBar(index: 0),
                  _savedPostsBody(context, savedPosts),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SavedTabBar(index: 0),
                  Container(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
