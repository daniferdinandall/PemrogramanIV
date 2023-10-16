import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dani Ferdinan'),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              ListTile(
                title: Text("Home Page"),
              ),
              ListTile(
                title: Text("About Page"),
              ),
              ListTile(
                title: Text("Settings Page"),
              )
            ],
          ),
        ),
        body: const Center(child: Text("Ini Adalah Halaman Home Page")),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "About",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Setting",
            ),
          ],
        ));
  }
}
