import 'package:flutter/material.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class PopularWeb extends StatefulWidget {
  const PopularWeb({Key? key}) : super(key: key);

  @override
  State<PopularWeb> createState() => _PopularWebState();
}

class _PopularWebState extends State<PopularWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.2),
            title: const AppBarWebLoggedIn(
              screen: 'Popular',
            )),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 1, child: SizedBox(width: 10)),
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
                              Container(
                                width: 245.6,
                                color: const Color.fromRGBO(70, 70, 70, 100),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: 245.6,
                                color: const Color.fromRGBO(70, 70, 70, 100),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: 245.6,
                                color: const Color.fromRGBO(70, 70, 70, 100),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: 245.6,
                                color: const Color.fromRGBO(70, 70, 70, 100),
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
                                      color:
                                          const Color.fromRGBO(70, 70, 70, 100),
                                      margin: const EdgeInsets.only(bottom: 15),
                                    ),
                                    Container(
                                      height: 130,
                                      color:
                                          const Color.fromRGBO(70, 70, 70, 100),
                                      margin: const EdgeInsets.only(bottom: 15),
                                    ),
                                    Container(
                                      height: 400,
                                      color:
                                          const Color.fromRGBO(70, 70, 70, 100),
                                      margin: const EdgeInsets.only(bottom: 15),
                                    ),
                                    Container(
                                      height: 400,
                                      color:
                                          const Color.fromRGBO(70, 70, 70, 100),
                                      margin: const EdgeInsets.only(bottom: 15),
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
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                        ),
                                        Container(
                                          height: 200,
                                          color: const Color.fromRGBO(
                                              70, 70, 70, 100),
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                        ),
                                        Container(
                                          height: 200,
                                          color: const Color.fromRGBO(
                                              70, 70, 70, 100),
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
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
        ));
  }
}
