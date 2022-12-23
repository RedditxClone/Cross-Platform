import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quill_markdown/quill_markdown.dart';
import 'package:reddit/business_logic/cubit/new_post/create_post_cubit.dart';
import 'package:reddit/business_logic/cubit/new_post/post_flair_cubit.dart';
import 'package:reddit/business_logic/cubit/new_post/post_subreddit_preview_cubit.dart';
import 'package:reddit/data/model/post_model.dart';
import 'package:zefyrka/zefyrka.dart';

import '../../../business_logic/cubit/new_post/post_to_cubit.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_sizes.dart';
import '../../../constants/responsive.dart';
import '../../../constants/strings.dart';
import '../../../constants/theme_colors.dart';
import '../../../data/model/auth_model.dart';
import '../../../data/model/subreddit_model.dart';
import '../../widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import '../../widgets/nav_bars/app_bar_web_loggedin.dart';
import 'create_post_screen.dart';

class CreatePostScreenWeb extends StatefulWidget {
  const CreatePostScreenWeb({super.key});

  @override
  State<CreatePostScreenWeb> createState() => _CreatePostScreenWebState();
}

class _CreatePostScreenWebState extends State<CreatePostScreenWeb> {
  Set<SubredditModel>? _joinedSubreddits;
  bool _validURL = false;
  final FocusNode _focusNode = FocusNode();
  final _scrollController = ScrollController();
  late Responsive responsive;
  bool _enable = false;
  int _selectedTypeIndex = 2;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final ZefyrController _zefyrController = ZefyrController();
  PostModel _postModel = PostModel(
      subredditId: "63a21b66b304d3ab678c3f2d",
      title: "",
      text: "",
      nsfw: false,
      spoiler: false,
      flair: "",
      publishedDate: DateTime.now());

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreatePostCubit>(context).createBloc();
    BlocProvider.of<PostToCubit>(context).getUserJoinedSubreddits();
  }

  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocConsumer<CreatePostCubit, CreatePostState>(
          listener: (context, state) async {
        // if (state is NextButtonPressed) {
        //   _postModel.title = _titleController.text.toString();
        //   _postModel.text = _selectedTypeIndex == 2
        //       ? _bodyController.text.toString()
        //       : _urlController.text.toString();
        //   Navigator.pushNamed(context, postToMobileScreenRoute,
        //       arguments: _postModel);
        // }
      }, builder: (context, state) {
        return SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
          var width = constraints.maxWidth;
          return Row(
            children: [
              const Expanded(flex: 1, child: SizedBox(width: 1)),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Create a post",
                            style: GoogleFonts.ibmPlexSans(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: darkFontColor,
                      ),
                      Row(
                        children: [_subredditsMenu()],
                      ),
                      DefaultTabController(
                        length: 3,
                        animationDuration: Duration.zero,
                        child: Wrap(children: [
                          Container(
                            width: 700,
                            height: 500,
                            color: const Color(0xff1a1a1b),
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              appBar: TabBar(
                                indicator: const UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                    insets:
                                        EdgeInsets.symmetric(horizontal: 25)),
                                indicatorColor: Colors.white,
                                labelColor: Colors.white,
                                unselectedLabelColor: darkFontColor,
                                tabs: <Widget>[
                                  _postTab(0, Icons.article,
                                      Icons.article_outlined, 'Post'),
                                  _postTab(1, Icons.photo, Icons.photo_outlined,
                                      'Images & Video'),
                                  _postTab(2, Icons.link, Icons.link_outlined,
                                      'Link'),
                                ],
                              ),
                              body: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: TabBarView(
                                      children: <Widget>[
                                        _textBody(),
                                        _pickImageAndVedio(),
                                        _insertURL()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
        // return
        // Center(
        //     child: Column(
        //   children: [
        //     ZefyrToolbar.basic(controller: _zefyrController),
        //     Expanded(
        //       child: ZefyrEditor(
        //         controller: _zefyrController,
        //       ),
        //     ),
        //   ],
        // ))
        // ;
      }),
    );
  }

  _buildAppBar() {
    return AppBar(
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
        automaticallyImplyLeading: false,
        backgroundColor: defaultAppbarBackgroundColor,
        title: UserData.user != null
            ? const AppBarWebLoggedIn(screen: 'Create Post')
            : const AppBarWebNotLoggedIn(screen: 'Create Post'));
  }

  _pickImageAndVedio() {
    return Container();
  }

  _textBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          Card(
            color: Colors.transparent,
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(color: darkFontColor),
                  hintText: "Title"),
              onChanged: (value) {
                _postModel.title = _titleController.text;

                _enable = _titleController.text.isNotEmpty &&
                    _postModel.subredditId != '';
                BlocProvider.of<CreatePostCubit>(context).uIChanged();
              },
              style: GoogleFonts.ibmPlexSans(color: lightFontColor),
              controller: _titleController,
            ),
          ),
          _buildTextEditor(context),
          _preferences(),
          Divider(),
          _postButton()
        ],
      ),
    );
  }

  Widget _buildTextEditor(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: darkFontColor),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Wrap(
        children: [
          ZefyrToolbar.basic(controller: _zefyrController),
          Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ZefyrEditor(
              minHeight: 150,
              controller: _zefyrController,
              focusNode: _focusNode,
              // autofocus: true,
              // readOnly: true,
              // padding: EdgeInsets.only(left: 16, right: 16),
              scrollable: true,
              expands: false,
            ),
          ),
        ],
      ),
    );
  }

  _insertURL() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          Card(
            color: Colors.transparent,
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(color: darkFontColor),
                  hintText: "Title"),
              onChanged: (value) {
                _postModel.title = _titleController.text;
                _enable = _titleController.text.isNotEmpty &&
                    _validURL &&
                    _postModel.subredditId != '';
                BlocProvider.of<CreatePostCubit>(context).uIChanged();
              },
              style: GoogleFonts.ibmPlexSans(color: lightFontColor),
              controller: _titleController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.transparent,
              child: TextField(
                maxLines: null,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    fillColor: Colors.transparent,
                    hintStyle: TextStyle(color: darkFontColor),
                    hintText: "URL"),
                onChanged: (value) {
                  _validURL = Uri.parse(_urlController.text).host.isNotEmpty;
                  _enable = _titleController.text.isNotEmpty &&
                      _validURL &&
                      _postModel.subredditId != '';

                  if (_validURL) _postModel.text = _urlController.text;
                  BlocProvider.of<CreatePostCubit>(context).uIChanged();
                },
                style: GoogleFonts.ibmPlexSans(color: lightFontColor),
                controller: _urlController,
              ),
            ),
          ),
          _preferences(),
          Divider(),
          _postButton()
        ],
      ),
    );
  }

  Widget _postTab(int index, IconData iSelected, IconData iNotselected, text) {
    return Tab(
        child: Row(children: [
      Icon((_selectedTypeIndex == index) ? iSelected : iNotselected, size: 33),
      const SizedBox(
        width: 8,
      ),
      Text(text)
    ]));
  }

  Widget _postButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: backgroundColor,
                backgroundColor: lightFontColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
              ),
              onPressed: _enable
                  ? () {
                      _postModel.text = quillToMarkdown(
                              jsonEncode(_zefyrController.document)) ??
                          '';
                      debugPrint(_postModel.text);
                      debugPrint(_zefyrController.document.toString());
                      debugPrint(_zefyrController.document.toPlainText());
                      BlocProvider.of<PostSubredditPreviewCubit>(context)
                          .submitPost(_postModel);
                    }
                  : null,
              child: Text(
                "Post",
                style: GoogleFonts.ibmPlexSans(
                    color: Colors.black,
                    fontSize: subHeaderFontSize,
                    fontWeight: FontWeight.w400),
              ))
        ],
      ),
    );
  }

  DropdownMenuItem<String> dropDownMenuItem(
      String name, IconData icon, String id,
      {String imgUrl = ''}) {
    return DropdownMenuItem(
        value: id,
        key: Key(name),
        child: Row(children: [
          imgUrl == ''
              ? CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    imgUrl,
                  ))
              : CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    imgUrl,
                  )),
          const SizedBox(width: 8),
          MediaQuery.of(context).size.width < 930
              ? const SizedBox(width: 0)
              : Text(name, style: const TextStyle(fontSize: 15))
        ]));
  }

  List<DropdownMenuItem<String>> _createItems(
      BuildContext context, Set<SubredditModel> JoinedSubreddits) {
    final List<DropdownMenuItem<String>> itemsList = [];
    for (SubredditModel subreddit in JoinedSubreddits) {
      itemsList.add(dropDownMenuItem(
          subreddit.name!, Icons.reddit, subreddit.sId!,
          imgUrl: subreddit.icon ?? ''));
    }
    return itemsList;
  }

  Widget _subredditsMenu() {
    return BlocBuilder<PostToCubit, PostToState>(builder: ((context, state) {
      if (state is UserJoinedSubredditsUploading) {
        _joinedSubreddits = {};
      }
      if (state is UserJoinedSubredditsUploaded) {
        _joinedSubreddits = (state).userJoinedSubreddits;
      }
      return Container(
        decoration: BoxDecoration(
          color: defaultAppbarBackgroundColor,
        ),
        child: DropdownButton2(
            dropdownDecoration: const BoxDecoration(
              color: Color.fromRGBO(30, 30, 30, 1),
            ),
            key: const Key('dropdown'),
            alignment: Alignment.center,
            buttonHeight: 40,
            buttonWidth: 0.17 * MediaQuery.of(context).size.width,
            buttonPadding: const EdgeInsets.only(left: 10),
            underline: const SizedBox(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
            items: _createItems(context, _joinedSubreddits??{}),
            value: _postModel.subredditId,
            onChanged: (val) {
              _postModel.subredditId = val as String;
              BlocProvider.of<PostToCubit>(context).uIChanged();
            }),
      );
    }));
  }

  Widget _preferences() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          BlocBuilder<PostSubredditPreviewCubit, PostSubredditPreviewState>(
            builder: (context, state) {
              return Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: _postModel.nsfw
                              ? const Color(0xfff55b5e)
                              : Colors.transparent,
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
                          Icon(_postModel.nsfw ? Icons.check_sharp : Icons.add),
                          const Text("NSFW")
                        ],
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: _postModel.spoiler
                              ? Color(0xff050505)
                              : Colors.transparent,
                          foregroundColor:
                              _postModel.spoiler ? Colors.white : darkFontColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        _postModel.spoiler = !_postModel.spoiler;
                        BlocProvider.of<PostSubredditPreviewCubit>(context)
                            .uIChanged();
                      },
                      child: Row(
                        children: [
                          Icon(_postModel.spoiler
                              ? Icons.check_sharp
                              : Icons.add),
                          const Text("Spoiler")
                        ],
                      ))
                ],
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          BlocBuilder<PostFlairCubit, PostFlairState>(
            builder: (context, state) {
              return TextButton(
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
                    children: const [
                      Icon(CupertinoIcons.tag),
                      Text("Flair"),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ));
            },
          )
        ],
      ),
    );
  }
}
