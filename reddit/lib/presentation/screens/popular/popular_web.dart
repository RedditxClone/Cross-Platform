import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/home_widgets/left_list_not_logged_in.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_Not_loggedin.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

import '../../../business_logic/cubit/posts/posts_cubit.dart';

class PopularWeb extends StatefulWidget {
  PopularWeb({Key? key}) : super(key: key);

  @override
  State<PopularWeb> createState() => _PopularWebState();
}

class _PopularWebState extends State<PopularWeb> {
  late Responsive responsive;
  late bool isLoggedIn;
  _PopularWebState();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostsCubit>(context).getPosts();
    isLoggedIn = UserData.user != null;
  }

  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return Scaffold(
        appBar: AppBar(
            shape: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.3)),
            automaticallyImplyLeading: false,
            backgroundColor: defaultAppbarBackgroundColor,
            title: isLoggedIn
                ? const AppBarWebLoggedIn( screen: 'Popular')
                : const AppBarWebNotLoggedIn(screen: 'Popular')),
        body: Container(
          color: defaultWebBackgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isLoggedIn && MediaQuery.of(context).size.width > 1300
                  ? const LeftList()
                  : const SizedBox(width: 0),
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: isLoggedIn || MediaQuery.of(context).size.width < 1300
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width - 280,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: responsive.isSmallSizedScreen() |
                                  responsive.isMediumSizedScreen()
                              ? 0
                              : 1,
                          child: const SizedBox(width: 10)),
                      Expanded(
                        flex: responsive.isLargeSizedScreen()
                            ? 8
                            : responsive.isXLargeSizedScreen()
                                ? 6
                                : 7,
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // put your popular card here istead of container
                                        width: 245.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                70, 70, 70, 100)),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      flex: MediaQuery.of(context).size.width <
                                              800
                                          ? 0
                                          : 1,
                                      child: Container(
                                        // put your popular card here istead of container
                                        width:
                                            MediaQuery.of(context).size.width <
                                                    800
                                                ? 0
                                                : 245.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                70, 70, 70, 100)),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width <
                                                    800
                                                ? 0
                                                : 15),
                                    Expanded(
                                      flex: MediaQuery.of(context).size.width >
                                              1200
                                          ? 1
                                          : 0,
                                      child: Container(
                                        // put your popular card here istead of container
                                        width:
                                            MediaQuery.of(context).size.width <
                                                    1000
                                                ? 0
                                                : 245.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                70, 70, 70, 100)),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width <
                                                    1200
                                                ? 0
                                                : 15),
                                    Expanded(
                                      flex: MediaQuery.of(context).size.width >
                                              1500
                                          ? 1
                                          : 0,
                                      child: Container(
                                        // put your popular card here istead of container
                                        width:
                                            MediaQuery.of(context).size.width <
                                                    1200
                                                ? 0
                                                : 245.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                70, 70, 70, 100)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      width: 10,
                                      child: Column(
                                        children: [
                                          Container(
                                            // add post
                                            height: 70,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromRGBO(
                                                    70, 70, 70, 100)),
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                          ),
                                          Container(
                                            // sort post
                                            height: 70,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromRGBO(
                                                    70, 70, 70, 100)),
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                          ),
                                          BlocBuilder<PostsCubit, PostsState>(
                                            builder: (context, state) {
                                              if (state is PostsLoaded) {
                                                return Column(children: [
                                                  ...state.posts!
                                                      .map((e) => PostsWeb(
                                                          postsModel: e))
                                                      .toList()
                                                ]);
                                              }
                                              return Container();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  MediaQuery.of(context).size.width < 1000
                                      ? const SizedBox(width: 0)
                                      : Expanded(
                                          flex: 3,
                                          child: Column(
                                            // there are the right cards
                                            children: [
                                              Container(
                                                height: 500,
                                                color: const Color.fromRGBO(
                                                    70, 70, 70, 100),
                                                margin: const EdgeInsets.only(
                                                    bottom: 15),
                                              ),
                                              Container(
                                                height: 200,
                                                color: const Color.fromRGBO(
                                                    70, 70, 70, 100),
                                                margin: const EdgeInsets.only(
                                                    bottom: 15),
                                              ),
                                              Container(
                                                height: 200,
                                                color: const Color.fromRGBO(
                                                    70, 70, 70, 100),
                                                margin: const EdgeInsets.only(
                                                    bottom: 15),
                                              ),
                                            ],
                                          )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: responsive.isSmallSizedScreen() |
                                  responsive.isMediumSizedScreen()
                              ? 0
                              : 1,
                          child: SizedBox(
                              width: responsive.isSmallSizedScreen() ? 0 : 10))
                    ],
                  ),
                ),
              ),
            ],
          ),
          // ),
        ));
  }
}
