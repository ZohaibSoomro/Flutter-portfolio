import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const CombinationApp());
}

class CombinationApp extends StatelessWidget {
  const CombinationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
