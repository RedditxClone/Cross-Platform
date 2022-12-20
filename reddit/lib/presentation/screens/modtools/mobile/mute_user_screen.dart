import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';

class MuteUserScreen extends StatefulWidget {
  final String subredditId;
  const MuteUserScreen({super.key, required this.subredditId});

  @override
  State<MuteUserScreen> createState() => _MuteUserScreenState();
}

class _MuteUserScreenState extends State<MuteUserScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode reasonFocusNode = FocusNode();

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
          title: const Text('Add a muted user'),
          actions: [
            TextButton(
                onPressed: () {
                  BlocProvider.of<ModtoolsCubit>(context).muteUser(
                      widget.subredditId,
                      usernameController.text,
                      reasonController.text);
                },
                child: const Text('ADD',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)))
          ]),
      body: BlocListener<ModtoolsCubit, ModtoolsState>(
        listener: (context, state) {
          if (state is MuteUser) {
            if (state.statusCode == 400) {
              displayMsg(context, Colors.red,
                  'This user is already muted or the username is not valid');
            } else {
              displayMsg(context, Colors.green,
                  ' ${usernameController.text} becomes a moderator');
              usernameController.text = '';
              BlocProvider.of<ModtoolsCubit>(context)
                  .getModerators(widget.subredditId);
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
                focusNode: reasonFocusNode,
                controller: reasonController,
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
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  BlocProvider.of<ModtoolsCubit>(context).muteUser(
                      widget.subredditId,
                      usernameController.text,
                      reasonController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
