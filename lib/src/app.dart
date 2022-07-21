import 'package:flutter/material.dart';
import 'package:movie_list_app/src/features/movie_list/presentation/movie_list_page.dart';
import 'package:movie_list_app/src/res/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies List',
      theme: theme,
      home: const MovieListPage(),
    );
  }
}
