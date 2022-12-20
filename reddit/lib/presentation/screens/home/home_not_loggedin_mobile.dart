import 'package:flutter/material.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';

class HomeNotLoggedIn extends StatelessWidget {
  const HomeNotLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: defaultWebBackgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 60,
                child: Image.asset('assets/images/welcome1.jpg'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Welcome!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 200,
                      child: Text(
                          'There\'s a Reddit community for everty topic imaginable',
                          style: TextStyle(fontSize: 17)),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 60,
                child: Image.asset('assets/images/welcome2.jpg'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Vote',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 200,
                      child: Text(
                          'on posts and help communities lift the best content to the top!',
                          style: TextStyle(fontSize: 17)),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 60,
                child: Image.asset('assets/images/welcome3.jpg'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Join',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 200,
                      child: Text(
                          'communities to fill this home feed with fresh posts',
                          style: TextStyle(fontSize: 17)),
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, signupScreen),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          // padding: const EdgeInsets.symmetric(
                          //     vertical: 10, horizontal: 130),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, loginScreen),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: defaultWebBackgroundColor,
                          // padding: const EdgeInsets.symmetric(
                          //     vertical: 10, horizontal: 130),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
