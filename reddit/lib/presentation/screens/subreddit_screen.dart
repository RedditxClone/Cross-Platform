import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/business_logic/cubit/end_drawer/end_drawer_cubit.dart';
import 'package:reddit/business_logic/cubit/posts/posts_subreddit_cubit.dart';
import 'package:reddit/business_logic/cubit/subreddit_page_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/subreddit_model.dart';
import 'package:reddit/data/repository/end_drawer/end_drawer_repository.dart';
import 'package:reddit/data/web_services/settings_web_services.dart';
import 'package:reddit/presentation/widgets/home_widgets/end_drawer.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import '../../business_logic/cubit/cubit/auth/cubit/auth_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/font_sizes.dart';
import '../widgets/posts/posts_web.dart';

class SubredditPageScreen extends StatefulWidget {
  final String subredditId;
  final SubredditModel? subredditModel;
  bool _newSubreddit = false;
  SubredditPageScreen(
      {super.key, required this.subredditId, this.subredditModel}) {
    _newSubreddit = subredditModel != null;
  }
  @override
  State<SubredditPageScreen> createState() => _SubredditPageScreenState();
}

class _SubredditPageScreenState extends State<SubredditPageScreen> {
  String joinLeaveButtonText = "";
  final ImagePicker _picker = ImagePicker();
  SubredditModel? _subredditModel;
  String _selectedMode = "hot";
  IconData _selectedModeIcon = Icons.fireplace;
  Uint8List? _pickedImage;
  final TextEditingController _controller = TextEditingController();
  bool? _isMod;
  bool _updatingIcon = false;
  bool? _joinedSubreddit;
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

