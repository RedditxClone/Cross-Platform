import 'package:flutter/material.dart';

//for testing and will be deleted
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapRoute = (ModalRoute.of(context)?.settings.arguments ??
        {
          "reference": "null",
          "status": "null",
        }) as Map<String, Object>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(child: Text('${mapRoute['reference']}')),
    );
  }
}
