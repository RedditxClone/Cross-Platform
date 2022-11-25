import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/discover_page_cubit.dart';
import 'package:reddit/data/model/discover_page_model.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late List<DiscoverPageModel> allRandomPosts;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DiscoverPageCubit>(context).getAllRandomPosts();
  }

  List<String> createRandomPostsId(List<DiscoverPageModel> allRandomPosts) {
    if (allRandomPosts != []) {
      List<String> randomPostsIdList = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10"
      ];
      for (var i = 0; i < 10; i++) {
        randomPostsIdList[i] = allRandomPosts[i].postId;
      }
      return randomPostsIdList;
    } else {
      return [];
    }
  }

  ///Make a visual small card with random posts image to user to explore Subreddit with Category that he interested in
  ///
  ///input (Name of Subreddit & Post image Link)
  Widget createPostImageCard(String subredditName, String imageUrl,
      String postId, List<String> randomPostsIdList) {
    return InkWell(
      onTap: (() {
        //TODO : Make Post page with id = this Card post id{postId}.
        //TODO : Fill Post page with other Posts using {randomPostsIdList}
      }),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 20,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.darken),
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                )),
              ), //Post Image
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  subredditName,
                  style: const TextStyle(color: Colors.white),
                ),
              ), //Subreddit Name
            ],
          ),
        ),
      ),
    );
  }

  ///Make a visual 10 random posts Cards to user to explore Subreddit with Category {All Categories Posts}
  ///
  ///input ()
  Widget getAllCategoryTenRandomPostsWithImage(
      List<DiscoverPageModel> allRandomPosts, List<String> randomPostsIdList) {
    return GridView.count(
      crossAxisCount: 2,
      primary: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(2.0),
      childAspectRatio: 1,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      children: <Widget>[
        createPostImageCard(
            allRandomPosts[0].subredditName,
            allRandomPosts[0].imageUrl,
            allRandomPosts[0].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[1].subredditName,
            allRandomPosts[1].imageUrl,
            allRandomPosts[1].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[2].subredditName,
            allRandomPosts[2].imageUrl,
            allRandomPosts[2].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[3].subredditName,
            allRandomPosts[3].imageUrl,
            allRandomPosts[3].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[4].subredditName,
            allRandomPosts[4].imageUrl,
            allRandomPosts[4].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[5].subredditName,
            allRandomPosts[5].imageUrl,
            allRandomPosts[5].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[6].subredditName,
            allRandomPosts[6].imageUrl,
            allRandomPosts[6].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[7].subredditName,
            allRandomPosts[7].imageUrl,
            allRandomPosts[7].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[8].subredditName,
            allRandomPosts[8].imageUrl,
            allRandomPosts[8].postId,
            randomPostsIdList),
        createPostImageCard(
            allRandomPosts[9].subredditName,
            allRandomPosts[9].imageUrl,
            allRandomPosts[9].postId,
            randomPostsIdList),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Reddit'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20)),
              child: TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                    color: const Color.fromARGB(255, 81, 77, 77),
                    borderRadius: BorderRadius.circular(20)),
                labelColor: Colors.white,
                unselectedLabelColor: const Color.fromARGB(255, 143, 143, 143),
                tabs: const [
                  Tab(
                    child: Text(
                      'All',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Relegion', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Science', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'History', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Animals', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Nature', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Technology', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Memes', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Finance', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Crypto', //Will be added in Further Versions Updates
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<DiscoverPageCubit, DiscoverPageState>(
          builder: (context, state) {
            if (state is RandomPostsLoaded) {
              allRandomPosts = (state).randomPostss;
              if (allRandomPosts != []) {
                List<String> randomPostsIdList = [
                  "1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                  "7",
                  "8",
                  "9",
                  "10"
                ];
                //createRandomPostsId(allRandomPosts);
                return TabBarView(children: [
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                  getAllCategoryTenRandomPostsWithImage(
                      allRandomPosts, randomPostsIdList),
                ]);
              } else {
                return TabBarView(children: [
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ]);
              }
            } else {
              return TabBarView(children: [
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
                Container(),
              ]);
            }
          },
        ),
      ),
    );
  }
}
