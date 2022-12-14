import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/messages/messages_cubit.dart';
import 'package:reddit/constants/colors.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/presentation/widgets/messages/message_tab_bar.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class SendMessageWeb extends StatefulWidget {
  final String username;
  const SendMessageWeb({required this.username, super.key});

  @override
  State<SendMessageWeb> createState() => _SendMessageWebState();
}

class _SendMessageWebState extends State<SendMessageWeb> {
  TextEditingController fromController = TextEditingController();

  TextEditingController toController = TextEditingController();

  TextEditingController subjectController = TextEditingController();

  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    toController.text = widget.username;
  }

  Widget _title(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(title, style: const TextStyle(fontSize: 17)),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _textField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(title),
        TextField(
            onEditingComplete: () {},
            controller: controller,
            maxLines: controller == messageController ? 6 : 1,
            style: const TextStyle(fontSize: 16),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
              contentPadding: const EdgeInsets.all(15),
            )),
        const SizedBox(height: 5),
        title == 'to'
            ? BlocBuilder<MessagesCubit, MessagesState>(
                builder: (context, state) {
                if (state is EmptyUsername) {
                  return const Text('please enter a username',
                      style: TextStyle(color: Colors.red));
                } else if (state is NoSuchUser) {
                  return const Text('That user is invalid',
                      style: TextStyle(color: Colors.red));
                }
                return const SizedBox(width: 0);
              })
            : title == 'subject'
                ? BlocBuilder<MessagesCubit, MessagesState>(
                    builder: (context, state) {
                    if (state is EmptySubject) {
                      return const Text('please enter a subject',
                          style: TextStyle(color: Colors.red));
                    }
                    return const SizedBox(width: 0);
                  })
                : const SizedBox(width: 0)
      ],
    );
  }

  Widget _sendMessageButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            onPressed: () => BlocProvider.of<MessagesCubit>(context)
                .sendMessage(subjectController.text, messageController.text,
                    toController.text),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: const Text(
              "Send",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 20),
        BlocBuilder<MessagesCubit, MessagesState>(builder: (context, state) {
          if (state is MessageSent) {
            subjectController.text = '';
            messageController.text = '';
            toController.text = '';
            return const Text('your message has been delivered',
                style: TextStyle(color: Colors.white));
          }
          return const SizedBox(width: 0);
        })
      ],
    );
  }

  Widget _sendMessageBody(context) {
    fromController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width - 1200 > 0
                  ? MediaQuery.of(context).size.width - 1200
                  : 0),
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width - 1200 > 0
                ? 800
                : MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: cardsColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------- Display Name--------------

                // _textField('from', fromController),
                _textField('to', toController),
                _textField('subject', subjectController),
                _textField('message', messageController),
                _sendMessageButton(),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 1200 > 0
                  ? MediaQuery.of(context).size.width - 1200
                  : 0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          automaticallyImplyLeading: false,
          backgroundColor: defaultAppbarBackgroundColor,
          title: const AppBarWebLoggedIn(screen: 'Messages')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MessagesTabBar(index: 0),
            _sendMessageBody(context),
          ],
        ),
      ),
    );
  }
}
