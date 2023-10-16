import 'package:flutter/material.dart';
import 'package:hello3/praktikum_page.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}
