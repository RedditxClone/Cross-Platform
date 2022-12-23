import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';

class UserManagement extends StatefulWidget {
  final String screen;
  final String subredditId;
  const UserManagement(
      {required this.screen, required this.subredditId, super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  String addButtonName = '';
  TextEditingController addApprovedUserController = TextEditingController();
  TextEditingController moderatorController = TextEditingController();
  List<User> approvedUsers = [];
  //muted users
  TextEditingController usernameMuteController = TextEditingController();
  TextEditingController reasonMuteController = TextEditingController();
  FocusNode usernameMutedFocusNode = FocusNode();
  FocusNode reasonMutedFocusNode = FocusNode();
  //banned users
  TextEditingController usernameController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode reasonFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();
  FocusNode dayFocusNode = FocusNode();
  FocusNode msgFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    if (widget.screen == 'Approved') {
      BlocProvider.of<ModtoolsCubit>(context)
          .getApprovedUsers(widget.subredditId);
    } else if (widget.screen == 'Moderators') {
      debugPrint('moderator page');
      BlocProvider.of<ModtoolsCubit>(context).getModerators(widget.subredditId);
    } else if (widget.screen == 'Banned') {
      BlocProvider.of<ModtoolsCubit>(context)
          .getBannedUsers(widget.subredditId);
    } else {
      BlocProvider.of<ModtoolsCubit>(context).getMutedUsers(widget.subredditId);
    }
  }

  Widget emptyUserManagement(context) {
    String msg = widget.screen == 'Approved'
        ? 'No approved users in the community'
        : widget.screen == 'Moderators'
            ? 'No moderators in the community'
            : widget.screen == 'Banned'
                ? 'No banned users in the community'
                : 'No mutted users in the community';
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width - 320,
        color: defaultSecondaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.speaker_notes_off_outlined, color: Colors.grey),
              const SizedBox(height: 30),
              Text(
                msg,
                style: const TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ],
          ),
        ));
  }

  /// [context] : build context.
  /// [color] : color of the error msg to be displayer e.g. ('red' : error , 'blue' : success ).
  /// [title] : message to be displayed to the user.
  void displayMsg(BuildContext context, Color color, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: 450,
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
                style: TextStyle(
                    fontSize: title.length > 20 ? 11 : 16, color: Colors.white),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Widget listviewItemApproved(context, index) {
    Duration date =
        DateTime.now().difference(DateTime.parse(approvedUsers[index].date));
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 0.3, color: Colors.grey),
        ),
        color: defaultSecondaryColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            hoverColor: defaultThirdColor,
            onTap: () => Navigator.pushNamed(context, otherProfilePageRoute,
                arguments: approvedUsers[index].username),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(children: [
                approvedUsers[index].profilePic == null ||
                        approvedUsers[index].profilePic == ''
                    ? const CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person))
                    : CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            NetworkImage(approvedUsers[index].profilePic!)),
                const SizedBox(width: 10),
                Text(approvedUsers[index].username ?? ""),
              ]),
            ),
          ),
        ),
        SizedBox(width: 148.0 - approvedUsers[index].username!.length * 7),
        Text(
            date.inHours > 24
                ? '${date.inDays} days ago'
                : date.inMinutes > 60
                    ? '${date.inHours} hours ago'
                    : date.inSeconds > 60
                        ? '${date.inMinutes} minunts ago'
                        : '${date.inSeconds + 1} seconds ago',
            style: const TextStyle(fontSize: 13, color: Colors.grey)),
        SizedBox(
            width: MediaQuery.of(context).size.width - 880 > 0
                ? MediaQuery.of(context).size.width - 880
                : 0),
        InkWell(
            onTap: () => Navigator.pushNamed(context, sendMessageRoute,
                arguments: approvedUsers[index].username),
            child: const Text('Send message',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        const SizedBox(width: 20),
        InkWell(
            onTap: () => BlocProvider.of<ModtoolsCubit>(context)
                .removeApprovedUser(
                    widget.subredditId, approvedUsers[index].username!),
            child: const Text('Remove',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
      ]),
    );
  }

  Widget listviewItemMuted(context, index) {
    Duration date =
        DateTime.now().difference(DateTime.parse(approvedUsers[index].date));
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 0.3, color: Colors.grey),
        ),
        color: defaultSecondaryColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            hoverColor: defaultThirdColor,
            onTap: () => Navigator.pushNamed(context, otherProfilePageRoute,
                arguments: approvedUsers[index].username),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(children: [
                approvedUsers[index].profilePic == null ||
                        approvedUsers[index].profilePic == ''
                    ? const CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person))
                    : CircleAvatar(
                        radius: 17,
                        backgroundImage:
                            NetworkImage(approvedUsers[index].profilePic!)),
                const SizedBox(width: 10),
                Text(approvedUsers[index].username ?? ""),
              ]),
            ),
          ),
        ),
        SizedBox(width: 148.0 - approvedUsers[index].username!.length * 7),
        Text(
            date.inHours > 24
                ? '${date.inDays} days ago'
                : date.inMinutes > 60
                    ? '${date.inHours} hours ago'
                    : date.inSeconds > 60
                        ? '${date.inMinutes} minunts ago'
                        : '${date.inSeconds + 1} seconds ago',
            style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ]),
    );
  }

  Widget listviewItemBanned(context, index) {
    Duration durantion =
        DateTime.now().difference(DateTime.parse(approvedUsers[index].date));
    String postedFrom = "";
    if (durantion.inDays > 0) {
      postedFrom = "${durantion.inDays} days";
    } else if (durantion.inHours > 0) {
      postedFrom = "${durantion.inHours} hours";
    } else if (durantion.inMinutes > 0) {
      postedFrom = "${durantion.inMinutes} minutes";
    } else {
      postedFrom = "${durantion.inSeconds} seconds";
    }
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 0.3, color: Colors.grey),
        ),
        color: defaultSecondaryColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: defaultThirdColor,
              onTap: () => Navigator.pushNamed(context, otherProfilePageRoute,
                  arguments: approvedUsers[index].username),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(children: [
                  approvedUsers[index].profilePic == null ||
                          approvedUsers[index].profilePic == ''
                      ? const CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person))
                      : CircleAvatar(
                          radius: 17,
                          backgroundImage:
                              NetworkImage(approvedUsers[index].profilePic!)),
                  const SizedBox(width: 10),
                  Text(approvedUsers[index].username ?? ""),
                ]),
              ),
            ),
          ),
          SizedBox(width: 148.0 - approvedUsers[index].username!.length * 7),
          Text(postedFrom,
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget listviewItemModerator(context, index) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 0.3, color: Colors.grey),
        ),
        color: defaultSecondaryColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: defaultThirdColor,
              onTap: () => Navigator.pushNamed(context, otherProfilePageRoute,
                  arguments: approvedUsers[index].username),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(children: [
                  approvedUsers[index].profilePic == null ||
                          approvedUsers[index].profilePic == ''
                      ? const CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person))
                      : CircleAvatar(
                          radius: 17,
                          backgroundImage:
                              NetworkImage(approvedUsers[index].profilePic!)),
                  const SizedBox(width: 10),
                  Text(approvedUsers[index].username ?? ""),
                ]),
              ),
            ),
          ),
          SizedBox(width: 148.0 - approvedUsers[index].username!.length * 7),
          Text(approvedUsers[index].about ?? '',
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget userManagementList(context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 230,
        width: MediaQuery.of(context).size.width - 320,
        child: BlocListener<ModtoolsCubit, ModtoolsState>(
          listener: (context, state) {
            if (state is AddedToApprovedUsers) {
              displayMsg(context, Colors.green,
                  'Successfully added an approved submitter');
            }
            if (state is AddedToModerators) {
              if (state.statusCode == 400) {
                displayMsg(context, Colors.red,
                    ' This user is already a moderator or the username is not valid');
                BlocProvider.of<ModtoolsCubit>(context)
                    .getModerators(widget.subredditId);
              } else {
                moderatorController.text = '';
                displayMsg(context, Colors.green,
                    ' ${moderatorController.text} becomes a moderator');
                BlocProvider.of<ModtoolsCubit>(context)
                    .getModerators(widget.subredditId);
              }
            }
            if (state is MuteUser) {
              BlocProvider.of<ModtoolsCubit>(context)
                  .getMutedUsers(widget.subredditId);
              if (state.statusCode == 400) {
                displayMsg(context, Colors.red,
                    'This user is already muted or the username is not valid');
              } else {
                displayMsg(context, Colors.green,
                    ' ${usernameMuteController.text} is muted');
                usernameMuteController.text = '';
                reasonMuteController.text = '';
              }
            }
            if (state is BanUser) {
              BlocProvider.of<ModtoolsCubit>(context)
                  .getBannedUsers(widget.subredditId);
              if (state.statusCode == 400) {
                displayMsg(context, Colors.red,
                    'This user is already banned or the username is not valid');
              } else {
                displayMsg(context, Colors.green,
                    ' ${usernameController.text} is banned');
                usernameController.text = '';
                reasonController.text = '';
                msgController.text = '';
                dayController.text = '';
                noteController.text = '';
              }
            }
          },
          child: BlocBuilder<ModtoolsCubit, ModtoolsState>(
            builder: (context, state) {
              if (state is ApprovedListAvailable) {
                approvedUsers = state.approved;
                if (approvedUsers.isEmpty) {
                  return emptyUserManagement(context);
                }
                return ListView.builder(
                    itemCount: approvedUsers.length,
                    itemBuilder: (context, index) {
                      return listviewItemApproved(context, index);
                    });
              }
              if (state is ModeratorsListAvailable) {
                approvedUsers = state.moderators;
                if (approvedUsers.isEmpty) {
                  return emptyUserManagement(context);
                }
                return ListView.builder(
                    itemCount: approvedUsers.length,
                    itemBuilder: (context, index) {
                      return listviewItemModerator(context, index);
                    });
              }
              if (state is BannedListAvailable) {
                approvedUsers = state.bannedUsers;
                if (approvedUsers.isEmpty) {
                  return emptyUserManagement(context);
                }
                return ListView.builder(
                    itemCount: approvedUsers.length,
                    itemBuilder: (context, index) {
                      return listviewItemBanned(context, index);
                    });
              }
              if (state is MutedListAvailable) {
                approvedUsers = state.mutedUsers;
                if (approvedUsers.isEmpty) {
                  return emptyUserManagement(context);
                }
                return ListView.builder(
                    itemCount: approvedUsers.length,
                    itemBuilder: (context, index) {
                      return listviewItemMuted(context, index);
                    });
              }
              if (state is AddedToApprovedUsers) {
                approvedUsers = state.approved;
                addApprovedUserController.text = '';
                return ListView.builder(
                    itemCount: approvedUsers.length,
                    itemBuilder: (context, index) {
                      return listviewItemApproved(context, index);
                    });
              }
              if (state is RemovedFromApprovedUsers) {
                approvedUsers = state.approved;
                if (approvedUsers.isEmpty) {
                  return emptyUserManagement(context);
                }
                return ListView.builder(
                    itemCount: approvedUsers.length,
                    itemBuilder: (context, index) {
                      return listviewItemApproved(context, index);
                    });
              }
              if (approvedUsers.isEmpty) {
                return emptyUserManagement(context);
              }
              return const Center(child: CircularProgressIndicator.adaptive());
            },
          ),
        ));
  }

  void _addApproved(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: defaultSecondaryColor,
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add approved user',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
              ],
            ),
            content: SizedBox(
              height: 137,
              child: Column(
                children: [
                  Container(
                      width: 420,
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: addApprovedUserController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter username',
                        ),
                        onChanged: (text) {},
                      )),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: defaultThirdColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<ModtoolsCubit>(context)
                                .addApprovedUser(widget.subredditId,
                                    addApprovedUserController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Text(
                            "Add user",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  )
                ],
              ),
            ), // TODO : FIX THIS TEXT FIELD
          );
        });
  }

  void _addModerator(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: defaultSecondaryColor,
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add new moderator',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
              ],
            ),
            content: SizedBox(
              height: 137,
              child: Column(
                children: [
                  Container(
                      width: 420,
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: moderatorController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter username',
                        ),
                      )),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: defaultThirdColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<ModtoolsCubit>(context)
                                .addModerator(widget.subredditId,
                                    moderatorController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Text(
                            "Add moderator",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _addBanned(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: defaultSecondaryColor,
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add a banned user',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
              ],
            ),
            content: SizedBox(
              height: 400,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text('Username', style: TextStyle(fontSize: 17)),
                      const SizedBox(height: 10),
                      TextField(
                        focusNode: usernameFocusNode,
                        controller: usernameController,
                        style: const TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixText: 'u/',
                          prefixStyle: const TextStyle(
                              color: Colors.white, fontSize: 19),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'username',
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          noteFocusNode.requestFocus();
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Mod note',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        focusNode: noteFocusNode,
                        controller: noteController,
                        style: const TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          contentPadding: const EdgeInsets.all(15),
                          hintText:
                              'For other mods to know why this user is muted',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          noteFocusNode.unfocus();
                          reasonFocusNode.requestFocus();
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Banned Reason',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        focusNode: reasonFocusNode,
                        controller: reasonController,
                        style: const TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Reason for bannig this user',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          reasonFocusNode.unfocus();
                          dayFocusNode.requestFocus();
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text("How Long?"),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 20,
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: dayController,
                              focusNode: dayFocusNode,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 15),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                dayFocusNode.unfocus();
                                msgFocusNode.requestFocus();
                              },
                            ),
                          ),
                          const Text(
                            "Days",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text("Note to inclue in ban message"),
                      const SizedBox(height: 10),
                      TextField(
                        focusNode: msgFocusNode,
                        controller: msgController,
                        style: const TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Note to include in ban message',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          Navigator.pop(context);
                          BlocProvider.of<ModtoolsCubit>(context).banUser(
                            widget.subredditId,
                            usernameController.text,
                            reasonController.text,
                            int.tryParse(dayController.text) ?? 1,
                            noteController.text,
                            msgController.text,
                            false,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 60,
                        color: defaultThirdColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 25),
                                  side: const BorderSide(
                                      width: 1, color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                BlocProvider.of<ModtoolsCubit>(context).banUser(
                                  widget.subredditId,
                                  usernameController.text,
                                  reasonController.text,
                                  int.tryParse(dayController.text) ?? 1,
                                  noteController.text,
                                  msgController.text,
                                  false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 25),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: const Text(
                                "Ban user",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _addMutted(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: defaultSecondaryColor,
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add to muted users',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
              ],
            ),
            content: SizedBox(
              height: 300,
              width: 500,
              // child: Column(
              //   children: [
              //     Container(
              //         width: 420,
              //         padding: const EdgeInsets.all(8.0),
              //         child: TextField(
              //           controller: moderatorController,
              //           decoration: const InputDecoration(
              //             border: OutlineInputBorder(),
              //             labelText: 'Enter username',
              //           ),
              //         )),
              //     const SizedBox(height: 10),
              //     Container(
              //       width: double.infinity,
              //       height: 60,
              //       color: defaultThirdColor,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           OutlinedButton(
              //             onPressed: () => Navigator.pop(context),
              //             style: OutlinedButton.styleFrom(
              //                 padding: const EdgeInsets.symmetric(
              //                     vertical: 15, horizontal: 25),
              //                 side: const BorderSide(
              //                     width: 1, color: Colors.white),
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(25))),
              //             child: const Text(
              //               "Cancel",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           const SizedBox(width: 10),
              //           ElevatedButton(
              //             onPressed: () {
              //               Navigator.pop(context);
              //               BlocProvider.of<ModtoolsCubit>(context)
              //                   .addModerator(widget.subredditId,
              //                       moderatorController.text);
              //             },
              //             style: ElevatedButton.styleFrom(
              //                 backgroundColor: Colors.white,
              //                 padding: const EdgeInsets.symmetric(
              //                     vertical: 15, horizontal: 25),
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(25))),
              //             child: const Text(
              //               "Add moderator",
              //               style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //           const SizedBox(width: 20),
              //         ],
              //       ),
              //     )
              //   ],
              // ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text('Username', style: TextStyle(fontSize: 17)),
                    const SizedBox(height: 10),
                    TextField(
                      focusNode: usernameMutedFocusNode,
                      controller: usernameMuteController,
                      style: const TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixText: 'u/',
                        prefixStyle:
                            const TextStyle(color: Colors.white, fontSize: 19),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3)),
                        contentPadding: const EdgeInsets.all(15),
                        hintText: 'username',
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        reasonMutedFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Mod note about why they were muted',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const Text(
                      'Not Visiable to the user',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      focusNode: reasonMutedFocusNode,
                      controller: reasonMuteController,
                      style: const TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3)),
                        contentPadding: const EdgeInsets.all(15),
                        hintText:
                            'For other mods to know why this user is muted',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        Navigator.pop(context);
                        BlocProvider.of<ModtoolsCubit>(context).muteUser(
                          widget.subredditId,
                          usernameMuteController.text,
                          reasonMuteController.text,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: defaultThirdColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              BlocProvider.of<ModtoolsCubit>(context).muteUser(
                                widget.subredditId,
                                usernameMuteController.text,
                                reasonMuteController.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            child: const Text(
                              "Add to muted",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    addButtonName = widget.screen == 'Approved'
        ? 'Approve user'
        : widget.screen == 'Moderators'
            ? 'Add moderator'
            : widget.screen == 'Banned'
                ? 'Ban user'
                : 'Mute user';
    return Column(
      children: [
        Container(
          color: defaultThirdColor,
          width: MediaQuery.of(context).size.width - 280,
          height: 50,
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width - 500, 8, 30, 8),
          child: ElevatedButton(
            onPressed: () {
              if (widget.screen == 'Approved') {
                _addApproved(context);
              } else if (widget.screen == 'Moderators') {
                _addModerator(context);
              } else if (widget.screen == 'Banned') {
                _addBanned(context);
              } else {
                _addMutted(context);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.8),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            child: Text(
              addButtonName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${widget.screen} ',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Icon(Icons.info_outline)
                ],
              ),
              const SizedBox(height: 10),
              // emptyUserManagement(context),
              userManagementList(context)
            ],
          ),
        ),
      ],
    );
  }
}
