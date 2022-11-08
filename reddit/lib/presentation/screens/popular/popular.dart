import 'package:flutter/material.dart';
import 'package:reddit/presentation/widgets/posts/posts.dart';

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    double cardHeight = 100;
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: cardHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (int index) {
                return Card(
                  key: const Key('row-card'),
                  color: Colors.blue,
                  child: SizedBox(
                    width: 150.0,
                    height: cardHeight,
                    child: Center(child: Text("$index")),
                  ),
                );
              }),
            ),
          ),
          const Posts()
        ],
      ),
    );
  }
}