  final bool _mobilePlatform =
      defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS;
  late int _upperBarHeight;
  @override
  void initState() {
    _upperBarHeight = _mobilePlatform ? 100 : 200;

    super.initState();
    if (widget._newSubreddit) {
      _subredditModel = widget.subredditModel!;
      if (kIsWeb) {
        _subredditModel!.memberCount = 1;
      }
      _joinedSubreddit = true;
      _isMod = true;
      return;
    }
    BlocProvider.of<SubredditPageCubit>(context)
        .getSubredditInfo(widget.subredditId);
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

  Widget _buildAbout(
      SubredditModel subredditModel, bool? isMod, bool? joinedSubreddit) {
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
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (String text in subredditModel.moderators!)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    text,
                                    style: const TextStyle(
                                        color: lightFontColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                  onTap: () => Navigator.pushNamed(
                                      context, otherProfilePageRoute,
                                      arguments: text),
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
                        SizedBox(
                          height: 2,
                        ),
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
                            if (isMod!)
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () => Navigator.pushNamed(
                                              context, modqueueRoute,
                                              arguments: {
                                                'name': subredditModel.name,
                                                'id': subredditModel.sId
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
                                ],
                              )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (subredditModel.description != null &&
                            subredditModel.description!.isNotEmpty)
                          TextField(
                            maxLines: null,
                            readOnly: isMod ? false : true,
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
                              "Created ${subredditModel.createdDate!.month} / ${subredditModel.createdDate!.day} / ${subredditModel.createdDate!.year}",
                              style: const TextStyle(color: darkFontColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _communityType(subredditModel.type!),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          subredditModel.memberCount.toString(),
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
                              onPressed: () => Navigator.pushNamed(
                                  context, createPostScreenRoute),
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
                        for (String text in subredditModel.moderators!)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  child: Text(
                                    text,
                                    style: const TextStyle(
                                      color: Color(0xff4db6f7),
                                    ),
                                  ),
                                  onTap: () => UserData.user != null &&
                                          text == UserData.user!.username
                                      ? Navigator.pushNamed(
                                          context, profilePageRoute)
                                      : Navigator.pushNamed(
                                          context, otherProfilePageRoute,
                                          arguments: text),
                                ),
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

  Widget _createButtons(String title, IconData icon, String mode) {
    return BlocBuilder<PostsSubredditCubit, PostsSubredditState>(
        builder: (context, state) {
      return TextButton.icon(
        label: Text(title),
        style: IconButton.styleFrom(
          foregroundColor:
              _selectedMode == mode ? lightFontColor : darkFontColor,
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
          BlocProvider.of<PostsSubredditCubit>(context)
              .getSubredditPosts(_subredditModel!.name!, sort: _selectedMode);
        },
        icon: Icon(icon),
      );
    });
  }

  Widget _myposts() {
    return BlocBuilder<PostsSubredditCubit, PostsSubredditState>(
      builder: (context, state) {
        if (state is SubredditPostsLoaded) {
          if (state.posts!.isNotEmpty) {
            return Column(children: [
              ...state.posts!.map((e) => PostsWeb(postsModel: e)).toList()
            ]);
          }
          return Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "assets/images/comments.jpg",
                  scale: 3,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Create a post",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  Expanded(flex: 3, child: Container()),
                  const Expanded(
                    flex: 20,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "No posts are available yet. Create a post now!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ]),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildBody(subredditModel, joinedSubreddit, isMod) {
    joinLeaveButtonText = joinedSubreddit ? "Joined" : "Join";
    _controller.text = subredditModel.description ?? "";
    return _mobilePlatform
        ? DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: lightFontColor,
                      ),
                      onPressed: (() => Navigator.pop(context)),
                    ),
                    expandedHeight: 250,
                    stretch: true,
                    automaticallyImplyLeading: false,
                    actions: [
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is Login ||
                              state is GetTheUserData ||
                              state is SignedIn ||
                              state is SignedInWithProfilePhoto) {
                            return IconButton(
                              key: const Key('user-icon'),
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              icon: UserData.profileSettings!.profile.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                      UserData.user!.profilePic!,
                                    )),
                            );
                          } else {
                            return IconButton(
                                key: const Key('user-icon'),
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                                icon: const CircleAvatar(
                                    child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 25,
                                )));
                          }
                        },
                      )
                    ],
                    // backgroundColor: Colors.grey,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.blueAccent, Colors.black])),
                      child: Stack(fit: StackFit.expand, children: <Widget>[
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
                                                  "r/${subredditModel.name}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: lightFontColor),
                                                ),
                                                Text(
                                                    "${subredditModel.memberCount} members",
                                                    style: const TextStyle(
                                                      color: darkFontColor,
                                                    )),
                                              ],
                                            ),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      joinedSubreddit || isMod
                                                          ? lightFontColor
                                                          : backgroundColor,
                                                  backgroundColor:
                                                      joinedSubreddit || isMod
                                                          ? Colors.transparent
                                                          : lightFontColor,
                                                  side: isMod
                                                      ? BorderSide.none
                                                      : const BorderSide(
                                                          color: lightFontColor,
                                                          width: 1),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                    Radius.circular(20),
                                                  )),
                                                ),
                                                onPressed: () => isMod
                                                    ? Navigator.pushNamed(
                                                        context, modlistRoute,
                                                        arguments: {
                                                            'name':
                                                                subredditModel
                                                                    .name,
                                                            'id': subredditModel
                                                                .sId
                                                          })
                                                    : joinedSubreddit
                                                        ? BlocProvider.of<
                                                                    SubredditPageCubit>(
                                                                context)
                                                            .leaveSubreddit(
                                                                subredditModel!
                                                                    .sId!)
                                                        : BlocProvider.of<
                                                                    SubredditPageCubit>(
                                                                context)
                                                            .joinSubreddit(
                                                                subredditModel!
                                                                    .sId),
                                                child: Row(
                                                  children: [
                                                    if (isMod)
                                                      const Icon(
                                                        Icons.build,
                                                        size: 15,
                                                      ),
                                                    if (isMod)
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                    Text(isMod
                                                        ? "Mod Tools"
                                                        : joinLeaveButtonText),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        // Container(
                                        // height: 200 - 2.7 * kToolbarHeight,
                                        // padding: const EdgeInsets.symmetric(
                                        // horizontal: 8, vertical: 4),
                                        // child: SingleChildScrollView(
                                        // child: Text(
                                        // _subredditModel.description,
                                        // style: const TextStyle(
                                        // color: lightFontColor,
                                        // fontSize: 10),
                                        // ),
                                        // ),
                                        // )
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
                          Row(children: [
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                foregroundImage: subredditModel.icon != null
                                    ? NetworkImage(
                                        subredditModel.icon!,
                                      )
                                    : null,
                                child: subredditModel.icon == null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 16,
                                        child: Text(
                                          "r/",
                                          style: GoogleFonts.ibmPlexSans(
                                              color: Colors.blue,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      )
                                    : null),
                          ])
                        ])
                      ]),
                    )),
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
                    child: Column(
                      children: [
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
                        // _buildPosts()
                        _myposts()
                      ],
                    ),
                  ),
                  _buildAbout(subredditModel, isMod, joinedSubreddit)
                ],
              ),
            ),
          )
        : (subredditModel.name == null)
            ? Center(
                child: Text("an error occurred, please try again"),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        TextButton.icon(
                                          label: Text(''),
                                          icon: CircleAvatar(
                                              radius: 45,
                                              backgroundColor: Colors.white,
                                              foregroundImage:
                                                  subredditModel.icon != null
                                                      ? NetworkImage(
                                                          subredditModel.icon!,
                                                        )
                                                      : null,
                                              child: _updatingIcon
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              color:
                                                                  Colors.blue),
                                                    )
                                                  : subredditModel.icon == null
                                                      ? CircleAvatar(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          radius: 40,
                                                          child: Text(
                                                            "r/",
                                                            style: GoogleFonts
                                                                .ibmPlexSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        40,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                          ),
                                                        )
                                                      : null),
                                          onPressed: isMod
                                              ? () {
                                                  pickImageWeb(
                                                      ImageSource.gallery);
                                                }
                                              : () {},
                                          style: TextButton.styleFrom(
                                            shape: const CircleBorder(),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        if (isMod)
                                          InkWell(
                                            onTap: () {
                                              pickImageWeb(ImageSource.gallery);
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                "Update icon",
                                                style: TextStyle(
                                                    color: lightFontColor),
                                              ),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        subredditModel.name!,
                                                        style: const TextStyle(
                                                            color:
                                                                lightFontColor,
                                                            fontSize: 30),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 120,
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        "r/${subredditModel.name}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            color:
                                                                darkFontColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: OutlinedButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        joinedSubreddit
                                                            ? lightFontColor
                                                            : backgroundColor,
                                                    backgroundColor:
                                                        joinedSubreddit
                                                            ? Colors.transparent
                                                            : lightFontColor,
                                                    side: const BorderSide(
                                                        color: lightFontColor,
                                                        width: 1),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                      Radius.circular(20),
                                                    )),
                                                  ),
                                                  onPressed: () {
                                                    joinedSubreddit
                                                        ? BlocProvider.of<
                                                                    SubredditPageCubit>(
                                                                context)
                                                            .leaveSubreddit(
                                                                subredditModel!
                                                                    .sId!)
                                                        : BlocProvider.of<
                                                                    SubredditPageCubit>(
                                                                context)
                                                            .joinSubreddit(
                                                                subredditModel!
                                                                    .sId);
                                                  },
                                                  child:
                                                      Text(joinLeaveButtonText),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      foregroundColor:
                                                          lightFontColor,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      side: const BorderSide(
                                                          color: Colors.white,
                                                          width: 1),
                                                      elevation: 0,
                                                      shape:
                                                          const CircleBorder(),
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
                                      child:
                                          // (state is PostsInPageLoading)
                                          // ? const Center(
                                          // child: CircularProgressIndicator(
                                          // color: darkFontColor),
                                          // )
                                          // :
                                          Column(
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
                                                          BorderRadius.circular(
                                                              3)),
                                                  child: const TextField(
                                                    decoration: InputDecoration(
                                                        fillColor:
                                                            textFeildColor,
                                                        icon: Icon(Icons.reddit,
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
                                                      BorderRadius.circular(3)),
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
                                                    Icons.new_releases_outlined,
                                                    'new'),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                _createButtons(
                                                    'Top',
                                                    Icons.file_upload_outlined,
                                                    'top'),
                                              ]),
                                            ),
                                            const SizedBox(height: 10),
                                            _myposts()
                                          ])),
                                  width > 700
                                      ? Expanded(
                                          flex: 1,
                                          child: _buildAbout(subredditModel,
                                              isMod, joinedSubreddit))
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
        if (state is SubredditIconUpdated) {
          _displayMsg(
              context, Colors.blue, "Sucessfully updated community icon!");
        }
        if (state is SubredditIconUpdateFailed) {
          _displayMsg(context, Colors.red, "Failed to updated community icon!");
        }
        if (state is SubredditPageLoaded) {
          _subredditModel = state.subredditModel;
          _joinedSubreddit = state.isJoined;
          _isMod = state.isMod;
          BlocProvider.of<PostsSubredditCubit>(context)
              .getSubredditPosts(_subredditModel!.name!);
          return _buildBody(_subredditModel, _joinedSubreddit, _isMod);
        } else if (state is SubredditPageLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: darkFontColor,
            ),
          );
        }
        if (state is SubredditIconUpdating) {
          _updatingIcon = true;
        }
        if (state is SubredditIconUpdated) {
          _updatingIcon = false;
        }
        if (state is InSubreddit) {
          _joinedSubreddit = true;
        }
        if (state is OutSubreddit) {
          _joinedSubreddit = false;
        }
        if (state is Moderator) {
          _isMod = true;
        }
        if (state is NotModerator) {
          _isMod = false;
        }
        if (state is LeftSubreddit) {
          _joinedSubreddit = false;
          joinLeaveButtonText = "Join";
          if (kIsWeb) {
            _subredditModel!.memberCount = _subredditModel!.memberCount! - 1;
          }
        }
        if (state is JoinedSubreddit) {
          joinLeaveButtonText = "Joined";
          _joinedSubreddit = true;
          if (kIsWeb) {
            _subredditModel!.memberCount = _subredditModel!.memberCount! + 1;
          }
        }
        if (_subredditModel != null &&
            _isMod != null &&
            _joinedSubreddit != null) {
          return _buildBody(_subredditModel, _joinedSubreddit, _isMod);
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: darkFontColor,
            ),
          );
        }
        // return Container();
      }, listener: (context, state) {
        if (state is SubredditIconUpdated) {
          _subredditModel!.icon = (state).subredditIcon;
        }
      }),
      endDrawer: kIsWeb
          ? null
          : BlocProvider(
              create: (context) =>
                  EndDrawerCubit(EndDrawerRepository(SettingsWebServices())),
              child: EndDrawer(
                2,
                35,
              )),
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
                    BlocProvider.of<PostsSubredditCubit>(context)
                        .getSubredditPosts(_subredditModel!.name!, sort: "hot");
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
                    BlocProvider.of<PostsSubredditCubit>(context)
                        .getSubredditPosts(_subredditModel!.name!, sort: "hot");
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
                    BlocProvider.of<PostsSubredditCubit>(context)
                        .getSubredditPosts(_subredditModel!.name!, sort: "top");
                    Navigator.of(context).pop();
                  }),
                ),
              ],
            )));
  }

  Widget _communityType(String type) {
    IconData icon = type.toLowerCase() == 'public'
        ? Icons.person
        : type.toLowerCase() == 'restricted'
            ? Icons.remove_red_eye_outlined
            : Icons.lock_rounded;
    String text = type.replaceFirst(type[0], type[0].toUpperCase());
    return Row(
      children: [
        Icon(
          icon,
          color: lightFontColor,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: const TextStyle(color: lightFontColor),
        )
      ],
    );
  }

  Future pickImageWeb(ImageSource src) async {
    try {
      final imagePicker = await ImagePicker().pickImage(source: src);
      if (imagePicker == null) return;
      Uint8List imageBytes = await imagePicker.readAsBytes();
      setState(() {
        BlocProvider.of<SubredditPageCubit>(context)
            .updateSubredditIcon(_subredditModel!.sId!, imageBytes);
        // _displayMsg(context, Colors.blue, 'Changes Saved');
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      _displayMsg(context, Colors.red, 'Could not load image');
    }
  }
}
