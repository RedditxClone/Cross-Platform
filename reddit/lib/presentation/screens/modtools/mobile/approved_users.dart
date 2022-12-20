import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/messages/messages_cubit.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';

class ApprovedUsersScreen extends StatefulWidget {
  const ApprovedUsersScreen({super.key});

  @override
  State<ApprovedUsersScreen> createState() => _ApprovedUsersScreenState();
}

class _ApprovedUsersScreenState extends State<ApprovedUsersScreen> {
  List<User>? approvedUsers;
  TextEditingController subjectController = TextEditingController();

  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<ModtoolsCubit>(context)
        .getApprovedUsers('639b27bbef88b3df0463d04b');
    super.initState();
  }

  /// [context] : build context.
  /// [color] : color of the error msg to be displayer e.g. ('red' : error , 'blue' : success ).
  /// [title] : message to be displayed to the user.
  void displayMsg(BuildContext context, Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 400,
      content: Container(
          height: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.black,
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

  void _sendMessageBottomSheet(BuildContext buildcontext, index) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        context: buildcontext,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (_) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Scaffold(
              appBar: AppBar(
                leading: CloseButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<MessagesCubit>(context).sendMessage(
                            subjectController.text,
                            messageController.text,
                            approvedUsers![index].username);
                      },
                      child: const Text('Send', style: TextStyle(fontSize: 20)))
                ],
              ),
              body: Container(
                height: MediaQuery.of(context).size.height - 50,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'u/ ${approvedUsers![index].username}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    const Divider(thickness: 1, color: Colors.grey),
                    const SizedBox(height: 5),
                    TextField(
                      controller: subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          border: InputBorder.none,
                        )),
                    const Divider(thickness: 1, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _moreOptionsBottomSheet(BuildContext ctx, index) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            height: 220,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _sendMessageBottomSheet(ctx, index);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.create_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text("Send message",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white))
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () => Navigator.pushNamed(
                        context, otherProfilePageRoute,
                        arguments: approvedUsers![index].username),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.person_pin_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("View profile",
                            style: TextStyle(fontSize: 20, color: Colors.white))
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      BlocProvider.of<ModtoolsCubit>(context)
                          .removeApprovedUser('639b27bbef88b3df0463d04b',
                              approvedUsers![index].username);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        SizedBox(width: 20),
                        Text("Remove",
                            style: TextStyle(fontSize: 20, color: Colors.red))
                      ],
                    )),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      backgroundColor: const Color.fromRGBO(90, 90, 90, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Center(
                      child: Text(
                        "Close",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  Widget listviewItem(context, index) {
    Duration date =
        DateTime.now().difference(DateTime.parse(approvedUsers![index].date));
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      InkWell(
        onTap: () => Navigator.pushNamed(context, otherProfilePageRoute,
            arguments: approvedUsers![index].username),
        child: Row(children: [
          approvedUsers![index].profilePic == null ||
                  approvedUsers![index].profilePic == ''
              ? const CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person))
              : CircleAvatar(
                  radius: 17,
                  backgroundImage:
                      NetworkImage(approvedUsers![index].profilePic!)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('u/${approvedUsers![index].username}'),
              Text(
                date.inHours > 24
                    ? '${date.inDays} days ago'
                    : date.inMinutes > 60
                        ? '${date.inHours} hours ago'
                        : date.inSeconds > 60
                            ? '${date.inMinutes} mins ago'
                            : '${date.inSeconds + 1} secs ago',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ]),
      ),
      IconButton(
          onPressed: () => _moreOptionsBottomSheet(context, index),
          icon: const Icon(Icons.more_horiz))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultSecondaryColor,
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Aproved Users'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, addApprovedRoute),
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocListener<MessagesCubit, MessagesState>(
        listener: (context, state) {
          if (state is MessageSent) {
            subjectController.text = '';
            messageController.text = '';
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, approvedRoute);
            displayMsg(context, Colors.green, 'Message sent successfully');
          } else if (state is EmptySubject) {
            displayMsg(context, Colors.red, 'Please enter a subject');
          } else if (state is EmptyBody) {
            displayMsg(context, Colors.red, 'Please enter a message');
          } else {
            displayMsg(context, Colors.red, 'An error has occured');
          }
        },
        child: BlocBuilder<ModtoolsCubit, ModtoolsState>(
          builder: (context, state) {
            if (state is ApprovedListAvailable) {
              approvedUsers = state.approved;
              if (approvedUsers!.isEmpty) {
                // return emptyUserManagement(context);
              }

              return ListView.builder(
                  itemCount: approvedUsers!.length,
                  itemBuilder: (context, index) {
                    return listviewItem(context, index);
                  });
            }
            if (state is AddedToApprovedUsers) {
              approvedUsers = state.approved;

              return ListView.builder(
                  itemCount: approvedUsers!.length,
                  itemBuilder: (context, index) {
                    return listviewItem(context, index);
                  });
            }
            if (state is RemovedFromApprovedUsers) {
              approvedUsers = state.approved;
              if (approvedUsers!.isEmpty) {
                // return emptyUserManagement(context);
              }

              return ListView.builder(
                  itemCount: approvedUsers!.length,
                  itemBuilder: (context, index) {
                    return listviewItem(context, index);
                  });
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
