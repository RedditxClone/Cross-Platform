import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';

class EmptyUserManagement extends StatelessWidget {
  String screen = '';
  EmptyUserManagement({required this.screen, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '$screen ',
                  style: const TextStyle(fontSize: 18),
                ),
                const Icon(Icons.info_outline)
              ],
            ),
            const SizedBox(height: 10),
            Container(
                height: 300,
                width: MediaQuery.of(context).size.width - 320,
                color: defaultSecondaryColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.speaker_notes_off_outlined,
                          color: Colors.grey),
                      SizedBox(height: 30),
                      Text('No muted users in r/redditx_',
                          style: TextStyle(fontSize: 17, color: Colors.grey)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
