import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';

class UserManagement extends StatefulWidget {
  String screen = '';

  UserManagement({required this.screen, super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  String addButtonName = '';
  TextEditingController addApprovedUserController = TextEditingController();
  List<User>? approvedUsers;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ModtoolsCubit>(context)
        .getApprovedUsers('639b27bbef88b3df0463d04b');
  }

  Widget emptyUserManagement(context) {
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width - 320,
        color: defaultSecondaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.speaker_notes_off_outlined, color: Colors.grey),
              SizedBox(height: 30),
              Text('No approved users in r/redditx_',
                  style: TextStyle(fontSize: 17, color: Colors.grey)),
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
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Widget listviewItem(context, index) {
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
                arguments: approvedUsers![index].username),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                Text(approvedUsers![index].username),
              ]),
            ),
          ),
        ),
        const SizedBox(width: 148),
        const Text('2 months ago',
            style: TextStyle(fontSize: 13, color: Colors.grey)),
        SizedBox(
            width: MediaQuery.of(context).size.width - 880 > 0
                ? MediaQuery.of(context).size.width - 880
                : 0),
        InkWell(
            onTap: () => Navigator.pushNamed(context, sendMessageRoute,
                arguments: approvedUsers![index].username),
            child: const Text('Send message',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        const SizedBox(width: 20),
        InkWell(
            onTap: () => BlocProvider.of<ModtoolsCubit>(context)
                .removeApprovedUser(
                    '639b27bbef88b3df0463d04b', approvedUsers![index].username),
            child: const Text('Remove',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
      ]),
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
          },
          child: BlocBuilder<ModtoolsCubit, ModtoolsState>(
            builder: (context, state) {
              if (state is ApprovedListAvailable) {
                approvedUsers = state.approved;
                if (approvedUsers!.isEmpty) {
                  return emptyUserManagement(context);
                }
                return ListView.builder(
                    itemCount: approvedUsers!.length,
                    itemBuilder: (context, index) {
                      return listviewItem(context, index);
                    });
              }
              if (state is AddedToApprovedUsers) {
                approvedUsers = state.approved;
                addApprovedUserController.text = '';
                return ListView.builder(
                    itemCount: approvedUsers!.length,
                    itemBuilder: (context, index) {
                      return listviewItem(context, index);
                    });
              }
              if (state is RemovedFromApprovedUsers) {
                approvedUsers = state.approved;
                if (approvedUsers!.isEmpty) {
                  return emptyUserManagement(context);
                }
                return ListView.builder(
                    itemCount: approvedUsers!.length,
                    itemBuilder: (context, index) {
                      return listviewItem(context, index);
                    });
              }
              return emptyUserManagement(context);
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
                                .addApprovedUser('639b27bbef88b3df0463d04b',
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

  @override
  Widget build(BuildContext context) {
    addButtonName = widget.screen == 'Approved' ? 'Approve user' : '';
    return Column(
      children: [
        Container(
          color: defaultThirdColor,
          width: MediaQuery.of(context).size.width - 280,
          height: 50,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width - 450, 8, 30, 8),
            child: ElevatedButton(
              onPressed: () => _addApproved(context),
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
