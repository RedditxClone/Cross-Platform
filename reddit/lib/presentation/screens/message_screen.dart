import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String text1 =
      '''Thanks for submitting a report to Reddit. Your report and the related content have been processed through our anti-abuse systems for review. It has been determined that the reported content does not violate Reddit’s Content Policy.

If you’d like to restrict contact from the account(s) you reported, you can block them in your Safety and Privacy settings. You can also hide any posts or comments you don’t want to see by selecting Hide from the “…” menu.

If you see any other site policy violations or continue to have problems, submit a new report to let us know and we’ll take further action, as appropriate.

Thanks again for your report, and for looking out for yourself and your fellow redditors. Your reporting helps make Reddit a better, safer, and more welcoming place for everyone.

If you think this decision may have been a mistake, you can send us a message from this link to request your report be re-reviewed.

For your reference, here are additional details about your report:

Report Details

Report Reason: it's promoting hate based on identity or vulnerability

Submitted on: 2022-10-12 15:20:20 UTC

Reported account(s): bemoierian

Link to reported content: https://www.reddit.com/r/redditx_/comments/y1e2vt

This is an automated message; responses will not be received by Reddit admins.


Report Reason: it's promoting hate based on identity or vulnerability

Submitted on: 2022-10-12 15:20:20 UTC

Reported account(s): bemoierian

Link to reported content: https://www.reddit.com/r/redditx_/comments/y1e2vt

This is an automated message; responses will not be received by Reddit admins.
Link to reported content: https://www.reddit.com/r/redditx_/comments/y1e2vt

This is an automated message; responses will not be received by Reddit admins.


Report Reason: it's promoting hate based on identity or vulnerability

Submitted on: 2022-10-12 15:20:20 UTC

Reported account(s): bemoierian

Link to reported content: https://www.reddit.com/r/redditx_/comments/y1e2vt

This is an automated message; responses will not be received by Reddit admins.
''';

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
                  color: Color.fromARGB(255, 53, 49, 49),
                  fontSize: 15,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Sent', //Will be added in Further Versions Updates
                style: TextStyle(
                  color: Color.fromARGB(255, 53, 49, 49),
                  fontSize: 15,
                ),
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 100),
              child: Column(children: <Widget>[
                createAllMassageContainer(
                    '1',
                    'In_The_Name_Of_Allah',
                    'OmarKh2001',
                    '2 months',
                    text1,
                    const Color.fromARGB(255, 27, 26, 26)),
                createAllMassageContainer(
                    '2',
                    'In the name of God, the Most Gracious, the Most Merciful, God, there is no god but God',
                    'OKAM2001',
                    '20 days',
                    text1,
                    const Color.fromARGB(255, 53, 49, 49)),
              ]),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 100),
              child: Column(children: <Widget>[
                createSentMassageContainer(
                    '1',
                    'In_The_Name_Of_Allah',
                    'OmarKh2001',
                    '2 months',
                    text1,
                    const Color.fromARGB(255, 27, 26, 26)),
                createSentMassageContainer(
                    '2',
                    'In the name of God, the Most Gracious, the Most Merciful, God, there is no god but God',
                    'OKAM2001',
                    '20 days',
                    text1,
                    const Color.fromARGB(255, 53, 49, 49)),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
