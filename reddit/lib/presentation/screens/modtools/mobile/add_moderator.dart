import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';

class AddModeratorScreen extends StatefulWidget {
  final String subredditId;
  const AddModeratorScreen({super.key, required this.subredditId});

  @override
  State<AddModeratorScreen> createState() => _AddModeratorScreenState();
}

class _AddModeratorScreenState extends State<AddModeratorScreen> {
  TextEditingController usernameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultSecondaryColor,
          leading: const CloseButton(),
          centerTitle: true,
          title: const Text('Add a moderator'),
          actions: [
            TextButton(
                onPressed: () {
                  BlocProvider.of<ModtoolsCubit>(context).addModerator(
                      widget.subredditId, usernameController.text);
                },
                child: const Text('ADD',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)))
          ]),
      body: BlocListener<ModtoolsCubit, ModtoolsState>(
        listener: (context, state) {
          if (state is AddedToModerators) {
            if (state.statusCode == 400) {
              displayMsg(context, Colors.red,
                  ' This user is already a moderator or the username is not valid');
            }
          } else {
            displayMsg(context, Colors.green,
                ' ${usernameController.text} becomes a moderator');
            usernameController.text = '';
            Navigator.pop(context);
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
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  BlocProvider.of<ModtoolsCubit>(context).addModerator(
                      widget.subredditId, usernameController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
