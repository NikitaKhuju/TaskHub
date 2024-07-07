import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskhub/src/screens/homescreen.dart';
import 'package:taskhub/src/screens/profilescreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [Homescreen(), ProfileScreen()];
  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: pages[selectedIndex],
        bottomNavigationBar: Container(
          margin: const EdgeInsets.fromLTRB(35, 0, 35, 20),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black,
          ),
          child: GNav(
              selectedIndex: selectedIndex,
              onTabChange: (index) => {navigateBottomBar(index)},
              activeColor: Colors.black,
              color: Colors.grey[350],
              tabs: [
                GButton(
                  padding: const EdgeInsets.all(14),
                  borderRadius: BorderRadius.circular(50),
                  backgroundColor: Colors.amber[300],
                  icon: Icons.home,
                  iconSize: 35,
                ),
                GButton(
                  padding: const EdgeInsets.all(14),
                  borderRadius: BorderRadius.circular(50),
                  backgroundColor: Colors.amber[300],
                  icon: Icons.person,
                  iconSize: 35,
                )
              ]),
        ));
  }
}
