import 'package:flutter/material.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/signin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class ProfilePageWeb extends StatefulWidget {
  const ProfilePageWeb({super.key});

  @override
  State<ProfilePageWeb> createState() => _ProfilePageWebState();
}

class _ProfilePageWebState extends State<ProfilePageWeb> {
  User user =
      User(userId: 'userId', name: 'name', email: 'email', imageUrl: null);
  late Responsive responsive;
  String outlineButtonLabel = 'Joined';
  String sortBy = 'new';
  Widget _sortBy() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                // TODO : sort by new
                setState(() {
                  sortBy = 'new';
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: sortBy == 'new'
                    ? const Color.fromARGB(255, 68, 68, 68)
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  sortBy == 'new'
                      ? const Icon(Icons.new_releases_sharp)
                      : const Icon(Icons.new_releases_outlined),
                  const SizedBox(width: 5),
                  const Text(
                    'New',
                    style: TextStyle(fontSize: 17),
                  )
                ],
              )),
          const SizedBox(width: 10),
          ElevatedButton(
              onPressed: () {
                // TODO : sort by hot
                setState(() {
                  sortBy = 'hot';
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: sortBy == 'hot'
                    ? const Color.fromARGB(255, 68, 68, 68)
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  sortBy == 'hot'
                      ? const Icon(Icons.local_fire_department)
                      : const Icon(Icons.local_fire_department_outlined),
                  const SizedBox(width: 5),
                  const Text(
                    'Hot',
                    style: TextStyle(fontSize: 17),
                  )
                ],
              )),
          const SizedBox(width: 10),
          ElevatedButton(
              onPressed: () {
                // TODO : sort by top
                setState(() {
                  sortBy = 'top';
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: sortBy == 'top'
                    ? const Color.fromARGB(255, 68, 68, 68)
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.trending_up_rounded),
                  SizedBox(width: 5),
                  Text(
                    'Top',
                    style: TextStyle(fontSize: 17),
                  )
                ],
              )),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildProflieCard() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(height: 100, color: Colors.blue),
                Container(height: 100, color: Colors.transparent),
              ],
            ),
            //---------------choose profile/cover picture and settings------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                    radius: 60,
                    child: Icon(
                      // TODO : display profile picture here
                      Icons.person,
                      size: 50,
                    )),
                const SizedBox(width: 60),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.black,
                        child: IconButton(
                            onPressed: () {}, // TODO : change cover photo here
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                              size: 19,
                            )),
                      ),
                    ),
                    IconButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(settingsTabsRoute),
                        icon: const Icon(Icons.settings)),
                  ],
                )
              ],
            ),
          ],
        ),
        const Text('Markos',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        const Text('u/mark_yasser . 1m',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        //------------change profile picture button----------
        Container(
          width: double.infinity,
          height: 65,
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: () {}, // TODO : change profile photo here
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
            ),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 139, 9, 0),
                    Color.fromARGB(255, 255, 136, 0)
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
              child: Container(
                constraints:
                    const BoxConstraints(minWidth: 70.0, minHeight: 20.0),
                alignment: Alignment.center,
                child: const Text(
                  'Change your profile picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ),
        //--------------------karma and cake day-------------
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Karma',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.blue,
                        size: 10,
                      ),
                      SizedBox(width: 5),
                      Text('1', // TODO : add karma number here
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  )
                ],
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width < 1420 &&
                          MediaQuery.of(context).size.width >= 1290
                      ? 80
                      : MediaQuery.of(context).size.width < 1030 &&
                              MediaQuery.of(context).size.width >= 1000
                          ? 80
                          : 100),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cake day',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Icon(
                        Icons.cake,
                        color: Colors.blue,
                        size: 10,
                      ),
                      SizedBox(width: 5),
                      Text('October 4, 2022', // TODO : add cake day here
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        //----------------add social links button------------
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 180,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {}, // TODO : add social links here
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 77, 77, 77),
                    backgroundColor: const Color.fromARGB(255, 116, 116, 116),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        " Add social links",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  )),
            ),
          ],
        ),
        //--------------------add new post--------------------
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {}, // TODO : navigate to add new post
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
            ),
            child: Ink(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
              child: Container(
                constraints:
                    const BoxConstraints(minWidth: 70.0, minHeight: 20.0),
                alignment: Alignment.center,
                child: const Text(
                  'New Post',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondProflieCard() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            child: Text(
              'You\'re a moderator of these communiteise',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //----------------------my moderator communities----------------------------
              Row(
                children: [
                  const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 15,
                      )),
                  const SizedBox(width: 10),
                  Column(
                    children: const [
                      Text('r/redditsx_'),
                      SizedBox(height: 5),
                      Text('4 members'),
                    ],
                  )
                ],
              ),
              OutlinedButton(
                  onHover: ((value) {
                    setState(() {
                      outlineButtonLabel = value ? 'Leave' : 'Joined';
                    });
                  }),
                  onPressed: () {}, // TODO : on press => leave subreddit
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: Text(
                    outlineButtonLabel,
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOverview() {
    return Container(
      color: defaultWebBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: responsive.isSmallSizedScreen() ||
                              responsive.isMediumSizedScreen()
                          ? 0
                          : responsive.isLargeSizedScreen()
                              ? 1
                              : 2,
                      child: const SizedBox(width: 0)),
                  Expanded(
                    flex: responsive.isLargeSizedScreen()
                        ? 7
                        : responsive.isXLargeSizedScreen()
                            ? 5
                            : 7,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: 10,
                      child: Column(
                        children: [
                          Container(
                            // sort posts
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: defaultSecondaryColor),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: _sortBy(),
                          ),
                          const PostsWeb(),
                          const PostsWeb(),
                          const PostsWeb(),
                          const PostsWeb(),
                        ],
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width < 900
                      ? const SizedBox(width: 0)
                      : Expanded(
                          flex: responsive.isLargeSizedScreen() ||
                                  responsive.isMediumSizedScreen()
                              ? 3
                              : 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: defaultSecondaryColor),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: _buildProflieCard(),
                                ),
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: defaultSecondaryColor),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: _buildSecondProflieCard(),
                                ),
                              ],
                            ),
                          )),
                  Expanded(
                      flex: responsive.isSmallSizedScreen() ||
                              responsive.isMediumSizedScreen()
                          ? 0
                          : responsive.isLargeSizedScreen()
                              ? 1
                              : 2,
                      child: SizedBox(
                          width: responsive.isMediumSizedScreen() ? 15 : 0))
                ],
              ),
            ),
          )
        ],
      ),
      //),
    );
  }

  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          automaticallyImplyLeading: false,
          backgroundColor: defaultAppbarBackgroundColor,
          title: AppBarWebLoggedIn(user: user, screen: 'u/user_name')),
      body: DefaultTabController(
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: defaultAppbarBackgroundColor,
            shape: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5)),
            bottom: TabBar(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2 > 300
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.1 > 10 &&
                              MediaQuery.of(context).size.width * 0.2 <= 300
                          ? MediaQuery.of(context).size.width * 0.05
                          : 5),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    icon: Text('OVERVIEW',
                        style: TextStyle(
                            fontSize:
                                responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('POSTS',
                        style: TextStyle(
                            fontSize:
                                responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('COMMENTS',
                        style: TextStyle(
                            fontSize:
                                responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('HISTORY',
                        style: TextStyle(
                            fontSize:
                                responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('SAVED',
                        style: TextStyle(
                            fontSize:
                                responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('HIDDEN',
                        style: TextStyle(
                            fontSize:
                                responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('UPVOTED',
                        style: TextStyle(
                            fontSize:
                                responsive.isSmallSizedScreen() ? 8 : 13))),
                Tab(
                    icon: Text('DOWNVOTED',
                        style: TextStyle(
                            fontSize:
                                responsive.isSmallSizedScreen() ? 8 : 13))),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildOverview(),
              const Icon(Icons.directions_transit),
              const Icon(Icons.directions_bike),
              const Icon(Icons.directions_car),
              const Icon(Icons.directions_transit),
              const Icon(Icons.directions_bike),
              const Icon(Icons.directions_car),
              const Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
