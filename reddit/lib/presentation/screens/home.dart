import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//for testing and will be deleted
class Home extends StatelessWidget {
  const Home({Key? key, required this.googleSignInAccount}) : super(key: key);
  final GoogleSignInAccount googleSignInAccount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
          child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(googleSignInAccount.photoUrl!),
            radius: 100, 
          ),
          Text(
            '${googleSignInAccount.displayName}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            googleSignInAccount.email,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
    );
  }
}
