import 'package:flutter/material.dart';
import 'package:reddit/constants/country_names.dart';

class CountryScreen extends StatelessWidget {
  late String _countryCode;
  final Object? _arguments;
  CountryScreen(this._arguments, {Key? key}) : super(key: key) {
    Map<String, String> argMap = _arguments as Map<String, String>;
    _countryCode = argMap["code"] ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text("Country"),
        centerTitle: true,
      ),
      // TODO: body
      body: ListView(
        children: [
          ...countryNamesMap
              .map(
                (e) => Card(
                  color: Colors.grey.shade900,
                  child: ListTile(
                    leading: _countryCode == e["code"]!
                        ? const Icon(Icons.check_circle)
                        : const Icon(Icons.circle_outlined),
                    title: Text(e["name"]!),
                    onTap: () {
                      Navigator.pop(context, e["code"]!);
                    },
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
