import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/comments/comments_cubit.dart';
import 'package:reddit/business_logic/cubit/end_drawer/end_drawer_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/model/post_model.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/end_drawer/end_drawer_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/presentation/widgets/comments/comment_widget.dart';
import 'package:reddit/presentation/widgets/comments/comments_with_children_init.dart';
import 'package:reddit/presentation/widgets/comments/recursive_comment_with_children_widget.dart';
import 'package:reddit/presentation/widgets/home_widgets/end_drawer.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class PostPage extends StatefulWidget {
  Object? arguments;
  PostsModel? postModel;
  PostPage({this.arguments, super.key}) {
    if (arguments != null) {
      Map<String, dynamic>? tempArg = arguments as Map<String, dynamic>?;
      if (tempArg != null) {
        postModel = tempArg["post"];
      }
    }
  }

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    if (widget.postModel != null) {
      debugPrint("${widget.postModel!.sId}");
      BlocProvider.of<CommentsCubit>(context)
          .getThingComments(widget.postModel!.sId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
          const SizedBox(
            width: 15,
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: UserData.user != null && UserData.user!.profilePic != ""
                ? CircleAvatar(
                    // radius: 16,
                    backgroundImage: NetworkImage(UserData.user!.profilePic!),
                  )
                : const CircleAvatar(
                    // radius: 16,
                    child: Icon(Icons.person),
                  ),
          )
        ],
      ),
      endDrawer: BlocProvider(
        create: (context) =>
            EndDrawerCubit(EndDrawerRepository(SettingsWebServices())),
        child: EndDrawer(
          2,
          35,
        ),
      ),
      body: ListView(
        children: [
          PostsWeb(
            postsModel: widget.postModel,
            insidePostPage: true,
          ),
          BlocBuilder<CommentsCubit, CommentsState>(
            builder: (context, state) {
              if (state is CommentsLoaded) {
                debugPrint("Comments loaded successfully");
                return Column(
                  children: [
                    ...state.comments!
                        .map((e) => CommentsWithChildrenInit(
                              commentsModel: e,
                            ))
                        .toList(),
                  ],
                );
              } else if (state is CommentsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          ),
          // CommentsWithChildrenInit(
          //   commentsModel: Comments.fromJson(
          //     {
          //       "_id": "639e196db56932b9f814b21f",
          //       "text": "Reply 1",
          //       "votesCount": 0,
          //       "parentId": "639a277d3eb38f2c2fb096a9",
          //       "spammedBy": "null",
          //       "spammedAt": "null",
          //       "postId": "639a277d3eb38f2c2fb096a9",
          //       "user": {
          //         "id": "638f9b2231186b7fd21bae78",
          //         "photo": "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //         "username": "bemoi1",
          //         "isFollowed": false,
          //         "cakeDay": true
          //       },
          //       "voteType": "null",
          //       "children": [
          //         {
          //           "_id": "639e286602ae224054a52e07",
          //           "text": "Reply 2",
          //           "votesCount": 0,
          //           "parentId": "639e196db56932b9f814b21f",
          //           "spammedBy": "null",
          //           "spammedAt": "null",
          //           "postId": "639a277d3eb38f2c2fb096a9",
          //           "user": {
          //             "id": "638f9b2231186b7fd21bae78",
          //             "photo":
          //                 "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //             "username": "bemoi1",
          //             "isFollowed": false,
          //             "cakeDay": true
          //           },
          //           "voteType": "null",
          //           "children": [
          //             {
          //               "_id": "639e286602ae224054a52e07",
          //               "text": "Reply 3",
          //               "votesCount": 0,
          //               "parentId": "639e196db56932b9f814b21f",
          //               "spammedBy": "null",
          //               "spammedAt": "null",
          //               "postId": "639a277d3eb38f2c2fb096a9",
          //               "user": {
          //                 "id": "638f9b2231186b7fd21bae78",
          //                 "photo":
          //                     "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //                 "username": "bemoi1",
          //                 "isFollowed": false,
          //                 "cakeDay": true
          //               },
          //               "voteType": "null",
          //               "children": []
          //             }
          //           ]
          //         },
          //         {
          //           "_id": "639e286602ae224054a52e07",
          //           "text": "Reply 2",
          //           "votesCount": 0,
          //           "parentId": "639e196db56932b9f814b21f",
          //           "spammedBy": "null",
          //           "spammedAt": "null",
          //           "postId": "639a277d3eb38f2c2fb096a9",
          //           "user": {
          //             "id": "638f9b2231186b7fd21bae78",
          //             "photo":
          //                 "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //             "username": "bemoi1",
          //             "isFollowed": false,
          //             "cakeDay": true
          //           },
          //           "voteType": "null",
          //           "children": [
          //             {
          //               "_id": "639e286602ae224054a52e07",
          //               "text": "Reply 3",
          //               "votesCount": 0,
          //               "parentId": "639e196db56932b9f814b21f",
          //               "spammedBy": "null",
          //               "spammedAt": "null",
          //               "postId": "639a277d3eb38f2c2fb096a9",
          //               "user": {
          //                 "id": "638f9b2231186b7fd21bae78",
          //                 "photo":
          //                     "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //                 "username": "bemoi1",
          //                 "isFollowed": false,
          //                 "cakeDay": true
          //               },
          //               "voteType": "null",
          //               "children": [
          //                 {
          //                   "_id": "639e196db56932b9f814b21f",
          //                   "text": "Reply 1",
          //                   "votesCount": 0,
          //                   "parentId": "639a277d3eb38f2c2fb096a9",
          //                   "spammedBy": "null",
          //                   "spammedAt": "null",
          //                   "postId": "639a277d3eb38f2c2fb096a9",
          //                   "user": {
          //                     "id": "638f9b2231186b7fd21bae78",
          //                     "photo":
          //                         "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //                     "username": "bemoi1",
          //                     "isFollowed": false,
          //                     "cakeDay": true
          //                   },
          //                   "voteType": "null",
          //                   "children": [
          //                     {
          //                       "_id": "639e286602ae224054a52e07",
          //                       "text": "Reply 2",
          //                       "votesCount": 0,
          //                       "parentId": "639e196db56932b9f814b21f",
          //                       "spammedBy": "null",
          //                       "spammedAt": "null",
          //                       "postId": "639a277d3eb38f2c2fb096a9",
          //                       "user": {
          //                         "id": "638f9b2231186b7fd21bae78",
          //                         "photo":
          //                             "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //                         "username": "bemoi1",
          //                         "isFollowed": false,
          //                         "cakeDay": true
          //                       },
          //                       "voteType": "null",
          //                       "children": [
          //                         {
          //                           "_id": "639e286602ae224054a52e07",
          //                           "text": "Reply 3",
          //                           "votesCount": 0,
          //                           "parentId": "639e196db56932b9f814b21f",
          //                           "spammedBy": "null",
          //                           "spammedAt": "null",
          //                           "postId": "639a277d3eb38f2c2fb096a9",
          //                           "user": {
          //                             "id": "638f9b2231186b7fd21bae78",
          //                             "photo":
          //                                 "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //                             "username": "bemoi1",
          //                             "isFollowed": false,
          //                             "cakeDay": true
          //                           },
          //                           "voteType": "null",
          //                           "children": []
          //                         }
          //                       ]
          //                     },
          //                     {
          //                       "_id": "639e286602ae224054a52e07",
          //                       "text": "Reply 2",
          //                       "votesCount": 0,
          //                       "parentId": "639e196db56932b9f814b21f",
          //                       "spammedBy": "null",
          //                       "spammedAt": "null",
          //                       "postId": "639a277d3eb38f2c2fb096a9",
          //                       "user": {
          //                         "id": "638f9b2231186b7fd21bae78",
          //                         "photo":
          //                             "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //                         "username": "bemoi1",
          //                         "isFollowed": false,
          //                         "cakeDay": true
          //                       },
          //                       "voteType": "null",
          //                       "children": [
          //                         {
          //                           "_id": "639e286602ae224054a52e07",
          //                           "text": "Reply 3",
          //                           "votesCount": 0,
          //                           "parentId": "639e196db56932b9f814b21f",
          //                           "spammedBy": "null",
          //                           "spammedAt": "null",
          //                           "postId": "639a277d3eb38f2c2fb096a9",
          //                           "user": {
          //                             "id": "638f9b2231186b7fd21bae78",
          //                             "photo":
          //                                 "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //                             "username": "bemoi1",
          //                             "isFollowed": false,
          //                             "cakeDay": true
          //                           },
          //                           "voteType": "null",
          //                           "children": []
          //                         }
          //                       ]
          //                     }
          //                   ]
          //                 },
          //               ]
          //             }
          //           ]
          //         }
          //       ]
          //     },
          //   ),
          // ),
          // CommentsWithChildrenInit(
          //   commentsModel: Comments.fromJson(
          //     {
          //       "_id": "639e196db56932b9f814b21f",
          //       "text": "Reply 1",
          //       "votesCount": 0,
          //       "parentId": "639a277d3eb38f2c2fb096a9",
          //       "spammedBy": "null",
          //       "spammedAt": "null",
          //       "postId": "639a277d3eb38f2c2fb096a9",
          //       "user": {
          //         "id": "638f9b2231186b7fd21bae78",
          //         "photo": "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //         "username": "bemoi1",
          //         "isFollowed": false,
          //         "cakeDay": true
          //       },
          //       "voteType": "null",
          //       "children": [
          //         {
          //           "_id": "639e286602ae224054a52e07",
          //           "text": "Reply 2",
          //           "votesCount": 0,
          //           "parentId": "639e196db56932b9f814b21f",
          //           "spammedBy": "null",
          //           "spammedAt": "null",
          //           "postId": "639a277d3eb38f2c2fb096a9",
          //           "user": {
          //             "id": "638f9b2231186b7fd21bae78",
          //             "photo":
          //                 "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //             "username": "bemoi1",
          //             "isFollowed": false,
          //             "cakeDay": true
          //           },
          //           "voteType": "null",
          //           "children": [
          //             {
          //               "_id": "639e286602ae224054a52e07",
          //               "text": "Reply 3",
          //               "votesCount": 0,
          //               "parentId": "639e196db56932b9f814b21f",
          //               "spammedBy": "null",
          //               "spammedAt": "null",
          //               "postId": "639a277d3eb38f2c2fb096a9",
          //               "user": {
          //                 "id": "638f9b2231186b7fd21bae78",
          //                 "photo":
          //                     "assets/profilePhotos/638f9b2231186b7fd21bae78.jpeg",
          //                 "username": "bemoi1",
          //                 "isFollowed": false,
          //                 "cakeDay": true
          //               },
          //               "voteType": "null",
          //               "children": []
          //             }
          //           ]
          //         }
          //       ]
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
