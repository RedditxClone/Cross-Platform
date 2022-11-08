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
      // ///For testing switching between modes only.
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //     switchMode();
      //   }),
      // ),
      backgroundColor: Colors.black,
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
                    .merge(const TextStyle(color: Colors.white)),
              ),
            ),
            Text(
              "CONTENT PREFERENCES",
              style: Theme.of(context).textTheme.caption!.merge(
                  const TextStyle(color: Color.fromARGB(255, 125, 124, 124))),
            ),
            const Divider(),
            SwitchListTile(
              inactiveTrackColor: const Color.fromARGB(255, 34, 33, 33),
              title: const Text(
                "Adult content",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                "Enable to view adult and NSFW (not safe for work) content in your feed and search results.",
                style: TextStyle(color: Color.fromARGB(255, 125, 124, 124)),
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
              inactiveTrackColor: const Color.fromARGB(255, 34, 33, 33),
              title: const Text(
                "Autoplay media",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                "Play videos and gifs automatically when in the viewport.",
                style: TextStyle(color: Color.fromARGB(255, 125, 124, 124)),
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
