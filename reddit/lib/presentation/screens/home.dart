import 'package:flutter/material.dart';
import 'package:reddit/presentation/screens/signup_screen.dart';

//for testing and will be deleted
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SignupMobile()
    );
  }
}
