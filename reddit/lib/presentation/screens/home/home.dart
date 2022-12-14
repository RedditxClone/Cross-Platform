// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:reddit/business_logic/cubit/posts/posts_home_cubit.dart';
// import 'package:reddit/presentation/widgets/posts/posts.dart';
// import 'package:reddit/presentation/widgets/posts/posts_web.dart';

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PostsHomeCubit, PostsHomeState>(
//       builder: (context, state) {
//         if (state is PostsLoaded) {
//           return ListView(children: [
//             ...state.posts!.map((e) => PostsWeb(postsModel: e)).toList()
//           ]);
//         }
//         return const Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }
