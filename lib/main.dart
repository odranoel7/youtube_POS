import 'package:aula/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const YouFlutter());
}

class YouFlutter extends StatelessWidget {
  const YouFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "YouFlutter",
      home: Home(),
    );
  }
}