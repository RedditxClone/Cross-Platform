import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/subreddit_page_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/subreddit_model.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import '../../constants/colors.dart';
import '../../constants/font_sizes.dart';

class SubredditPageScreen extends StatefulWidget {
  const SubredditPageScreen({super.key, required this.subredditId});
  final String subredditId;
  @override
  State<SubredditPageScreen> createState() => _SubredditPageScreenState();
}

class _SubredditPageScreenState extends State<SubredditPageScreen> {
  var joinLeaveButtonText = "";
  final ImagePicker _picker = ImagePicker();
  late SubredditModel _subredditModel;
  String _selectedMode = "hot";
  IconData _selectedModeIcon = Icons.fireplace;
  Uint8List? _pickedImage;
  final TextEditingController _controller = TextEditingController();
  void _displayMsg(BuildContext context, Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 400,
      content: Container(
          height: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: const Color.fromARGB(255, 33, 32, 32),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
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
    ));
  }

  _fetchImage() async {
    // Pick an image
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      _pickedImage = await image.readAsBytes();
      BlocProvider.of<SubredditPageCubit>(context)
          .updateSubredditIcon(_subredditModel.subredditId, _pickedImage);
    } catch (e) {
      print(e);
    }
  }

  final bool _mobilePlatform =
      defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS;
  late int _upperBarHeight;
  _SubredditPageScreenState();
  @override
  void initState() {
    _upperBarHeight = _mobilePlatform ? 100 : 200;

    super.initState();
    BlocProvider.of<SubredditPageCubit>(context)
        .getSubredditInfo(widget.subredditId);
    // BlocProvider.of<SubredditPageCubit>(context)
    //     .getSubredditDescription(subreddit);
    // BlocProvider.of<SubredditPageCubit>(context)
    //     .getSubredditModerators(subreddit);
    // BlocProvider.of<SubredditPageCubit>(context).getSubredditIcon(subreddit);
    // BlocProvider.of<SubredditPageCubit>(context)
    //     .getPostsInPage(subreddit, "hot");
  }

  PreferredSizeWidget? _buildAppBar() {
    return _mobilePlatform
        ? null
        : AppBar(
            shape: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.3)),
            automaticallyImplyLeading: false,
            backgroundColor: defaultAppbarBackgroundColor,
            title: UserData.user != null
                ? const AppBarWebLoggedIn(screen: 'r/subreddit')
                : const AppBarWebNotLoggedIn(screen: 'r/subreddit'));
  }

  Widget _buildAbout(SubredditPageState state) {
    return _mobilePlatform
        ? SingleChildScrollView(
            child: Container(
              color: mobileCardsColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Moderators",
                        style: TextStyle(
                            color: lightFontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                    color: textFeildColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state is SubredditModeratorsLoading
                      ? const Center(
                          child:
                              CircularProgressIndicator(color: darkFontColor),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (String text in _subredditModel.moderators)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.left,
                                        text,
                                        style: const TextStyle(
                                            color: lightFontColor),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )
                              ]),
                        )
                ]),
              ),
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                    child: Card(
                  color: cardsColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "About Community",
                              style: TextStyle(
                                  color: darkFontColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () => Navigator.pushNamed(
                                            context, modqueueRoute, arguments: {
                                          'name': _subredditModel.subredditId,
                                          'id': _subredditModel.subredditId
                                        }),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(children: const [
                                        Icon(
                                          Icons.shield_outlined,
                                          color: darkFontColor,
                                        ),
                                        Text(
                                          "Mod tools",
                                          style: TextStyle(
                                              color: darkFontColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ]),
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: darkFontColor,
                                    ))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          maxLines: null,
                          readOnly: _subredditModel.isMod ? false : true,
                          controller: _controller,
                          decoration: const InputDecoration(
                              focusColor: Colors.transparent,
                              fillColor: Colors.transparent),
                          style: const TextStyle(color: lightFontColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.cake,
                              color: lightFontColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Created ${_subredditModel.creationDate.month} / ${_subredditModel.creationDate.day} / ${_subredditModel.creationDate.year}",
                              style: const TextStyle(color: darkFontColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _subredditModel.membersCount.toString(),
                          style: const TextStyle(color: lightFontColor),
                        ),
                        const Text(
                          "Members",
                          style: TextStyle(color: lightFontColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: backgroundColor,
                                backgroundColor: lightFontColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                              ),
                              onPressed: () {},
                              child: const Text("Create Post")),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                    child: Card(
                  color: cardsColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Moderators",
                              style: TextStyle(
                                  color: darkFontColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (String text in _subredditModel.moderators)
                          Column(
                            children: [
                              Text(
                                text,
                                style: const TextStyle(color: lightFontColor),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )),
              )
            ],
          );
  }

  Widget _buildPosts() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, position) {
        return SizedBox(
          height: 200,
          width: double.infinity,
          child: Card(
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: darkCardsColor,
                          )),
                      const VerticalDivider(
                        thickness: 0,
                      ),
                      Container(
                        color: cardsColor,
                        child: const Center(
                          child: Text(
                            "Demo post, hope you are well!!",
                            style: TextStyle(
                                color: lightFontColor, fontSize: 22.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _createButtons(String title, IconData icon, String mode) {
    return TextButton.icon(
      label: Text(title),
      style: IconButton.styleFrom(
        foregroundColor: _selectedMode == mode ? lightFontColor : darkFontColor,
        backgroundColor:
            _selectedMode == mode ? textFeildColor : Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(20),
        )),
      ),
      onPressed: () {
        _selectedMode = mode;
        _selectedModeIcon = icon;
        BlocProvider.of<SubredditPageCubit>(context)
            .getPostsInPage(_subredditModel.subredditId, mode);
      },
      icon: Icon(icon),
    );
  }

  Widget _buildBody(SubredditPageState state) {
    return _mobilePlatform
        ? DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 250,
                    stretch: true,
                    automaticallyImplyLeading: false,
                    actions: [
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: lightFontColor,
                          ),
                          onPressed: (() => Navigator.pop(context)),
                        ),
                      ),
                      const Expanded(
                          flex: 6, child: SizedBox(child: TextField())),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.list))),
                      const Expanded(flex: 2, child: Icon(Icons.reddit)),
                    ],
                    backgroundColor: mobileCardsColor,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                        background:
                            Stack(fit: StackFit.expand, children: <Widget>[
                      Image.asset(
                        'assets/images/cover.jpg',
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: kToolbarHeight * 3,
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Card(
                                color: mobileCardsColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "r/${_subredditModel.subredditId}",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: lightFontColor),
                                              ),
                                              Text(
                                                  "${_subredditModel.membersCount} members",
                                                  style: const TextStyle(
                                                    color: darkFontColor,
                                                  )),
                                            ],
                                          ),
                                          if (_subredditModel.isMod)
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  foregroundColor:
                                                      lightFontColor,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                    Radius.circular(20),
                                                  )),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pushNamed(
                                                        context, modlistRoute),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.settings),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text("Mod Tools"),
                                                  ],
                                                )),
                                        ],
                                      ),
                                      Container(
                                        height: 200 - 2.7 * kToolbarHeight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            _subredditModel.description,
                                            style: const TextStyle(
                                                color: lightFontColor,
                                                fontSize: 10),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(children: [
                        const SizedBox(
                          height: kToolbarHeight * 2.1,
                        ),
                        Row(children: const [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/ironman.jpg',
                            ),
                          ),
                        ])
                      ])
                    ])),
                    pinned: true,
                    floating: true,
                    bottom: const TabBar(
                      indicatorColor: Colors.blue,
                      unselectedLabelColor: darkFontColor,
                      labelColor: lightFontColor,
                      isScrollable: true,
                      tabs: [
                        Tab(child: Text('Posts')),
                        Tab(child: Text('About')),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  SingleChildScrollView(
                      child: Column(children: [
                    SizedBox(
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: darkFontColor,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () => _showBottomSheet(context),
                        child: Row(
                          children: [
                            Icon(_selectedModeIcon),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(_selectedMode),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: darkFontColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    _buildPosts()
                  ])),
                  _buildAbout(state)
                ],
              ),
            ),
          )
        : SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              var width = constraints.maxWidth;
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: _upperBarHeight / 2,
                        color: Colors.blue,
                      ),
                      Container(
                        width: double.infinity,
                        height: _upperBarHeight / 2,
                        color: cardsColor,
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width > 900 ? (width - 870) / 2 : 30),
                      child: Column(children: [
                        SizedBox(
                          height: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      label: const Text(''),
                                      icon: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                            _subredditModel.icon,
                                          ),
                                          child: state is SubredditIconUpdating
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.blue),
                                                )
                                              : null),
                                      onPressed: _subredditModel.isMod
                                          ? () {
                                              _fetchImage();
                                            }
                                          : () {},
                                      style: TextButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    if (_subredditModel.isMod)
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          "Update icon",
                                          style:
                                              TextStyle(color: lightFontColor),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    _subredditModel.subredditId,
                                                    style: const TextStyle(
                                                        color: lightFontColor,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 120,
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  child: Text(
                                                    "r/${_subredditModel.subredditId}",
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        color: darkFontColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: OutlinedButton(
                                              onHover: (value) {
                                                joinLeaveButtonText =
                                                    _subredditModel.joined
                                                        ? "Leave"
                                                        : "Join";
                                                setState(() {});
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    _subredditModel.joined
                                                        ? lightFontColor
                                                        : backgroundColor,
                                                backgroundColor:
                                                    _subredditModel.joined
                                                        ? Colors.transparent
                                                        : lightFontColor,
                                                side: const BorderSide(
                                                    color: lightFontColor,
                                                    width: 1),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                  Radius.circular(20),
                                                )),
                                              ),
                                              onPressed: () {
                                                _subredditModel.joined
                                                    ? BlocProvider.of<
                                                                SubredditPageCubit>(
                                                            context)
                                                        .leavePressed()
                                                    : BlocProvider.of<
                                                                SubredditPageCubit>(
                                                            context)
                                                        .joinPressed();
                                              },
                                              child: Text(joinLeaveButtonText),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor:
                                                      lightFontColor,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  side: const BorderSide(
                                                      color: Colors.white,
                                                      width: 1),
                                                  elevation: 0,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {},
                                                child: const Icon(
                                                  Icons.notifications,
                                                  color: lightFontColor,
                                                )),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: (state is PostsInPageLoading)
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                              color: darkFontColor),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2, bottom: 10.0),
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    decoration: BoxDecoration(
                                                        color: cardsColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                    child: const TextField(
                                                      decoration: InputDecoration(
                                                          fillColor:
                                                              textFeildColor,
                                                          icon: Icon(
                                                              Icons.reddit,
                                                              color:
                                                                  darkFontColor),
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  darkFontColor),
                                                          hintText:
                                                              "Create post"),
                                                    )),
                                              ),
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: cardsColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                child: Row(children: [
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  _createButtons(
                                                      'Hot',
                                                      Icons.fireplace_rounded,
                                                      'hot'),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  _createButtons(
                                                      'New',
                                                      Icons
                                                          .new_releases_outlined,
                                                      'new'),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  _createButtons(
                                                      'Top',
                                                      Icons
                                                          .file_upload_outlined,
                                                      'top'),
                                                ]),
                                              ),
                                              _buildPosts()
                                            ])),
                              width > 700
                                  ? Expanded(flex: 1, child: _buildAbout(state))
                                  : Container()
                            ],
                          ),
                        )
                      ]))
                ],
              );
            }),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _mobilePlatform ? mobileBackgroundColor : backgroundColor,
      extendBodyBehindAppBar: _mobilePlatform ? true : false,
      appBar: _buildAppBar(),
      body: BlocConsumer<SubredditPageCubit, SubredditPageState>(
          builder: (context, state) {
        if (state is SubredditPageLoaded) {
          _subredditModel = (state).subredditModel;
          _controller.text = _subredditModel.description;
          joinLeaveButtonText = _subredditModel.joined ? "Joined" : "Join";
        } else if (state is SubredditPageLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: darkFontColor,
            ),
          );
        }
        if (state is LeftSubreddit) {
          _subredditModel.joined = false;
          joinLeaveButtonText = "Join";
        }
        if (state is JoinedSubreddit) {
          joinLeaveButtonText = "Joined";
          _subredditModel.joined = true;
        }
        if (state is SubredditDescriptionLoaded) {
          _subredditModel.description = (state).subredditDescription;
        }
        if (state is SubredditModeratorsLoaded) {
          _subredditModel.moderators = (state).subredditModerators;
        }

        return _buildBody(state);
      }, listener: (context, state) {
        if (state is SubredditIconLoaded) {
          _subredditModel.icon = (state).subredditIcon;
          _displayMsg(
              context, Colors.blue, "Sucessfully updated community icon!");
        }
        if (state is SubredditIconUpdateFailed) {
          _displayMsg(context, Colors.red, "Failed to updated community icon!");
        }
      }),
    );
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: mobileTextFeildColor,
        enableDrag: true,
        context: context,
        builder: (_) => Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                const Text(
                  "SORT POSTS BY",
                  style: TextStyle(color: lightFontColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  trailing: (_selectedMode == "hot")
                      ? const Icon(
                          Icons.check_sharp,
                          color: Colors.blue,
                        )
                      : null,
                  leading: Icon(Icons.fireplace_rounded,
                      color: (_selectedMode == "hot")
                          ? lightFontColor
                          : darkFontColor),
                  title: Text(
                    "Hot",
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: subHeaderFontSize,
                        fontWeight: FontWeight.w500,
                        color: _selectedMode == "hot"
                            ? lightFontColor
                            : darkFontColor),
                  ),
                  onTap: (() {
                    _selectedMode = "hot";
                    _selectedModeIcon = Icons.fireplace_rounded;
                    BlocProvider.of<SubredditPageCubit>(context).getPostsInPage(
                        _subredditModel.subredditId, _selectedMode);
                    Navigator.of(context).pop();
                  }),
                ),
                ListTile(
                  trailing: (_selectedMode == "new")
                      ? const Icon(
                          Icons.check_sharp,
                          color: Colors.blue,
                        )
                      : null,
                  leading: Icon(Icons.new_releases_outlined,
                      color: (_selectedMode == "new")
                          ? lightFontColor
                          : darkFontColor),
                  title: Text(
                    "New",
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: subHeaderFontSize,
                        fontWeight: FontWeight.w500,
                        color: _selectedMode == "new"
                            ? lightFontColor
                            : darkFontColor),
                  ),
                  onTap: (() {
                    _selectedMode = "new";
                    _selectedModeIcon = Icons.fireplace_rounded;
                    BlocProvider.of<SubredditPageCubit>(context).getPostsInPage(
                        _subredditModel.subredditId, _selectedMode);
                    Navigator.of(context).pop();
                  }),
                ),
                ListTile(
                  trailing: (_selectedMode == "top")
                      ? const Icon(
                          Icons.check_sharp,
                          color: Colors.blue,
                        )
                      : null,
                  leading: Icon(Icons.fireplace_rounded,
                      color: (_selectedMode == "top")
                          ? lightFontColor
                          : darkFontColor),
                  title: Text(
                    "Top",
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: subHeaderFontSize,
                        fontWeight: FontWeight.w500,
                        color: _selectedMode == "top"
                            ? lightFontColor
                            : darkFontColor),
                  ),
                  onTap: (() {
                    _selectedMode = "top";
                    _selectedModeIcon = Icons.file_upload_outlined;
                    BlocProvider.of<SubredditPageCubit>(context).getPostsInPage(
                        _subredditModel.subredditId, _selectedMode);
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            )));
  }
}
