import 'package:flutter/material.dart';
import 'package:reddit/data/web_services/authorization/login_conroller.dart';

import '../../data/model/signin.dart';

//for testing and will be deleted
class Home extends StatefulWidget {
  const Home({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Home> createState() => _HomeState(user);
}

class _HomeState extends State<Home> {
  final User user;

  _HomeState(this.user);
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
              backgroundImage:
                  user.imageUrl != null ? NetworkImage(user.imageUrl!) : null,
              radius: 100,
            ),
            Text(
              user.name!=null?user.name!:"null",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   widget.user.email,
            //   style: const TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            ElevatedButton(
              onPressed: () async {
                var res = await GoogleSingInApi.signoutWeb();
                if (res == null) {
                  Navigator.of(context).pushReplacementNamed('/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error in Signing in with Google"),
                    ),
                  );
                }
              },
              child: const Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
