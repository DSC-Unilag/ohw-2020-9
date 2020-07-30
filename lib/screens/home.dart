import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meme_generator/screens/downloads.dart';
import 'package:meme_generator/screens/favourites.dart';
import 'package:meme_generator/screens/memes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    Hive.openBox('favourites', compactionStrategy: (int total, int deleted) {
      return deleted > 20;
    });
    Hive.openBox('downloads', compactionStrategy: (int total, int deleted) {
      return deleted > 20;
    });
  }

  @override
  void dispose() {
    Hive.close();
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    // pageController.jumpToPage(pageIndex);
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PageView(
          children: <Widget>[
            Memes(),
            FavouritesPage(),
            DownloadsPage(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0, //extend the shadow
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  -2.0, // Move to bottom 10 Vertically
                ),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: pageIndex,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontFamily: 'Segeo UI',
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                title: Text(
                  'Favourites',
                  style: TextStyle(
                    fontFamily: 'Segeo UI',
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.file_download,
                ),
                title: Text(
                  'Downloads',
                  style: TextStyle(
                    fontFamily: 'Segeo UI',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
