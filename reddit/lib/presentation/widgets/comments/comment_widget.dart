import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/posts/vote_cubit.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/comments/comment_model.dart';
import 'package:reddit/data/repository/posts/post_actions_repository.dart';
import 'package:reddit/data/web_services/posts/post_actions_web_services.dart';

class CommentWidget extends StatelessWidget {
  Comments? commentsModel;
  late Responsive responsive;
  late PostActionsRepository postActionsRepository;
  late VoteCubit voteCubit;
  CommentWidget({this.commentsModel, super.key}) {
    postActionsRepository = PostActionsRepository(PostActionsWebServices());
    voteCubit = VoteCubit(postActionsRepository);
  }
  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    if (commentsModel == null) {
      return Container();
    }
    return Container(
      // height: 200,
      // width: 200,
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
          // --------------------------------------------------
          // ---------VOTE BUTTONS SMALL SCREEN----------------
          // --------------------------------------------------
          moreButtonMobile(context),
          replyButton(),
          voteButtonsSmallScreen()
        ],
      ),
    );
  }

  Widget replyButton() {
    return TextButton.icon(
      onPressed: () {},
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

  /// Builds the UI of the bottom sheet shown when choosing gender.
  void _commentBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
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
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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

              // UserData.user != null
              //     ? commentsModel != null
              //         ? commentsModel!.user != null
              //             ? commentsModel!.user!.id != null
              //                 ? commentsModel!.user!.id == UserData.user!.userId
              //                     ? Card(
              //                         color: Colors.grey.shade900,
              //                         child: ListTile(
              //                           title: const Text("Delete post"),
              //                           leading: const Icon(Icons.delete),
              //                           onTap: () {
              //                             Navigator.pop(context);
              //                             removePostCubit
              //                                 .deletePost(commentsModel!.sId!);
              //                           },
              //                         ),
              //                       )
              //                     : Container()
              //                 : Container()
              //             : Container()
              //         : Container()
              //     : Container(),
            ],
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
}
