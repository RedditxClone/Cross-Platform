import 'package:flutter/material.dart';

class FeedSetting extends StatefulWidget {
  const FeedSetting({super.key});
  @override
  State<StatefulWidget> createState() => FeedSettingState();
}

class FeedSettingState extends State<FeedSetting> {
  bool _isActiveAdultContent = false;
  bool _isActiveAutoplayMedia = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(150, 40, 600, 200),
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Text(
                "Feed settings",
                style: Theme.of(context).textTheme.headline5!,
              ),
            ),
            Text(
              "CONTENT PREFERENCES",
              style: Theme.of(context).textTheme.caption!,
            ),
            const Divider(),
            SwitchListTile(
              inactiveTrackColor: Colors.grey.shade400,
              title: const Text("Adult content"),
              subtitle: const Text(
                  "Enable to view adult and NSFW (not safe for work) content in your feed and search results."),
              isThreeLine: true,
              value: _isActiveAdultContent,
              onChanged: (value) {
                setState(() {
                  _isActiveAdultContent = value;
                });
              },
            ),
            SwitchListTile(
              inactiveTrackColor: Colors.grey.shade400,
              title: const Text("Autoplay media"),
              subtitle: const Text(
                  "Play videos and gifs automatically when in the viewport."),
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
