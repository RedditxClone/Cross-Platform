import 'package:flutter/material.dart';
import 'package:reddit/constants/responsive.dart';
import 'package:reddit/constants/theme_colors.dart';

class PostsWeb extends StatefulWidget {
  const PostsWeb({Key? key}) : super(key: key);

  @override
  State<PostsWeb> createState() => _PostsWebState();
}

class _PostsWebState extends State<PostsWeb> {
  late Responsive responsive;
  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);
    return Container(
      height: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: defaultSecondaryColor),
      margin: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          responsive.isSmallSizedScreen()
              ? const SizedBox(width: 0)
              : Expanded(
                  child: Container(
                  color: defaultSecondaryColor.withOpacity(0.001),
                  child: Column(
                    children: const [
                      SizedBox(height: 10),
                      Icon(Icons.arrow_upward, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("0", style: TextStyle(fontSize: 13)),
                      SizedBox(height: 10),
                      Icon(Icons.arrow_downward, color: Colors.grey),
                    ],
                  ),
                )),
          Expanded(
            flex: 11,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
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
                                    style: TextStyle(fontSize: 13)),
                                Text("u/User_name - 19h",
                                    style: TextStyle(fontSize: 13)),
                              ],
                            ),
                          ]),
                        ])),
                Container(
                  height: 470,
                  width: double.infinity,
                  color: Colors.white12,
                  // child: const Text("This is a post",
                  //     style:
                  //         TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        responsive.isSmallSizedScreen()
                            ? Row(children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_upward,
                                        color: Colors.grey)),
                                const Text("0", style: TextStyle(fontSize: 13)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_downward,
                                        color: Colors.grey)),
                                const SizedBox(width: 5),
                              ])
                            : const SizedBox(width: 0),
                        InkWell(
                          onTap: () {},
                          child: Row(children: const [
                            Icon(Icons.comment_outlined, color: Colors.grey),
                            SizedBox(width: 5),
                            Text("0 Comments", style: TextStyle(fontSize: 13)),
                          ]),
                        ),
                        const SizedBox(width: 10),
                        responsive.isSmallSizedScreen()
                            ? const SizedBox(width: 0)
                            : InkWell(
                                onTap: () {},
                                child: Row(children: const [
                                  Icon(Icons.file_upload_outlined,
                                      color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text("Share", style: TextStyle(fontSize: 13)),
                                ]),
                              ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Row(children: const [
                            Icon(Icons.turned_in_not, color: Colors.grey),
                            SizedBox(width: 5),
                            Text("Save", style: TextStyle(fontSize: 13)),
                          ]),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Row(children: const [
                            Icon(Icons.more_horiz, color: Colors.grey),
                            SizedBox(width: 5),
                          ]),
                        ),
                        const SizedBox(width: 10),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
