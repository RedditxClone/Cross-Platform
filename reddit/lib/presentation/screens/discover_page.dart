import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String subRedditName = 'r/ILoveYouAllah';
  String cardImageLink =
      'https://preview.redd.it/0xo9bo1t9ct91.png?width=622&format=png&auto=webp&s=bc3dea6ce391d716c891030c919ddc004e3c6644';

  ///Make a visual small card with random posts image to user to explore Subreddit with Category that he interested in
  ///
  ///input (Name of Subreddit & Post image Link)
  Widget createPostImageCard(String subRedditName, String cardImageLink) {
    return InkWell(
      onTap: (() {
        //TODO : Make Post page with id = this Card post id.
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
                  image: NetworkImage(cardImageLink),
                  fit: BoxFit.fill,
                )),
              ), //Post Image
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  subRedditName,
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
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
        createPostImageCard(subRedditName, cardImageLink),
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
