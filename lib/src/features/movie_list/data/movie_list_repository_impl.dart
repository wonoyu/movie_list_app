import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_list_app/src/features/movie_list/domain/movie_list_model.dart';
import 'package:movie_list_app/src/features/movie_list/domain/movie_list_repository.dart';
import 'package:http/http.dart' as http;
import 'package:movie_list_app/src/shared/api.dart';
import 'package:movie_list_app/src/shared/api_keys.dart';

class MovieListRepositoryImpl implements MovieListRepository {
  MovieListRepositoryImpl({
    required this.client,
    required this.api,
  });

  final http.Client client;
  final MovieListAPI api;

  @override
  Future<List<MovieListModel>> getMovieList() async {
    final result =
        await Future.wait([client.get(api.movieList()), getMovieGenres()]);
    final movieListResponse = result[0] as http.Response;
    final movieGenres = result[1] as List<MovieGenres>;
    final movieList =
        MovieListResponse.fromJson(json.decode(movieListResponse.body)).results;
    for (var a in movieList) {
      a.genres = movieGenres;
    }
    return movieList;
  }

  @override
  Future<List<MovieGenres>> getMovieGenres() async {
    final response = await client.get(api.movieGenres());
    return List<MovieGenres>.from(json
        .decode(response.body)['genres']
        .map((data) => MovieGenres.fromJson(data)));
  }

  @override
  List<MovieListModel> searchMovieList(
      List<MovieListModel> movieList, String keyword) {
    return List<MovieListModel>.from(movieList.where((element) =>
        element.originalTitle.toLowerCase().contains(keyword.toLowerCase())));
  }
}

final movieListRepositoryImplProvider = Provider<MovieListRepositoryImpl>(
    (ref) => MovieListRepositoryImpl(
        client: http.Client(), api: MovieListAPI(apiKeys)));
