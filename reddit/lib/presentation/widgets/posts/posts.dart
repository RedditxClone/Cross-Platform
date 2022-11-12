import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromRGBO(50, 50, 50, 100),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(
                          Icons.person_pin,
                          size: 50,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("r/Community_name",
                                style: TextStyle(fontSize: 15)),
                            Text("u/User_name - 19h",
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ]),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz, size: 30))
                    ])),
            const Text("This is a post",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Row(children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_upward, color: Colors.grey)),
                const Text("Vote", style: TextStyle(fontSize: 17)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_downward, color: Colors.grey)),
                const SizedBox(width: 10),
              ]),
              Row(children: [
                IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.comment_outlined, color: Colors.grey)),
                const Text("0", style: TextStyle(fontSize: 17)),
              ]),
              Row(children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share, color: Colors.grey)),
                const Text("Share", style: TextStyle(fontSize: 17)),
              ]),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined, color: Colors.grey))
            ]),
          ],
        ));
  }
}
