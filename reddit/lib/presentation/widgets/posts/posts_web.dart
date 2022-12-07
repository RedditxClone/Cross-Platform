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
      height: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: defaultSecondaryColor),
      margin: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          responsive.isSmallSizedScreen()
              ? const SizedBox(width: 0)
              : Expanded(
                  child: Container(
                  color: defaultSecondaryColor.withOpacity(0.001),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Icon(Icons.arrow_upward,
                          color: postsModel == null
                              ? Colors.grey
                              : postsModel!.voteType == null
                                  ? Colors.grey
                                  : postsModel!.voteType! == "up"
                                      ? Colors.red
                                      : Colors.grey),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
                      Icon(Icons.arrow_downward,
                          color: postsModel == null
                              ? Colors.grey
                              : postsModel!.voteType == null
                                  ? Colors.grey
                                  : postsModel!.voteType! == "down"
                                      ? Colors.blue
                                      : Colors.grey),
                    ],
                  ),
                )),
          Expanded(
            flex: 11,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(
                              Icons.person_pin,
                              size: 50,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "r/${postsModel == null ? '' : postsModel!.subreddit == null ? '' : postsModel!.subreddit!.name ?? ''}",
                                    style: const TextStyle(fontSize: 13)),
                                Text(
                                    "u/${postsModel == null ? '' : postsModel!.user == null ? "" : postsModel!.user!.username ?? ''} . ${getPostDate()}",
                                    style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                          ]),
                        ])),
                Container(
                  height: 470,
                  width: double.infinity,
                  color: Colors.white12,
                  // child: const Text("This is a post",
                  //     style:
                  //         TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                        InkWell(
                          onTap: () {
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
