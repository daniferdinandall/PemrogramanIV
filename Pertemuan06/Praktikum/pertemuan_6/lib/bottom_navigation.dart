import 'package:flutter/material.dart';
import 'package:pertemuan_6/app.dart';
import 'package:pertemuan_6/input_form.dart';
import 'package:pertemuan_6/input_validation.dart';

class DynamicBottomNavbar extends StatefulWidget {
  const DynamicBottomNavbar({super.key});

  @override
  State<DynamicBottomNavbar> createState() => _DynamicBottomNavbarState();
}

class _DynamicBottomNavbarState extends State<DynamicBottomNavbar> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = <Widget>[
    const MyInput(),
    const MyInputValidation(),
    const MyInputForm(),
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
            icon: Icon(Icons.input),
            label: 'Latihan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: 'Input Validation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: 'Input Form',
          ),
        ],
        backgroundColor: Colors.yellow,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
      )
    );
  }
}