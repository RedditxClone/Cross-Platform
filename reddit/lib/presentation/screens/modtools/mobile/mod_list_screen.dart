import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';

class ModListScreen extends StatelessWidget {
  final String subredditName;
  final String subredditId;
  const ModListScreen(
      {super.key, required this.subredditName, required this.subredditId});

  Widget title(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget listItem(IconData icon, String title, Function func) {
    return Container(
        height: 50,
        color: defaultSecondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Icon(icon, color: Colors.grey),
                const SizedBox(width: 10),
                Text(title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
            Row(children: [
              IconButton(
                  onPressed: () {
                    func();
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                    size: 25,
                  )),
              SizedBox(width: 15),
            ]),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultSecondaryColor,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                  subredditPageScreenRoute,
                  arguments: <String, dynamic>{'sId': subredditId});
            },
          ),
          centerTitle: true,
          title: const Text('Mod tools')),
      body: ListView(
        children: [
          title('GENERAL'),
          listItem(Icons.create_outlined, 'Description', () {}),
          title('CONTENT & REGULATION'),
          listItem(Icons.queue_outlined, 'Mod queue', () {}),
          title('USER MANAGEMENT'),
          listItem(
              Icons.shield_outlined,
              'Moderators',
              () => Navigator.of(context).pushNamed(moderatorsRoute,
                  arguments: {'name': subredditName, 'id': subredditId})),
          listItem(
              Icons.mic_external_on_outlined,
              'Approved users',
              () => Navigator.of(context).pushNamed(approvedRoute,
                  arguments: {'name': subredditName, 'id': subredditId})),
          listItem(
              Icons.speaker_notes_off_outlined,
              'Muted users',
              () => Navigator.of(context).pushNamed(mutedUsersRoute,
                  arguments: {'name': subredditName, 'id': subredditId})),
          listItem(
              Icons.remove_circle_outline_outlined,
              'Banned users',
              () => Navigator.of(context).pushNamed(bannedUsersRoute,
                  arguments: {'name': subredditName, 'id': subredditId})),
        ],
      ),
    );
  }
}
