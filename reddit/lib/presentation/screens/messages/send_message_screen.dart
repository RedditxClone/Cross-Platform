import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/messages/messages_cubit.dart';
import 'package:reddit/data/model/auth_model.dart';

class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({super.key});

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  User? otherUser;
  TextEditingController subjectController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  Widget _buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'u/ ${otherUser!.username}',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        // title: const Text('Edit Profile'),
        actions: [
          TextButton(
              onPressed: () {
                () => BlocProvider.of<MessagesCubit>(context).sendMessage(
                    subjectController.text,
                    messageController.text,
                    otherUser!.username??"");
              },
              child: const Text('Send', style: TextStyle(fontSize: 20)))
        ],
      ),
      body: BlocListener<MessagesCubit, MessagesState>(
        listener: (context, state) {},
        child: _buildBody(),
      ),
    );
  }
}
