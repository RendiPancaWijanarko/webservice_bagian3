import 'package:flutter/material.dart';

import 'universities_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universities App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF212121),
        hintColor: Color(0xFF1976D2),
        scaffoldBackgroundColor: Color(0xFF303030),
      ),
      home: UniversitiesList(),
    );
  }
}
