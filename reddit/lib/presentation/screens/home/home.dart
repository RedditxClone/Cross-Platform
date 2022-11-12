import 'package:flutter/material.dart';
import 'package:reddit/presentation/widgets/posts/posts.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
          itemCount: 7, itemBuilder: ((ctx, index) => const Posts())),
    );
  }
}
