import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  Widget createPostImageCard() {
    return const Card();
  }

  Widget getAllCategoryTenRandomPostsWithImage() {
    return GridView.count(
      crossAxisCount: 2,
      primary: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(2.0),
      childAspectRatio: 1,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      children: <Widget>[
        createPostImageCard(),
        createPostImageCard(),
        createPostImageCard(),
        createPostImageCard(),
        createPostImageCard(),
        createPostImageCard(),
        createPostImageCard(),
        createPostImageCard(),
        createPostImageCard(),
        createPostImageCard(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
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
                      'Relegion',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Science',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'History',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Animals',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Nature',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Technology',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Memes',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Finance',
                      style: TextStyle(
                        //color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Crypto',
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
        body: TabBarView(children: [
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
          getAllCategoryTenRandomPostsWithImage(),
        ]),
      ),
    );
  }
}
