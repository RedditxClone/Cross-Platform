
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Column(children: [
        TextButton(
            onPressed: () => Navigator.of(context).pushNamed('/emailSettings'),
            child: const Text("email settings"))
      ]),
    );
  }
}
