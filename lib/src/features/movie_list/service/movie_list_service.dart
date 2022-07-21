import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_list_app/src/features/movie_list/data/movie_list_repository_impl.dart';

class MovieListService {
  MovieListService({
    required this.movieListRepository,
  });
  final MovieListRepositoryImpl movieListRepository;
}

final movieListServiceProvider = Provider<MovieListService>((ref) {
  return MovieListService(
      movieListRepository: ref.watch(movieListRepositoryImplProvider));
});
