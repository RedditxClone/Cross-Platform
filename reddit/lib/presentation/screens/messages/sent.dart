import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/presentation/widgets/messages/message_tab_bar.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/constants/colors.dart';

import 'package:reddit/data/model/message_screen_model.dart';
import 'package:reddit/business_logic/cubit/cubit/sent_screen_cubit.dart';

class SentWeb extends StatefulWidget {
  const SentWeb({super.key});

  @override
  State<SentWeb> createState() => _SentWebState();
}

class _SentWebState extends State<SentWeb> {
  late List<AllSentMessageModel> allSentMessages;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SentScreenCubit>(context).getAllSentMessages();
  }

  Widget createSentMassageContainer(String massageId, String massageTitle,
      String userName, String time, String massageBody, Color c) {
    return Container(
      color: const Color.fromARGB(0, 0, 0, 0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(0, 0, 0, 0),
              ),
            ),
            Expanded(
              flex: 70,
              child: Container(
                color: c,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: c,
                      ),
                    ),
                    Expanded(
                      flex: 100,
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            //Title Row
                            Expanded(
                              child: SizedBox(
                                child: ListTile(
                                  leading: const Icon(Icons.mail),
                                  title: Text(
                                    massageTitle,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 236, 226, 226),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Row(children: <Widget>[
                                  //Massage info Row
                                  const Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text(
                                        "to",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 105, 105, 105),
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        "/u/$userName ",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 15, 116, 12),
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        " sent $time ago",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 105, 105, 105),
                                        ),
                                      )),
                                ]),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  child: Row(children: <Widget>[
                                    //Massage Body Row
                                    Expanded(
                                      child: SizedBox(
                                          child: Text(
                                        massageBody,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 213, 208, 208),
                                        ),
                                      )),
                                    ),
                                  ]),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, bottom: 30),
                                child: Row(children: <Widget>[
                                  //Options Row
                                  InkWell(
                                    onTap: (() {
                                      //TODO : Make Reply page with MassageId.
                                    }),
                                    child: const Text(
                                      "Reply",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 124, 122, 122),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        color: c,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAllSendMassageContainerWidgets(
      List<AllSentMessageModel> allSentMessagesList) {
    return Column(
        children: allSentMessagesList
            .map((message) => createSentMassageContainer(
                message.id,
                message.subject,
                message.destName,
                message.createdAt,
                message.body,
                const Color.fromARGB(255, 27, 26, 26)))
            .toList());
  }

  Widget getAllSentMessage(List<AllSentMessageModel> allSentMessagesList) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 100),
        child: Column(children: <Widget>[
          getAllSendMassageContainerWidgets(allSentMessagesList)
        ]),
      ),
    );
  }

  Widget _sentMessagesBody(context, List<AllSentMessageModel> allSentMessages) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width - 1200 > 0
                  ? MediaQuery.of(context).size.width - 1200
                  : 0),
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width - 1200 > 0
                ? 800
                : MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: cardsColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getAllSentMessage(allSentMessages),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 1200 > 0
                  ? MediaQuery.of(context).size.width - 1200
                  : 0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          automaticallyImplyLeading: false,
          backgroundColor: defaultAppbarBackgroundColor,
          title: const AppBarWebLoggedIn(screen: 'Messages')),
      body: BlocBuilder<SentScreenCubit, SentScreenState>(
        builder: (context, state) {
          if (state is SentScreenLoaded) {
            allSentMessages = (state).sentMessages;
            return SingleChildScrollView(
              child: Column(
                children: [
                  MessagesTabBar(index: 2),
                  _sentMessagesBody(context, allSentMessages),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  MessagesTabBar(index: 2),
                  Container(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
