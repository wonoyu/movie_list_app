import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_list_app/src/features/movie_list/data/movie_list_repository_impl.dart';
import 'package:movie_list_app/src/features/movie_list/domain/movie_list_model.dart';

class MovieListController
    extends StateNotifier<AsyncValue<List<MovieListModel>>> {
  MovieListController(this._movieListRepositoryImpl)
      : super(const AsyncValue.loading()) {
    getMovieList();
  }
  final MovieListRepositoryImpl _movieListRepositoryImpl;
  List<MovieListModel> _unfiltered = [];

  Future<void> getMovieList() async {
    state = const AsyncValue.loading();
    // final data = await _movieListRepositoryImpl.getMovieList();
    // state = AsyncValue.data(data);
    state = await AsyncValue.guard(_movieListRepositoryImpl.getMovieList);
    _unfiltered = state.asData!.value;
  }

  void searchMovieList(String keyword) {
    if (state.asData == null) return;
    final movieList = _unfiltered;
    state = AsyncValue.data(
        _movieListRepositoryImpl.searchMovieList(movieList, keyword));
  }

  void cancelSearch() {
    state = AsyncValue.data(_unfiltered);
  }
}

final movieListControllerProvider = StateNotifierProvider.autoDispose<
    MovieListController, AsyncValue<List<MovieListModel>>>((ref) {
  final movieListRepositoryImpl = ref.watch(movieListRepositoryImplProvider);
  return MovieListController(movieListRepositoryImpl);
});
