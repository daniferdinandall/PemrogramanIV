import 'package:flutter/material.dart';
import 'package:ats_1214050/home.dart';
import 'package:ats_1214050/list_contacts.dart';

class DynamicBottomNavbar extends StatefulWidget {
  const DynamicBottomNavbar({super.key});

  @override
  State<DynamicBottomNavbar> createState() => _DynamicBottomNavbarState();
}

class _DynamicBottomNavbarState extends State<DynamicBottomNavbar> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = <Widget>[
    const MyInput(),
    const MyListContacts(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: 'List Contacts',
          ),
        ],
        backgroundColor: Colors.blue[300],
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.white,
      )
    );
  }
}