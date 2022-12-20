import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/presentation/widgets/posts/posts_web.dart';

class QueuesWidget extends StatefulWidget {
  String screen = '';
  QueuesWidget({required this.screen, super.key});

  @override
  State<QueuesWidget> createState() => _QueuesWidgetState();
}

class _QueuesWidgetState extends State<QueuesWidget> {
  Widget queue() {
    return SizedBox(
      width: 700,
      child: PostsWeb(),
    );
  }

  Widget emptyQueue() {
    return Container(
        width: 700,
        height: 450,
        color: defaultSecondaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Images/kitteh.png'),
              const Text('The queue is clean!', style: TextStyle(fontSize: 17)),
              const SizedBox(height: 10),
              const Text('Kitteh is pleased',
                  style: TextStyle(fontSize: 14, color: Colors.grey))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width - 1250 > 15
                    ? MediaQuery.of(context).size.width - 1250
                    : 15),
            Container(
              width: 700,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${widget.screen} ',
                            style: TextStyle(fontSize: 18),
                          ),
                          const Icon(Icons.info_outline)
                        ],
                      ),
                      CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.grey,
                          child: UserData.user == null ||
                                  UserData.user!.profilePic == null ||
                                  UserData.user!.profilePic == ''
                              ? const Icon(Icons.person)
                              : Image.network(UserData.user!.profilePic!,
                                  fit: BoxFit.cover)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: const [
                      Text('NEWEST FIRST', style: TextStyle(fontSize: 12)),
                      SizedBox(width: 30),
                      Text('POSTS AND COMMENTS',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  emptyQueue(),
                  //queue(),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 1220 > 0
                    ? MediaQuery.of(context).size.width - 1220
                    : 0),
          ],
        ),
      ),
    );
  }
}
