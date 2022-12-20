import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reddit/business_logic/cubit/new_post/post_subreddit_preview_cubit.dart';
import 'package:reddit/data/model/post_model.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_sizes.dart';
import '../../../constants/strings.dart';
import '../../../data/model/subreddit_model.dart';

class PostSubredditPreviewScreen extends StatefulWidget {
  final PostModel postModel;
  final SubredditModel subredditModel;
  const PostSubredditPreviewScreen(
      {super.key, required this.postModel, required this.subredditModel});

  @override
  State<PostSubredditPreviewScreen> createState() =>
      _PostSubredditPreviewScreenState();
}

class _PostSubredditPreviewScreenState
    extends State<PostSubredditPreviewScreen> {
  late PostModel _postModel;
  late SubredditModel _subredditModel;

  bool _enable = true;
  @override
  void initState() {
    _postModel = widget.postModel;
    _subredditModel = widget.subredditModel;
    super.initState();
    BlocProvider.of<PostSubredditPreviewCubit>(context).createBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostSubredditPreviewCubit, PostSubredditPreviewState>(
      listener: (context, state) async {
        if (state is CreatePostCreated) {
          Navigator.popUntil(
              context, ModalRoute.withName(createPostScreenRoute));
        }
      },
      builder: (context, state) {
        _enable = _postModel.title.isNotEmpty;
        print(_postModel.title);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 10, 8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: lightFontColor,
                    backgroundColor:
                        _enable ? const Color(0xff368fe9) : cardsColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                  ),
                  onPressed: _enable
                      ? () {
                          print("Pressed" + _postModel.text + _postModel.title);
                          BlocProvider.of<PostSubredditPreviewCubit>(context)
                              .postButtonPressed();
                          BlocProvider.of<PostSubredditPreviewCubit>(context)
                              .submitPost(_postModel);
                        }
                      : null,
                  child: const Text("Post"),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Theme(
                            data: Theme.of(context).copyWith(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, postToMobileScreenRoute,
                                    arguments: _postModel);
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.blue,
                                      foregroundImage:
                                          _subredditModel.icon != null
                                              ? NetworkImage(
                                                  _subredditModel.icon!,
                                                )
                                              : null,
                                      child: _subredditModel.icon == null
                                          ? CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 10,
                                              child: Text(
                                                "r/",
                                                style: GoogleFonts.ibmPlexSans(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            )
                                          : null),
                                  Text(
                                    "r/${_subredditModel.name}",
                                    style: GoogleFonts.ibmPlexSans(
                                        fontSize: subHeaderFontSize,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff378ee7)),
                                  ),
                                  const Icon(
                                    Icons.expand_more,
                                    color: darkFontColor,
                                  )
                                ],
                              ),
                            )),
                        Theme(
                            data: Theme.of(context).copyWith(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: const Color(0xff378ee7)),
                                onPressed: () {},
                                child: Text(
                                  "Rules",
                                  style: GoogleFonts.ibmPlexSans(
                                    fontSize: subHeaderFontSize,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )))
                      ]),
                ),
                //TODO: show post
                // Theme(
                //   data: Theme.of(context).copyWith(
                //     highlightColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     hoverColor: Colors.transparent,
                //   ),
                //   child:

                SizedBox(
                  width: double.infinity,
                  child: Card(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xff242424), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _postModel.title,
                                style: GoogleFonts.ibmPlexSans(
                                    fontSize: subHeaderFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: lightFontColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _postModel.text,
                                style: GoogleFonts.ibmPlexSans(
                                    fontSize: subHeaderFontSize,
                                    fontWeight: FontWeight.w400,
                                    color: darkFontColor),
                              ),
                            ]),
                      )),
                ),
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: _postModel.nsfw
                                ? lightFontColor
                                : const Color(0xff181818),
                            foregroundColor: _postModel.nsfw
                                ? const Color(0xff181818)
                                : darkFontColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          _postModel.nsfw = !_postModel.nsfw;
                          BlocProvider.of<PostSubredditPreviewCubit>(context)
                              .uIChanged();
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.eighteen_up_rating_outlined),
                            const Text("NSFW")
                          ],
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: _postModel.spoiler
                                ? lightFontColor
                                : const Color(0xff181818),
                            foregroundColor: _postModel.spoiler
                                ? const Color(0xff181818)
                                : darkFontColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          _postModel.spoiler = !_postModel.spoiler;
                          BlocProvider.of<PostSubredditPreviewCubit>(context)
                              .uIChanged();
                        },
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.exclamationmark_octagon),
                            const Text("Spoiler")
                          ],
                        ))
                  ],
                ),
                if (_subredditModel.flairList!.isNotEmpty)
                  ListTile(
                    onTap: () async {
                      _postModel.flair = await Navigator.pushNamed(
                          context, postFlairScreenRoute,
                          arguments: _subredditModel.flairList) as String;
                    },
                    leading: Icon(CupertinoIcons.tag),
                    title: Text("Add flair"),
                    trailing: Icon(CupertinoIcons.arrow_right),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
