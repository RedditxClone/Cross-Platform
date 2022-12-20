import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/model/message_screen_model.dart';
import 'package:reddit/business_logic/cubit/message_screen_cubit.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late List<AllSentMessageModel> allSentMessages;
  late List<AllMessageInboxModel> allMessagesInbox;
  late AllMessages allMessages;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessageScreenCubit>(context).getAllMessages();
  }

  Widget createAllMassageContainer(String massageId, String massageTitle,
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
                                        "from",
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
                                    const EdgeInsets.only(left: 5, bottom: 30),
                                child: Row(children: <Widget>[
                                  //Options Row
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: (() {
                                          //TODO : Make Reply page with MassageId.
                                        }),
                                        child: const Text(
                                          "Reply",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 124, 122, 122),
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: (() {
                                        //TODO :  Delete this Massage with MassageId.
                                      }),
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 124, 122, 122),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: (() {
                                          //TODO :  Report on this Massage with MassageId.
                                        }),
                                        child: const Text(
                                          "Report",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 124, 122, 122),
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: (() {
                                          //TODO :  Block User with UserId.
                                        }),
                                        child: const Text(
                                          "Block User",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 124, 122, 122),
                                          ),
                                        ),
                                      )),
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

  Widget getAllMassageContainerWidgets(
      List<AllMessageInboxModel> allMessagesList) {
    return Column(
        children: allMessagesList
            .map((message) => createAllMassageContainer(
                message.id,
                message.subject,
                message.authorName,
                message.createdAt,
                message.body,
                const Color.fromARGB(255, 27, 26, 26)))
            .toList());
  }

  Widget getAllMessageInbox(List<AllMessageInboxModel> allMessagesList) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 100),
        child: Column(
            children: <Widget>[getAllMassageContainerWidgets(allMessagesList)]),
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "Messages",
            style: TextStyle(
              color: Color.fromARGB(255, 236, 226, 226),
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text(
                'Inbox',
                style: TextStyle(
                  color: Color.fromARGB(255, 97, 92, 92),
                  fontSize: 15,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Sent', //Will be added in Further Versions Updates
                style: TextStyle(
                  color: Color.fromARGB(255, 97, 92, 92),
                  fontSize: 15,
                ),
              ),
            ),
          ]),
        ),
        body: BlocBuilder<MessageScreenCubit, MessageScreenState>(
          builder: (context, state) {
            if (state is AllMessagesLoaded) {
              allMessages = (state).allMessages;
              allMessagesInbox = allMessages.getInboxMessages();
              allSentMessages = allMessages.getSentMessages();
              print('data in UI');
              print(allMessages);
              print(allMessagesInbox);
              print(allSentMessages);
              return TabBarView(children: [
                getAllMessageInbox(allMessagesInbox),
                getAllSentMessage(allSentMessages),
              ]);
            } else {
              return TabBarView(children: [
                Container(),
                Container(),
              ]);
            }
          },
        ),
      ),
    );
  }
}
