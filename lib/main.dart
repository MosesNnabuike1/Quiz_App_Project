import 'pages/start_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyQuizApp());
}

class MyQuizApp extends StatelessWidget {
  const MyQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const StartPage(),
    );
  }
}
