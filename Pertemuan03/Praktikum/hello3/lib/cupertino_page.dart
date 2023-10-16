import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Dani Ferdinan'),
      ),
      child: Center(child: Text("Ini Adalah Halaman Home Page cupertino")),
    );
  }
}
