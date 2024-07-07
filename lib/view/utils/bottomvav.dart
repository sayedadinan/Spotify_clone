import 'package:flutter/material.dart';
import 'package:netflix/view/screens/Search_screen/search.dart';
import 'package:netflix/view/screens/Yourlibrary_screen/library.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({Key? key}) : super(key: key);

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  final Tabs = [Libraryscree(), Navigationbar(), Searchscreen()];
  int currentTabindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Tabs[currentTabindex],
      // backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabindex,
        onTap: (currentindex) {
          print('current index is $currentindex');
          currentTabindex = currentindex;
        },
        backgroundColor: Colors.black45,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        // labelStyle: TextStyle(color: Colors.white), // Change text color here
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Your Library',
            icon: Icon(Icons.my_library_music),
          ),
        ],
      ),
    );
  }
}
