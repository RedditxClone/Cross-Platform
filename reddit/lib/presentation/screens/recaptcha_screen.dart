import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

// Display reCaptcha screen
class RecaptchaScreen extends StatefulWidget {
  const RecaptchaScreen({Key? key}) : super(key: key);

  @override
  State<RecaptchaScreen> createState() => _RecaptchaScreenState();
}

class _RecaptchaScreenState extends State<RecaptchaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Library to display local html file on mobile
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.loadUrl('assets/webpages/recaptcha.html');
        },

        /// To receive recaptcha response
        /// Receiving response from recaptcha means that you are authorized
        javascriptChannels: {
          JavascriptChannel(
              name: "Captcha",
              onMessageReceived: (JavascriptMessage msg) {
                // Replace the route here with the route you wish to go
                Navigator.pushReplacementNamed(context, '/');
              })
        },
      ),
    );
  }
}
