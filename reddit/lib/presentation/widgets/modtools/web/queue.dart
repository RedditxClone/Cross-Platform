import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class QueuesWidget extends StatefulWidget {
  String screen = '';
  String subredditName = '';
  QueuesWidget({required this.screen, required this.subredditName, super.key});

  @override
  State<QueuesWidget> createState() => _QueuesWidgetState();
}

class _QueuesWidgetState extends State<QueuesWidget> {
  @override
  void initState() {
    if (widget.screen == 'Edited') {
      BlocProvider.of<ModtoolsCubit>(context)
          .getEditedPosts(widget.subredditName);
    } else if (widget.screen == 'Spam') {
      BlocProvider.of<ModtoolsCubit>(context)
          .getSpammedPosts(widget.subredditName);
    } else if (widget.screen == 'Unmoderated') {
      BlocProvider.of<ModtoolsCubit>(context)
          .getUnmoderatedPosts(widget.subredditName);
    }
    super.initState();
  }

  Widget queue() {
    return SizedBox(
      width: 700,
      child: PostsWeb(),
    );
  }

  Widget emptyQueue() {
    return Container(
        width: 700,
        height: 450,
        color: defaultSecondaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Images/kitteh.png'),
              const Text('The queue is clean!', style: TextStyle(fontSize: 17)),
              const SizedBox(height: 10),
              const Text('Kitteh is pleased',
                  style: TextStyle(fontSize: 14, color: Colors.grey))
            ],
          ),
        ));
  }

  Widget loading() {
    return Container(
        width: 700,
        height: 450,
        color: defaultSecondaryColor,
        child: Container(
            padding: const EdgeInsets.only(top: 100),
            child: CircularProgressIndicator()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width - 1250 > 15
                    ? MediaQuery.of(context).size.width - 1250
                    : 15),
            Container(
              width: 700,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${widget.screen} ',
                            style: TextStyle(fontSize: 18),
                          ),
                          const Icon(Icons.info_outline)
                        ],
                      ),
                      UserData.user!.profilePic == null ||
                              UserData.user!.profilePic == ''
                          ? const CircleAvatar(
                              radius: 17,
                              child: Icon(
                                Icons.person,
                              ),
                            )
                          : CircleAvatar(
                              radius: 17,
                              backgroundImage: NetworkImage(
                                UserData.user!.profilePic!,
                              )),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: const [
                      Text('NEWEST FIRST', style: TextStyle(fontSize: 12)),
                      SizedBox(width: 30),
                      Text('POSTS AND COMMENTS',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<ModtoolsCubit, ModtoolsState>(
                    builder: (context, state) {
                      if (widget.screen == 'Mod Queue') {
                        return emptyQueue();
                      }
                      if (state is EditedPostsReady) {
                        if (state.posts.isNotEmpty &&
                            widget.screen == 'Edited') {
                          return Column(children: [
                            ...state.posts
                                .map((e) => PostsWeb(postsModel: e))
                                .toList()
                          ]);
                        } else if (state is Loading) {
                          return loading();
                        }
                        return emptyQueue();
                      }
                      if (state is SpammedPostsReady) {
                        if (state.posts.isNotEmpty && widget.screen == 'Spam') {
                          return Column(children: [
                            ...state.posts
                                .map((e) => PostsWeb(postsModel: e))
                                .toList()
                          ]);
                        } else if (state is Loading) {
                          return loading();
                        }
                        return emptyQueue();
                      }
                      if (state is UnmoderatedPostsReady) {
                        if (state.posts.isNotEmpty &&
                            widget.screen == 'Unmoderated') {
                          return Column(children: [
                            ...state.posts
                                .map((e) => PostsWeb(postsModel: e))
                                .toList()
                          ]);
                        } else if (state is Loading) {
                          return loading();
                        }
                        return emptyQueue();
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 1220 > 0
                    ? MediaQuery.of(context).size.width - 1220
                    : 0),
          ],
        ),
      ),
    );
  }
}
