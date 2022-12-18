import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';

class AddApprovedUserScreen extends StatelessWidget {
  AddApprovedUserScreen({super.key});
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultSecondaryColor,
          leading: const CloseButton(),
          centerTitle: true,
          title: const Text('Add and aprooved user'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  BlocProvider.of<ModtoolsCubit>(context).addApprovedUser(
                      '639b27bbef88b3df0463d04b', usernameController.text);
                  usernameController.text = '';
                },
                child: const Text('ADD',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)))
          ]),
      body: Padding(
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
                )),
            const SizedBox(height: 10),
            const Text(
                'This user will be able to submit content to your community',
                style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
