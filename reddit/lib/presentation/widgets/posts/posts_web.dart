import 'package:flutter/material.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PostsWeb extends StatelessWidget {
  late Responsive responsive;
  CarouselController buttonCarouselController = CarouselController();
  final String _markdownData = """
 # Minimal Markdown Test
 ---
 This is a simple Markdown test. Provide a text string with Markdown tags
 to the Markdown widget and it will display the formatted output in a
 scrollable widget.

 ## Section 1
 Maecenas eget **arcu egestas**, mollis ex vitae, posuere magna. Nunc eget
 aliquam tortor. Vestibulum porta sodales efficitur. Mauris interdum turpis
 eget est condimentum, vitae porttitor diam ornare.

 ### Subsection A
 Sed et massa finibus, blandit massa vel, vulputate velit. Vestibulum vitae
 venenatis libero. **__Curabitur sem lectus, feugiat eu justo in, eleifend
 accumsan ante.__** Sed a fermentum elit. Curabitur sodales metus id mi
 ornare, in ullamcorper magna congue.
 """;
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
              // -------------------------------------------------------
              // -------NO SIDE VOTE BUTTONS FOR SMALL SCREEN----------
              // -------------------------------------------------------
              ? const SizedBox(width: 0)
              // -------------------------------------------------------
              // -------LEFT SIDE VOTE BUTTONS IN LARGE SCREEN----------
              // -------------------------------------------------------
              : voteButtonsLargeScreen(),
          Expanded(
            flex: 11,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // --------------------------------------------------
                // -----USER PHOTO, SUBREDDIT, USER, TIME------------
                // --------------------------------------------------
                postInfo(),
                // --------------------------------------------------
                // -------------------POST TITLE---------------------
                // --------------------------------------------------
                postTitle(),
                // -------------------------------------------------
                // -------------------POST TEXT---------------------
                // -------------------------------------------------
                postText(),
                // --------------------------------------------------
                // --------------POST PHOTOS, VIDEOS-----------------
                // --------------------------------------------------
                postMedia(),
                // --------------------------------------------------
                // ---------------POST BOTTOM BUTTONS----------------
                // --------------------------------------------------
                postBottomButtons(),
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
    // debugPrint("${DateTime.now().difference(parsedDate)}");
    // Duration timeDifference = DateTime.now().difference(parsedDate);
    return number + letter;
  }

  Widget voteButtonsLargeScreen() {
    return Column(
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
        Text("${postsModel == null ? 0 : postsModel!.votesCount ?? 0}",
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
    );
  }

  Widget postInfo() {
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
                                    imagesUrl + postsModel!.user!.photo!)
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
    );
  }

  Widget postTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              postsModel == null ? "" : postsModel!.title ?? "",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  Widget postText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
            child: MarkdownBody(
              data: postsModel == null ? "" : postsModel!.text ?? "",
              // style: TextStyle(fontSize: 15, color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  Widget postMedia() {
    return Container(
      child: postsModel == null
          ? null
          : postsModel!.images == null
              ? null
              : postsModel!.images!.isNotEmpty
                  ? Row(
                      children: [
                        // -----------------------------------------------------
                        // -----PREVIOUS IMAGE BUTTON IN LARGE SCREEN-----------
                        // -----------------------------------------------------
                        postsModel!.images!.length > 1 &&
                                !responsive.isSmallSizedScreen()
                            ? previousImageButton()
                            : Container(),
                        // -----------------------------------------------------
                        // -------------------MEDIA SLIDER----------------------
                        // -----------------------------------------------------
                        Expanded(
                          flex: 10,
                          child: CarouselSlider(
                            items: postsModel!.images!
                                .map((e) => Image.network(imagesUrl + e))
                                .toList(),
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              aspectRatio: 5 / 4,
                              enableInfiniteScroll: false,
                            ),
                          ),
                        ),
                        // -----------------------------------------------------
                        // ---------NEXT IMAGE BUTTON IN LARGE SCREEN-----------
                        // -----------------------------------------------------
                        postsModel!.images!.length > 1 &&
                                !responsive.isSmallSizedScreen()
                            ? nextImageButton()
                            : Container(),
                      ],
                    )
                  : null,
    );
  }

  Widget postBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: responsive.isSmallSizedScreen()
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            // --------------------------------------------------
            // ---------VOTE BUTTONS SMALL SCREEN----------------
            // --------------------------------------------------
            responsive.isSmallSizedScreen()
                ? voteButtonsSmallScreen()
                : const SizedBox(width: 0),
            // --------------------------------------------------
            // --------------COMMENTS BUTTON---------------------
            // --------------------------------------------------
            commentsButton(),
            const SizedBox(width: 10),
            // --------------------------------------------------
            // -----------------SHARE BUTTON---------------------
            // --------------------------------------------------
            responsive.isSmallSizedScreen()
                ? const SizedBox(width: 0)
                : shareButton(),
            const SizedBox(width: 10),
            // --------------------------------------------------
            // -----------------SAVE BUTTON---------------------
            // --------------------------------------------------
            saveButton(),
            const SizedBox(width: 10),
            // --------------------------------------------------
            // -----------------MORE BUTTON---------------------
            // --------------------------------------------------
            moreButton(),
            const SizedBox(width: 10),
          ]),
    );
  }

  Widget voteButtonsSmallScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        Text("${postsModel == null ? 0 : postsModel!.votesCount ?? 0}",
            style: TextStyle(
                fontSize: 10,
                color: postsModel == null
                    ? Colors.grey
                    : postsModel!.voteType == null
                        ? Colors.grey
                        : postsModel!.voteType! == "up"
                            ? Colors.red
                            : postsModel!.voteType! == "down"
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
                        : postsModel!.voteType! == "down"
                            ? Colors.blue
                            : Colors.grey)),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget commentsButton() {
    return InkWell(
      onTap: () {
        // Open post page
        // Display comments with postID
      },
      child: Row(
        children: [
          const Icon(Icons.comment_outlined, color: Colors.grey),
          const SizedBox(width: 5),
          Text(
              "${postsModel == null ? 0 : postsModel!.commentCount ?? 0} Comments",
              style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget shareButton() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: const [
          Icon(Icons.file_upload_outlined, color: Colors.grey),
          SizedBox(width: 5),
          Text("Share", style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget saveButton() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: const [
          Icon(Icons.turned_in_not, color: Colors.grey),
          SizedBox(width: 5),
          Text("Save", style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget moreButton() {
    return InkWell(
      onTap: () {},
      child: Row(children: const [
        Icon(Icons.more_horiz, color: Colors.grey),
        SizedBox(width: 5),
      ]),
    );
  }

  Widget previousImageButton() {
    return IconButton(
      onPressed: () => buttonCarouselController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear),
      icon: const Icon(Icons.arrow_circle_left),
    );
  }

  Widget nextImageButton() {
    return IconButton(
      onPressed: () => buttonCarouselController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear),
      icon: const Icon(Icons.arrow_circle_right),
    );
  }
}
