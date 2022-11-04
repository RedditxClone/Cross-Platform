import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit/constants/responsive.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  late Responsive responsive;
  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: responsive.isSmallSizedScreen() |
                        responsive.isMediumSizedScreen()
                    ? 0
                    : responsive.isLargeSizedScreen()
                        ? 1
                        : 2,
                child: const SizedBox(width: 10)),
            Expanded(
              flex: 5,
              child: SizedBox(
                width: 10,
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      color: const Color.fromRGBO(70, 70, 70, 100),
                      margin: const EdgeInsets.only(bottom: 15),
                    ),
                    Container(
                      height: 130,
                      color: const Color.fromRGBO(70, 70, 70, 100),
                      margin: const EdgeInsets.only(bottom: 15),
                    ),
                    Container(
                      height: 400,
                      color: const Color.fromRGBO(70, 70, 70, 100),
                      margin: const EdgeInsets.only(bottom: 15),
                    ),
                    Container(
                      height: 400,
                      color: const Color.fromRGBO(70, 70, 70, 100),
                      margin: const EdgeInsets.only(bottom: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width < 900 ? 0 : 15),
            MediaQuery.of(context).size.width < 900
                ? const SizedBox(width: 0)
                : Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Container(
                          height: 500,
                          color: const Color.fromRGBO(70, 70, 70, 100),
                          margin: const EdgeInsets.only(bottom: 15),
                        ),
                        Container(
                          height: 200,
                          color: const Color.fromRGBO(70, 70, 70, 100),
                          margin: const EdgeInsets.only(bottom: 15),
                        ),
                        Container(
                          height: 200,
                          color: const Color.fromRGBO(70, 70, 70, 100),
                          margin: const EdgeInsets.only(bottom: 15),
                        ),
                      ],
                    )),
            Expanded(
                flex: responsive.isSmallSizedScreen() |
                        responsive.isMediumSizedScreen()
                    ? 0
                    : responsive.isLargeSizedScreen()
                        ? 1
                        : 2,
                child: const SizedBox(width: 10))
          ],
        ),
      ),
    );
  }
}
