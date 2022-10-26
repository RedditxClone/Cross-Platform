import 'package:flutter/material.dart';
import 'package:reddit/presentation/screens/profile_settings.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
          onPressed: () => ProfileSetting(),
          child: const Text("Profile Settings")),
    );
  }
}
