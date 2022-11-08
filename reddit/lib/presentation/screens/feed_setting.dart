import 'package:flutter/material.dart';

class FeedSetting extends StatefulWidget {
  const FeedSetting({super.key});
  @override
  State<StatefulWidget> createState() => FeedSettingState();
}

class FeedSettingState extends State<FeedSetting> {
  bool _isActiveAdultContent = false;
  bool _isActiveAutoplayMedia = false;

  var whiteColor = Colors.white;
  var blackColor = Colors.black;
  var lightGrayColor0 = const Color.fromARGB(255, 207, 201, 201);
  var lightGrayColor1 = const Color.fromARGB(255, 125, 124, 124);
  var darkGrayColor = const Color.fromARGB(255, 34, 33, 33);

  late var trackColor = lightGrayColor0;

  late var titleColor = blackColor;

  late var subTitleColor = lightGrayColor1;

  late var backgroundColor = whiteColor;

  void switchMode() {
    if (backgroundColor == blackColor) {
      ///Light Mode
      titleColor = blackColor;
      subTitleColor = lightGrayColor1;
      backgroundColor = whiteColor;
      trackColor = lightGrayColor0;
    } else {
      ///Dark Mode
      titleColor = whiteColor;
      subTitleColor = lightGrayColor1;
      backgroundColor = blackColor;
      trackColor = darkGrayColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ///For testing switching between modes only.
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //     switchMode();
      //   }),
      // ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(150, 40, 600, 200),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Text(
                "Feed settings",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .merge(TextStyle(color: titleColor)),
              ),
            ),
            Text(
              "CONTENT PREFERENCES",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .merge(TextStyle(color: subTitleColor)),
            ),
            const Divider(),
            SwitchListTile(
              inactiveTrackColor: trackColor,
              title: Text(
                "Adult content",
                style: TextStyle(color: titleColor),
              ),
              subtitle: Text(
                "Enable to view adult and NSFW (not safe for work) content in your feed and search results.",
                style: TextStyle(color: subTitleColor),
              ),
              isThreeLine: true,
              value: _isActiveAdultContent,
              onChanged: (value) {
                setState(() {
                  _isActiveAdultContent = value;
                });
              },
            ),
            SwitchListTile(
              inactiveTrackColor: trackColor,
              title: Text(
                "Autoplay media",
                style: TextStyle(color: titleColor),
              ),
              subtitle: Text(
                "Play videos and gifs automatically when in the viewport.",
                style: TextStyle(color: subTitleColor),
              ),
              isThreeLine: true,
              value: _isActiveAutoplayMedia,
              onChanged: (value) {
                setState(() {
                  _isActiveAutoplayMedia = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
