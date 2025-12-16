import 'package:flutter/material.dart';
import 'home_screen.dart';

import 'package:my_exercise/exercise_13/article_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ứng dụng tổng hợp bài tập Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 4,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        ArticleDetailScreen.routeName: (context) => const ArticleDetailScreen(),
      },
    );
  }
}