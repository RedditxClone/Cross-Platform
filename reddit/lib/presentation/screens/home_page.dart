
import 'package:flutter/material.dart';
import 'package:reddit/data/web_services/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DioHelper.init();
  }

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
