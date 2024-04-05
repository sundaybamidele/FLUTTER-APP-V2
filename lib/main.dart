import 'package:flutter/material.dart';
import 'blog_item.dart';
import 'blog_item_screen.dart';
import 'blog_list_screen.dart';
import 'database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Appp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BlogListScreen(),
    );
  }
}
