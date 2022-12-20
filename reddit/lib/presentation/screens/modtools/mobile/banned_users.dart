import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../business_logic/cubit/modtools/modtools_cubit.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/strings.dart';
import '../../../../constants/theme_colors.dart';
import '../../../../data/model/auth_model.dart';

class BannedUsersScreen extends StatefulWidget {
  final String subredditId;
  final String subredditName;
  const BannedUsersScreen(
      {super.key, required this.subredditId, required this.subredditName});

  @override
  State<BannedUsersScreen> createState() => _BannedUsersScreenState();
}

class _BannedUsersScreenState extends State<BannedUsersScreen> {
  List<User>? bannedUsers;

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

  Widget listviewItem(context, index) {
    Duration date =
        DateTime.now().difference(DateTime.parse(bannedUsers![index].date));
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      // decoration: BoxDecoration(
      //   // color: textFeildColor,
      //   borderRadius: BorderRadius.circular(20),
      // ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, otherProfilePageRoute,
            arguments: bannedUsers![index].username),
        child: Row(children: [
          bannedUsers![index].profilePic == null ||
                  bannedUsers![index].profilePic == ''
              ? const CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person))
              : CircleAvatar(
                  radius: 17,
                  backgroundImage:
                      NetworkImage(bannedUsers![index].profilePic!)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('u/${bannedUsers![index].username}'),
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
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ModtoolsCubit>(context).getBannedUsers(widget.subredditId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultSecondaryColor,
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Banned Users'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, addBannedUserRoute,
                      arguments: {
                        'id': widget.subredditId,
                        'name': widget.subredditName
                      }),
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<ModtoolsCubit, ModtoolsState>(
        builder: (context, state) {
          if (state is BannedListAvailable) {
            bannedUsers = state.bannedUsers;
            if (bannedUsers!.isEmpty) {
              return const Center(
                child: Text('No Banned users found'),
              );
            }
            return ListView.builder(
                itemCount: bannedUsers!.length,
                itemBuilder: (context, index) {
                  return listviewItem(context, index);
                });
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
