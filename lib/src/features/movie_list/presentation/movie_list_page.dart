import 'package:flutter/material.dart';
import 'package:movie_list_app/src/features/movie_list/presentation/movie_list_view.dart';
import 'package:movie_list_app/src/features/movie_list/presentation/search_widget.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Popular Movies List",
          style: TextStyle(fontSize: 24),
        ),
        actions: const [SearchWidget()],
      ),
      body: const MovieListView(),
    );
  }
}
