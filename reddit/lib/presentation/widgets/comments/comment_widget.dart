import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/comments/add_comment_cubit.dart';
import 'package:reddit/business_logic/cubit/comments/comments_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/vote_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/model/comments/comment_submit.dart';
import 'package:reddit/data/repository/comments/comments_repository.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';
import 'package:reddit/data/web_services/comments/comments_web_services.dart';
import 'package:reddit/data/web_services/posts/post_actions_web_services.dart';

class CommentWidget extends StatelessWidget {
  Comments? commentsModel;
  late Responsive responsive;
  late PostActionsRepository postActionsRepository;
  late VoteCubit voteCubit;
  late CommentsRepository commentsRepository;
  late AddCommentCubit addCommentCubit;
  late TextEditingController _addCommentController;
  String? subredditID;
  CommentWidget({this.commentsModel, this.subredditID, super.key}) {
    postActionsRepository = PostActionsRepository(PostActionsWebServices());
    voteCubit = VoteCubit(postActionsRepository);
    commentsRepository = CommentsRepository(CommentsWebServices());
    addCommentCubit = AddCommentCubit(commentsRepository);
    _addCommentController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    if (commentsModel == null) {
      return Container();
    }
    return BlocListener<AddCommentCubit, AddCommentState>(
      bloc: addCommentCubit,
      listener: (context, state) {
        if (state is CommentAdded) {
          displayMsg(context, Colors.green, "Reply added!");
          BlocProvider.of<CommentsCubit>(context)
              .getThingComments(commentsModel!.postId!);
        }
      },
      child: Column(
        children: [
          commentInfo(context),
          commentText(),
          commentBottomButtons(context),
        ],
      ),
    );
  }

