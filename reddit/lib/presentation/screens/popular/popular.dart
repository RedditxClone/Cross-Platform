// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:reddit/business_logic/cubit/posts/posts_home_cubit.dart';
// import 'package:reddit/presentation/screens/home/home.dart';
// import 'package:reddit/presentation/widgets/posts/posts.dart';
// import 'package:reddit/presentation/widgets/posts/posts_web.dart';

// class Popular extends StatelessWidget {
//   const Popular({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double cardHeight = 100;
//     return Container(
//       color: Colors.black,
//       child: ListView(
//         children: [
//           
//           BlocBuilder<PostsHomeCubit, PostsHomeState>(
//             builder: (context, state) {
//               if (state is PostsLoaded) {
//                 return Column(children: [
//                   ...state.posts!.map((e) => PostsWeb(postsModel: e)).toList()
//                 ]);
//               }
//               return const Center(child: CircularProgressIndicator());
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
