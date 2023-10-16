import 'package:flutter/cupertino.dart';
import 'package:hello3/cupertino_page.dart';

class AppCupertino extends StatelessWidget {
  final _themedark = const CupertinoThemeData.raw(
    Brightness.dark,
    null,
    null,
    null,
    null,
    null,
    null,
  );

  const AppCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: _themedark,
      home: const HomePage(),
    );
  }
}
