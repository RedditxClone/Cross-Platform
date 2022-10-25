import 'package:dartdoc/dartdoc.dart';
import 'package:flutter/material.dart';

class ProfileSetting {
  void openBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height -
                MediaQuery.of(ctx).padding.top),
        context: ctx,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              leading: const CloseButton(),
              centerTitle: true,
              title: const Text("Edit Profile"),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Text("Save", style: TextStyle(fontSize: 20)))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TextButton(onPressed: () {}, child: Text("")),
                ],
              ),
            ),
          );
        });
  }
}
