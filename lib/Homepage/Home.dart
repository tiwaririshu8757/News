import 'package:flutter/material.dart';
import 'package:newz_app/Homepage/newsfeed.dart';
import 'package:newz_app/Homepage/bookmark.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List _bookmarkedArticles = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _screens => [
    NewsFeed(
      onBookmarkChanged: (bookmarks) {
        setState(() {
          _bookmarkedArticles = bookmarks;
        });
      },
      bookmarkedArticles: _bookmarkedArticles,
    ),
    BookmarkPage(bookmarkedArticles: _bookmarkedArticles,onBookmarkChanged: (bookmarks) {
      setState(() {
        _bookmarkedArticles = bookmarks;
      });
    },),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "News"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Bookmarks"),
        ],
      ),
    );
  }
}
