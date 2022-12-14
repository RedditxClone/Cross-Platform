import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/posts/posts_my_profile_cubit.dart';
import 'package:reddit/business_logic/cubit/settings/settings_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/posts/posts.dart';

import '../../widgets/posts/posts_web.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostsMyProfileCubit>(context).getMyProfilePosts();
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.no_sim_outlined,
          size: 70,
        ),
        SizedBox(height: 10),
        Text(
          'Wow, such empty',
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }

  Widget _appBarContent() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomLeft,
      children: [
        // cover photo
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.redAccent, Colors.black]))),
        // add social links
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      radius: 50,
                      child: UserData.user!.profilePic == ''
                          ? const Icon(
                              Icons.person,
                              size: 50,
                            )
                          : Image.network(
                              UserData.user!.profilePic!,
                              fit: BoxFit.cover,
                            )),
                  SizedBox(
                    width: 60,
                    child: OutlinedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(profileSettingsRoute),
                        style: ElevatedButton.styleFrom(
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                  UserData.user!.displayName == ''
                      ? UserData.user!.username
                      : UserData.user!.displayName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
              const SizedBox(height: 10),
              Text('u/${UserData.user!.username} . 1 karma . 41d . 3 Oct 2022',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 5),
              Text(UserData.profileSettings!.about,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 60),
            ],
          ),
        )
      ],
    );
  }

  Widget tabBar() {
    return Scaffold(
        appBar: AppBar(
      toolbarHeight: 0,
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      bottom: const TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 3.0, color: Colors.blue),
          insets: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
        ),
        tabs: [
          Tab(text: 'Posts'),
          Tab(text: 'Comments'),
          Tab(text: 'About'),
        ],
      ),
    ));
  }

  Widget _upperAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 30),
            CircleAvatar(
                radius: 20,
                child: UserData.user!.profilePic == ''
                    ? const Icon(
                        Icons.person,
                        size: 20,
                      )
                    : Image.network(
                        UserData.user!.profilePic!,
                        fit: BoxFit.cover,
                      )),
            const SizedBox(width: 10),
            Text(
              UserData.user!.displayName == ''
                  ? UserData.user!.username
                  : UserData.user!.displayName!,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.file_upload_outlined, size: 30)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_horiz, size: 30)),
          ],
        ),
      ],
    );
  }

  Widget _buildPosts() {
    return SingleChildScrollView(
      child: BlocBuilder<PostsMyProfileCubit, PostsMyProfileState>(
        builder: (context, state) {
          if (state is PostsLoaded) {
            return Column(children: [
              ...state.posts!.map((e) => PostsWeb(postsModel: e)).toList()
            ]);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      children: [
        _buildPosts(),
        _empty(),
        _empty(),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      stretch: true,
      expandedHeight: 320,
      title: _upperAppBar(),
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: _appBarContent(),
      ),
      backgroundColor: Colors.redAccent,
      pinned: true,
      bottom: const TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 3.0, color: Colors.blue),
          insets: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
        ),
        tabs: [
          Tab(text: 'Posts'),
          Tab(text: 'Comments'),
          Tab(text: 'About'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (_, bool innerBoxIsScrolled) {
              return [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    if (state is SettingsChanged) {
                      return _buildAppBar();
                    }
                    return _buildAppBar();
                  },
                )
              ];
            },
            body: _buildBody()),
      ),
    );
  }
}
