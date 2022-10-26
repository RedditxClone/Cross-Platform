import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class RecaptchaScreen extends StatefulWidget {
  const RecaptchaScreen({Key? key}) : super(key: key);

  @override
  State<RecaptchaScreen> createState() => _RecaptchaScreenState();
}

class _RecaptchaScreenState extends State<RecaptchaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.loadUrl('assets/webpages/recaptcha.html');
        },
        javascriptChannels: {
          JavascriptChannel(
              name: "Captcha",
              onMessageReceived: (JavascriptMessage msg) {
                Navigator.pushReplacementNamed(context, '/');
              })
        },
      ),
    );
  }
}
