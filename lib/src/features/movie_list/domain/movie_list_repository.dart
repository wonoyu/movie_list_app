import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_list_app/src/features/movie_list/domain/movie_list_model.dart';

abstract class MovieListRepository {
  Future<List<MovieListModel>> getMovieList();
  Future<List<MovieGenres>> getMovieGenres();
  List<MovieListModel> searchMovieList(
      List<MovieListModel> movieList, String keyword);
}

final movieListProvider = Provider<MovieListRepository>((ref) {
  throw UnimplementedError();
});
