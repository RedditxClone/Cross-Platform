import 'package:flutter/material.dart';
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
  User otherUser = User.fromJson({
    "userId": '1',
    "username": 'bemoi_erian',
    "displayName": 'Bemoi_01  ',
    "email": 'bemoi@hotmail.com',
    "profilePic": '',
  });
  String addButtonName = '';

  Widget emptyUserManagement(context) {
    return Container(
        height: 300,
        width: MediaQuery.of(context).size.width - 320,
        color: defaultSecondaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.speaker_notes_off_outlined, color: Colors.grey),
              SizedBox(height: 30),
              Text('No muted users in r/redditx_',
                  style: TextStyle(fontSize: 17, color: Colors.grey)),
            ],
          ),
        ));
  }

  Widget listviewItem(context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 0.3, color: Colors.grey),
        ),
        color: defaultSecondaryColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            hoverColor: defaultThirdColor,
            onTap: () => Navigator.pushNamed(context, otherProfilePageRoute,
                arguments: otherUser), // TODO : Navigate to other user profile
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(children: [
                CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.grey,
                    child: UserData.user == null ||
                            UserData.user!.profilePic == null ||
                            UserData.user!.profilePic == ''
                        ? const Icon(Icons.person)
                        : Image.network(UserData.user!.profilePic!,
                            fit: BoxFit.cover)),
                const SizedBox(width: 10),
                const Text('user_name'),
              ]),
            ),
          ),
        ),
        const SizedBox(width: 148),
        const Text('2 months ago',
            style: TextStyle(fontSize: 13, color: Colors.grey)),
        SizedBox(width: MediaQuery.of(context).size.width - 880),
        InkWell(
            onTap: () => () {},
            child: const Text('Send message',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        const SizedBox(width: 20),
        InkWell(
            onTap: () => () {},
            child: const Text('Remove',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
      ]),
    );
  }

  Widget userManagementList(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 230,
      width: MediaQuery.of(context).size.width - 320,
      child: ListView(
        children: [
          listviewItem(context),
          listviewItem(context),
          listviewItem(context),
          listviewItem(context),
          listviewItem(context),
          listviewItem(context),
          listviewItem(context),
        ],
      ),
    );
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
                        controller: null,
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
                          onPressed: () {}, // TODO : add user reques
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
