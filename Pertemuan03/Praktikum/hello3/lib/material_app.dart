import 'package:flutter/material.dart';
import 'package:hello3/material_page.dart';

class AppMaterial extends StatefulWidget {
  const AppMaterial({super.key});

  @override
  State<AppMaterial> createState() => _AppMaterialState();
}

class _AppMaterialState extends State<AppMaterial> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}
