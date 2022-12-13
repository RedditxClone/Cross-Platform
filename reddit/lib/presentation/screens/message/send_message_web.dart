import 'package:flutter/material.dart';
import 'package:reddit/constants/colors.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/presentation/widgets/messages/message_tab_bar.dart';
import 'package:reddit/presentation/widgets/nav_bars/app_bar_web_loggedin.dart';

class SendMessageWeb extends StatelessWidget {
  SendMessageWeb({super.key});
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

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
      ],
    );
  }

  Widget _sendMessageButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: const Text(
          "Send",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
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
            width: MediaQuery.of(context).size.width - 700,
            decoration: BoxDecoration(
              color: cardsColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------- Display Name--------------

                _textField('from', fromController),
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
      body: Column(
        children: [
          MessagesTabBar(index: 0),
          _sendMessageBody(context),
        ],
      ),
    );
  }
}
