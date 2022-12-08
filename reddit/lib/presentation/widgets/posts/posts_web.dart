import 'package:flutter/material.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/posts/posts_model.dart';

class PostsWeb extends StatelessWidget {
  late Responsive responsive;
  PostsModel? postsModel;
  PostsWeb({this.postsModel, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return Container(
      // height: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: defaultSecondaryColor),
      margin: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          responsive.isSmallSizedScreen()
              ? const SizedBox(width: 0)
              // -------------------------------------------------------
              // -------------VOTE BUTTONS IN LARGE SCREEN--------------
              // -------------------------------------------------------
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 10),
                    IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      color: postsModel == null
                          ? Colors.grey
                          : postsModel!.voteType == null
                              ? Colors.grey
                              : postsModel!.voteType! == "up"
                                  ? Colors.red
                                  : Colors.grey,
                      onPressed: () {
                        // Upvote function
                      },
                    ),
                    // const SizedBox(height: 10),
                    Text(
                        "${postsModel == null ? 0 : postsModel!.votesCount ?? 0}",
                        style: TextStyle(
                            fontSize: 13,
                            color: postsModel == null
                                ? Colors.grey
                                : postsModel!.voteType == null
                                    ? Colors.grey
                                    : postsModel!.voteType! == "up"
                                        ? Colors.red
                                        : postsModel!.voteType! == "down"
                                            ? Colors.blue
                                            : Colors.grey)),
                    // const SizedBox(height: 10),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      color: postsModel == null
                          ? Colors.grey
                          : postsModel!.voteType == null
                              ? Colors.grey
                              : postsModel!.voteType! == "down"
                                  ? Colors.blue
                                  : Colors.grey,
                      onPressed: () {
                        // Downvote function
                      },
                    ),
                  ],
                ),
          Expanded(
            flex: 11,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // --------------------------------------------------
                // -----USER PHOTO, SUBREDDIT, USER, TIME------------
                // --------------------------------------------------
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onDoubleTap: () {
                              // Go to user page
                            },
                            child: CircleAvatar(
                              radius: 15.0,
                              backgroundImage: postsModel == null
                                  ? null
                                  : postsModel!.user == null
                                      ? null
                                      : postsModel!.user!.photo != null
                                          ? NetworkImage(
                                              postsModel!.user!.photo!)
                                          : null,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (() {
                                  // Go to subreddit page
                                }),
                                child: Text(
                                    "r/${postsModel == null ? '' : postsModel!.subreddit == null ? '' : postsModel!.subreddit!.name ?? ''}",
                                    style: const TextStyle(fontSize: 13)),
                              ),
                              InkWell(
                                onTap: (() {
                                  // Go to user page
                                }),
                                child: Text(
                                    "u/${postsModel == null ? '' : postsModel!.user == null ? "" : postsModel!.user!.username ?? ''} . ${getPostDate()}",
                                    style: const TextStyle(fontSize: 13)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // --------------------------------------------------
                // -------------------POST TITLE---------------------
                // --------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        postsModel == null ? "" : postsModel!.title ?? "",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade300),
                      ),
                    ),
                  ],
                ),
                // -------------------------------------------------
                // -------------------POST TEXT---------------------
                // -------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          postsModel == null ? "" : postsModel!.text ?? "",
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ],
                ),
                // --------------------------------------------------
                // -------------------POST PHOTO---------------------
                // --------------------------------------------------
                Container(
                  child: postsModel == null
                      ? null
                      : postsModel!.images == null
                          ? null
                          : postsModel!.images!.isNotEmpty
                              ? Image(
                                  image: NetworkImage(postsModel!.images![0]))
                              : null,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // --------------------------------------------------
                        // ---------VOTE BUTTONS SMALL SCREEN----------------
                        // --------------------------------------------------
                        responsive.isSmallSizedScreen()
                            ? Row(children: [
                                IconButton(
                                  onPressed: () {
                                    //upvote with postID
                                  },
                                  icon: Icon(Icons.arrow_upward,
                                      color: postsModel == null
                                          ? Colors.grey
                                          : postsModel!.voteType == null
                                              ? Colors.grey
                                              : postsModel!.voteType! == "up"
                                                  ? Colors.red
                                                  : Colors.grey),
                                ),
                                Text(
                                    "${postsModel == null ? 0 : postsModel!.votesCount ?? 0}",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: postsModel == null
                                            ? Colors.grey
                                            : postsModel!.voteType == null
                                                ? Colors.grey
                                                : postsModel!.voteType! == "up"
                                                    ? Colors.red
                                                    : postsModel!.voteType! ==
                                                            "down"
                                                        ? Colors.blue
                                                        : Colors.grey)),
                                IconButton(
                                    onPressed: () {
                                      //downvote with postID
                                    },
                                    icon: Icon(Icons.arrow_downward,
                                        color: postsModel == null
                                            ? Colors.grey
                                            : postsModel!.voteType == null
                                                ? Colors.grey
                                                : postsModel!.voteType! ==
                                                        "down"
                                                    ? Colors.blue
                                                    : Colors.grey)),
                                const SizedBox(width: 5),
                              ])
                            : const SizedBox(width: 0),
                        // --------------------------------------------------
                        // --------------COMMENTS BUTTON---------------------
                        // --------------------------------------------------
                        InkWell(
                          onTap: () {
                            // Open post page
                            // Display comments with postID
                          },
                          child: Row(children: [
                            const Icon(Icons.comment_outlined,
                                color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(
                                "${postsModel == null ? 0 : postsModel!.commentCount ?? 0} Comments",
                                style: const TextStyle(fontSize: 13)),
                          ]),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Row(children: const [
                            Icon(Icons.add_box_outlined, color: Colors.grey),
                            SizedBox(width: 5),
                            Text("Awards", style: TextStyle(fontSize: 13)),
                          ]),
                        ),
                        const SizedBox(width: 10),
                        responsive.isSmallSizedScreen()
                            ? const SizedBox(width: 0)
                            : InkWell(
                                onTap: () {},
                                child: Row(children: const [
                                  Icon(Icons.file_upload_outlined,
                                      color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text("Share", style: TextStyle(fontSize: 13)),
                                ]),
                              ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Row(children: const [
                            Icon(Icons.turned_in_not, color: Colors.grey),
                            SizedBox(width: 5),
                            Text("Save", style: TextStyle(fontSize: 13)),
                          ]),
                        ),
                        MediaQuery.of(context).size.width < 550
                            ? const SizedBox(width: 0)
                            : const SizedBox(width: 10),
                        MediaQuery.of(context).size.width < 550
                            ? const SizedBox(width: 0)
                            : InkWell(
                                onTap: () {},
                                child: Row(children: const [
                                  Icon(Icons.tornado_outlined,
                                      color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text("Tip", style: TextStyle(fontSize: 13)),
                                ]),
                              ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Row(children: const [
                            Icon(Icons.more_horiz, color: Colors.grey),
                            SizedBox(width: 5),
                          ]),
                        ),
                        const SizedBox(width: 10),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getPostDate() {
    DateTime? parsedDate = DateTime.tryParse(
        "${postsModel == null ? '' : postsModel!.publishedDate}");
    if (parsedDate == null) {
      return "";
    }
    final now = DateTime.now();
    String letter = "";
    String number = "";
    if (parsedDate.year == now.year) {
      if (parsedDate.month == now.month) {
        if (parsedDate.day == now.day) {
          if (parsedDate.hour == now.hour) {
            if (parsedDate.minute == now.minute) {
              letter = "s";
              number = "${now.second - parsedDate.second}";
            } else {
              letter = "m";
              number = "${now.minute - parsedDate.minute}";
            }
          } else {
            letter = "h";
            number = "${now.hour - parsedDate.hour}";
          }
        } else {
          letter = "d";
          number = "${now.day - parsedDate.day}";
        }
      } else {
        letter = "M";
        number = "${now.month - parsedDate.month}";
      }
    } else {
      letter = "y";
      number = "${now.year - parsedDate.year}";
    }
    // debugPrint("${postsModel!.numVotes!}");
    return number + letter;
  }
}
