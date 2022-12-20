import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';

class BanUserScreen extends StatefulWidget {
  final String subredditId;
  const BanUserScreen({super.key, required this.subredditId});

  @override
  State<BanUserScreen> createState() => _BanUserScreenState();
}

class _BanUserScreenState extends State<BanUserScreen> {
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
  bool isPermanent = false;

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
                style: TextStyle(
                    fontSize: title.length > 20 ? 9 : 16, color: Colors.white),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultSecondaryColor,
          leading: const CloseButton(),
          centerTitle: true,
          title: const Text('Add a banned user'),
          actions: [
            TextButton(
                onPressed: () {
                  BlocProvider.of<ModtoolsCubit>(context).banUser(
                    widget.subredditId,
                    usernameController.text,
                    reasonController.text,
                    isPermanent ? 0 : int.tryParse(dayController.text) ?? 0,
                    noteController.text,
                    msgController.text,
                    isPermanent,
                  );
                },
                child: const Text('ADD',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)))
          ]),
      body: BlocListener<ModtoolsCubit, ModtoolsState>(
        listener: (context, state) {
          if (state is BanUser) {
            if (state.statusCode == 400) {
              displayMsg(context, Colors.red,
                  'This user is already banned or the username is not valid');
            } else {
              displayMsg(context, Colors.green,
                  ' ${usernameController.text} is banned');
              usernameController.text = '';
              reasonController.text = '';
              BlocProvider.of<ModtoolsCubit>(context)
                  .getBannedUsers(widget.subredditId);
              Navigator.pop(context);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                  prefixStyle:
                      const TextStyle(color: Colors.white, fontSize: 19),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'username',
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  reasonFocusNode.requestFocus();
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
                  hintText: 'For other mods to know why this user is muted',
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
                  const Text("Days"),
                  Checkbox(
                    value: isPermanent,
                    onChanged: (value) {
                      setState(() {
                        isPermanent = value ?? false;
                        if (isPermanent) {
                          dayController.text = '';
                          dayFocusNode.unfocus();
                        }
                      });
                    },
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
                  BlocProvider.of<ModtoolsCubit>(context).banUser(
                    widget.subredditId,
                    usernameController.text,
                    reasonController.text,
                    isPermanent ? 0 : int.tryParse(dayController.text) ?? 0,
                    noteController.text,
                    msgController.text,
                    isPermanent,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
