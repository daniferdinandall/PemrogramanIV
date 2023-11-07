import 'package:flutter/material.dart';
import 'package:pertemuan_6/bottom_navigation.dart';
// import 'package:pertemuan_6/app.dart';
// import 'input_validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const DynamicBottomNavbar(),
    );
  }
}