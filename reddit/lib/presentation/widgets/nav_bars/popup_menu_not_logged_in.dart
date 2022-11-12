import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PopupMenuNotLoggedIn extends StatelessWidget {
  const PopupMenuNotLoggedIn({Key? key}) : super(key: key);
  Future<void> _launchUrl(String link) async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry> optionsList = [
      PopupMenuItem(
          value: 0,
          child: Row(
            children: const [
              SizedBox(width: 10),
              Icon(Icons.help_outline_sharp),
              SizedBox(width: 10),
              Text(
                'Help center',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
      const PopupMenuDivider(),
      PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              SizedBox(width: 10),
              Icon(Icons.login),
              SizedBox(width: 10),
              Text(
                'Log In/Sign Up',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
    ];
    return PopupMenuButton(
      color: defaultSecondaryColor,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(0),
      offset: Offset.fromDirection(0, 150),
      position: PopupMenuPosition.under,
      itemBuilder: (_) => optionsList,
      constraints: const BoxConstraints.expand(width: 200, height: 130),
      onSelected: (value) {
        switch (value) {
          case 0:
            _launchUrl('https://www.reddithelp.com/hc/en-us');
            break;
          case 1:
            Navigator.pushNamed(context, loginPage);
            break;
          default:
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.1))),
        child: Row(
          children: const [
            Icon(
              Icons.person,
              size: 30,
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_downward),
          ],
        ),
      ),
    );
  }
}
