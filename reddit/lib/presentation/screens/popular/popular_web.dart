import 'package:flutter/material.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/presentation/widgets/home_widgets/left_list_not_logged_in.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class PopularWeb extends StatefulWidget {
  final bool isLoggedIn;
  const PopularWeb({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<PopularWeb> createState() => _PopularWebState();
}

class _PopularWebState extends State<PopularWeb> {
  late Responsive responsive;

  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: defaultAppbarBackgroundColor,
            title: const AppBarWebLoggedIn(
              screen: 'Popular',
            )),
        body:
            //  SingleChildScrollView(
            // child:
            Container(
          color: defaultWebBackgroundColor,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !widget.isLoggedIn && MediaQuery.of(context).size.width > 1300
                  ? const LeftList()
                  : const SizedBox(width: 0),
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: widget.isLoggedIn
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
                        flex: 5,
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   width: 245.6,
                                    //   color:
                                    //       const Color.fromRGBO(70, 70, 70, 100),
                                    // ),
                                    const SizedBox(width: 15),
                                    Container(
                                      width: 245.6,
                                      color:
                                          const Color.fromRGBO(70, 70, 70, 100),
                                    ),
                                    const SizedBox(width: 15),
                                    Container(
                                      width: 245.6,
                                      color:
                                          const Color.fromRGBO(70, 70, 70, 100),
                                    ),
                                    const SizedBox(width: 15),
                                    Container(
                                      width: 245.6,
                                      color:
                                          const Color.fromRGBO(70, 70, 70, 100),
                                    ),
                                    const SizedBox(width: 15),
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
                                            height: 130,
                                            color: const Color.fromRGBO(
                                                70, 70, 70, 100),
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                          ),
                                          Container(
                                            height: 130,
                                            color: const Color.fromRGBO(
                                                70, 70, 70, 100),
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                          ),
                                          Container(
                                            height: 400,
                                            color: const Color.fromRGBO(
                                                70, 70, 70, 100),
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                          ),
                                          Container(
                                            height: 400,
                                            color: const Color.fromRGBO(
                                                70, 70, 70, 100),
                                            margin: const EdgeInsets.only(
                                                bottom: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  MediaQuery.of(context).size.width < 900
                                      ? const SizedBox(width: 10)
                                      : Expanded(
                                          flex: 3,
                                          child: Column(
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
                      const Expanded(flex: 1, child: SizedBox(width: 10))
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
