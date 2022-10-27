import 'dart:ui' as ui;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';

class RecaptchaScreen extends StatefulWidget {
  const RecaptchaScreen({Key? key}) : super(key: key);

  @override
  State<RecaptchaScreen> createState() => _RecaptchaScreenState();
}

class _RecaptchaScreenState extends State<RecaptchaScreen> {
  String createdViewId = 'map_element';
  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      createdViewId,
      (int viewId) => html.IFrameElement()
        ..style.height = '100%'
        ..style.width = '100%'
        ..src = 'assets/webpages/recaptcha.html'
        ..style.border = 'none',
    );
    html.window.onMessage.listen((msg) {
      // Replace the route here with the route you wish to go
      Navigator.pushReplacementNamed(context, '/');
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HtmlElementView(
          viewType: createdViewId,
        ),
      ),
    );
  }
}