  Widget commentBottomButtons(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          responsive.isSmallSizedScreen()
              ? moreButtonMobile(context)
              : commentOptionsWeb(context),
          replyButton(context),
          voteButtonsSmallScreen()
        ],
      ),
    );
  }

  Widget replyButton(context) {
    return TextButton.icon(
      onPressed: () {
        _addCommentBottomSheet(context);
      },
      icon: const Icon(
        Icons.reply_rounded,
      ),
      label: const Text("Reply"),
      style:
          ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.grey)),
    );
  }

  Widget voteButtonsSmallScreen() {
    return BlocBuilder<VoteCubit, VoteState>(
      bloc: voteCubit,
      builder: (context, state) {
        if (state is UpVoted) {
          commentsModel!.voteType = "upvote";
          commentsModel!.votesCount = state.votesCount!.votesCount;
        } else if (state is DownVoted) {
          commentsModel!.voteType = "downvote";
          commentsModel!.votesCount = state.votesCount!.votesCount;
        } else if (state is UnVoted) {
          commentsModel!.voteType = null;
          commentsModel!.votesCount = state.votesCount!.votesCount;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // Upvote function
                if (commentsModel != null) {
                  if (commentsModel!.sId != null) {
                    if (commentsModel!.voteType == null) {
                      voteCubit.upVote(commentsModel!.sId!);
                    } else if (commentsModel!.voteType == "upvote") {
                      voteCubit.unVote(commentsModel!.sId!);
                    } else if (commentsModel!.voteType == "downvote") {
                      voteCubit.upVote(commentsModel!.sId!);
                    }
                  }
                }
              },
              icon: Icon(Icons.arrow_upward,
                  color: commentsModel == null
                      ? Colors.grey
                      : commentsModel!.voteType == null
                          ? Colors.grey
                          : commentsModel!.voteType! == "upvote"
                              ? Colors.red
                              : Colors.grey),
            ),
            Text(
              "${commentsModel == null ? 0 : commentsModel!.votesCount ?? 0}",
              style: TextStyle(
                  fontSize: 16,
                  color: commentsModel == null
                      ? Colors.grey
                      : commentsModel!.voteType == null
                          ? Colors.grey
                          : commentsModel!.voteType! == "upvote"
                              ? Colors.red
                              : commentsModel!.voteType! == "downvote"
                                  ? Colors.blue
                                  : Colors.grey),
            ),
            IconButton(
              onPressed: () {
                // Downvote function
                if (commentsModel != null) {
                  if (commentsModel!.sId != null) {
                    if (commentsModel!.voteType == null) {
                      voteCubit.downVote(commentsModel!.sId!);
                    } else if (commentsModel!.voteType == "downvote") {
                      voteCubit.unVote(commentsModel!.sId!);
                    } else if (commentsModel!.voteType == "upvote") {
                      voteCubit.downVote(commentsModel!.sId!);
                    }
                  }
                }
              },
              icon: Icon(Icons.arrow_downward,
                  color: commentsModel == null
                      ? Colors.grey
                      : commentsModel!.voteType == null
                          ? Colors.grey
                          : commentsModel!.voteType! == "downvote"
                              ? Colors.blue
                              : Colors.grey),
            ),
            // const SizedBox(width: 5),
          ],
        );
      },
    );
  }

  /// Builds the UI of the bottom sheet of comment options.
  void _commentBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.grey.shade900,
          ),
          // height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Card(
                color: Colors.grey.shade900,
                child: ListTile(
                  title: const Text("Save"),
                  leading: const Icon(Icons.turned_in_not),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                color: Colors.grey.shade900,
                child: ListTile(
                  title: const Text("Copy text"),
                  leading: const Icon(Icons.copy),
                  onTap: () {
                    Navigator.pop(context);
                    if (commentsModel != null) {
                      if (commentsModel!.text != null) {
                        Clipboard.setData(ClipboardData(
                          text: commentsModel!.text!,
                        )).then((_) {
                          debugPrint("Copied ${commentsModel!.text!}");
                          displayMsg(context, Colors.green,
                              "Your copy is ready for pasta!");
                        });
                      }
                    }
                  },
                ),
              ),
              Card(
                color: Colors.grey.shade900,
                child: ListTile(
                  title: const Text("Spam"),
                  leading: const Icon(Icons.report_problem_outlined),
                  onTap: () {
                    Navigator.pop(context);
                    // if (commentsModel != null) {
                    //   if (commentsModel!.sId != null) {
                    //     postActionsCubit.spamPost(commentsModel!.sId!);
                    //   }
                    // }
                  },
                ),
              ),
              Card(
                color: Colors.grey.shade900,
                child: ListTile(
                  title: const Text("Block account"),
                  leading: const Icon(Icons.block),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              UserData.user != null
                  ? commentsModel != null
                      ? commentsModel!.user != null
                          ? commentsModel!.user!.id != null
                              ? commentsModel!.user!.id == UserData.user!.userId
                                  ? Card(
                                      color: Colors.grey.shade900,
                                      child: ListTile(
                                        title: const Text("Delete comment"),
                                        leading: const Icon(Icons.delete),
                                        onTap: () {
                                          Navigator.pop(context);
                                          // delete comment function
                                          // removePostCubit
                                          //     .deletePost(commentsModel!.sId!);
                                        },
                                      ),
                                    )
                                  : Container()
                              : Container()
                          : Container()
                      : Container()
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  void _addCommentBottomSheet(parentContext) {
    showModalBottomSheet<void>(
      context: parentContext,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.grey.shade900,
            ),
            // height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0)),
                    // filled: true,
                    // fillColor: Colors.grey.shade800,
                  ),
                  autofocus: true,
                  controller: _addCommentController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colors.deepPurpleAccent.shade100,
                      ),
                      height: 33,
                      child: TextButton(
                        onPressed: () {
                          addCommentCubit.addComment(CommentSubmit.fromJson({
                            "parentId": commentsModel!.sId,
                            "subredditId": subredditID,
                            "postId": commentsModel!.postId,
                            "text": _addCommentController.text,
                          }));
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Reply",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget moreButtonMobile(context) {
    return InkWell(
      onTap: () {
        // Open bottom sheet
        _commentBottomSheet(context);
      },
      child: Row(children: const [
        Icon(Icons.more_horiz, color: Colors.grey),
        SizedBox(width: 5),
      ]),
    );
  }

  Widget commentText() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: MarkdownBody(
              data: commentsModel == null ? "" : commentsModel!.text ?? "",
              selectable: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget commentInfo(context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      // Go to user page
                      if (commentsModel != null) {
                        if (commentsModel!.user != null) {
                          if (commentsModel!.user!.id != null) {
                            if (UserData.user != null) {
                              if (commentsModel!.user!.id! ==
                                  UserData.user!.userId) {
                                Navigator.pushNamed(context, profilePageRoute);
                              } else {
                                Navigator.pushNamed(
                                    context, otherProfilePageRoute,
                                    arguments: commentsModel!.user!.username);
                              }
                            } else {
                              Navigator.pushNamed(
                                  context, otherProfilePageRoute,
                                  arguments: commentsModel!.user!.username);
                            }
                          }
                        }
                      }
                    },
                    child: commentsModel == null
                        ? const CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.person),
                          )
                        : commentsModel!.user == null
                            ? const CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.person),
                              )
                            : commentsModel!.user!.photo != null
                                ? commentsModel!.user!.photo! != ""
                                    ? CircleAvatar(
                                        radius: 15.0,
                                        backgroundImage: NetworkImage(
                                            imagesUrl +
                                                commentsModel!.user!.photo!),
                                        backgroundColor: Colors.transparent,
                                      )
                                    : const CircleAvatar(
                                        radius: 15.0,
                                        backgroundColor: Colors.transparent,
                                        child: Icon(Icons.person),
                                      )
                                : const CircleAvatar(
                                    radius: 15.0,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.person))),
                const SizedBox(width: 10),
                InkWell(
                  onTap: (() {
                    // Go to user page
                    if (commentsModel != null) {
                      if (commentsModel!.user != null) {
                        if (commentsModel!.user!.id != null) {
                          if (UserData.user != null) {
                            if (commentsModel!.user!.id! ==
                                UserData.user!.userId) {
                              Navigator.pushNamed(context, profilePageRoute);
                            } else {
                              Navigator.pushNamed(
                                  context, otherProfilePageRoute,
                                  arguments: commentsModel!.user!.username);
                            }
                          } else {
                            Navigator.pushNamed(context, otherProfilePageRoute,
                                arguments: commentsModel!.user!.username);
                          }
                        }
                      }
                    }
                  }),
                  child: Text(
                      "u/${commentsModel == null ? '' : commentsModel!.user == null ? "" : commentsModel!.user!.username ?? ''}",
                      style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// [context] : build context.
  /// [color] : color of the error msg to be displayer e.g. ('red' : error , 'blue' : success ).
  /// [title] : message to be displayed to the user.
  void displayMsg(BuildContext context, Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 400,
        content: Container(
            height: 50,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  width: 9,
                ),
                Logo(
                  Logos.reddit,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Widget commentOptionsWeb(context) {
    List<PopupMenuEntry> optionsList = [
      PopupMenuItem(
        value: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(
              Icons.copy,
              size: 13,
            ),
            SizedBox(width: 5),
            Text(
              "Copy text",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      // const PopupMenuDivider(),
      PopupMenuItem(
        value: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(
              Icons.report_problem_outlined,
              size: 10,
            ),
            SizedBox(width: 5),
            Text(
              "Spam",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(
              Icons.block,
              size: 10,
            ),
            SizedBox(width: 5),
            Text(
              "Block account",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      // PopupMenuItem(
      //   value: 3,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: const [
      //       Icon(
      //         Icons.hide_source,
      //         size: 10,
      //       ),
      //       SizedBox(width: 5),
      //       Text(
      //         "Hide",
      //         style: TextStyle(fontSize: 12),
      //       ),
      //     ],
      //   ),
      // ),
      UserData.user != null
          ? commentsModel != null
              ? commentsModel!.user != null
                  ? commentsModel!.user!.id != null
                      ? commentsModel!.user!.id == UserData.user!.userId
                          ? PopupMenuItem(
                              value: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    size: 10,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Delete",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          : const PopupMenuItem(
                              child: null,
                              enabled: false,
                            )
                      : const PopupMenuItem(
                          child: null,
                          enabled: false,
                        )
                  : const PopupMenuItem(
                      child: null,
                      enabled: false,
                    )
              : const PopupMenuItem(
                  child: null,
                  enabled: false,
                )
          : const PopupMenuItem(
              child: null,
              enabled: false,
            ),
    ];
    return PopupMenuButton(
      color: Colors.grey.shade900,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(0),
      // offset: Offset.fromDirection(0, 150),
      position: PopupMenuPosition.under,
      itemBuilder: (_) => optionsList,
      constraints: const BoxConstraints.expand(width: 130, height: 240),
      onSelected: (value) {
        switch (value) {
          case 0:
            if (commentsModel != null) {
              if (commentsModel!.text != null) {
                Clipboard.setData(ClipboardData(
                  text: commentsModel!.text!,
                )).then((_) {
                  debugPrint("Copied ${commentsModel!.text!}");
                  displayMsg(
                      context, Colors.green, "Your copy is ready for pasta!");
                });
              }
            }
            break;
          case 1:
            if (commentsModel != null) {
              if (commentsModel!.sId != null) {
                // postActionsCubit.spamPost(commentsModel!.sId!);
              }
            }
            break;
          case 2:
            break;
          // case 3:
          //   if (postsModel != null) {
          //     if (postsModel!.sId != null) {
          //       removePostCubit.hidePost(postsModel!.sId!);
          //     }
          //   }
          //   break;
          case 4:
            if (commentsModel != null) {
              if (commentsModel!.sId != null) {
                // removePostCubit.deletePost(commentsModel!.sId!);
              }
            }
            break;
          default:
            break;
        }
      },
      child: const Icon(Icons.more_horiz, color: Colors.grey),
    );
  }
}
