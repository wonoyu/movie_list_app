class MovieListResponse {
  MovieListResponse({required this.page, required this.results});

  int page;
  List<MovieListModel> results;

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      MovieListResponse(
        page: json['page'],
        results: List<MovieListModel>.from(
            json['results'].map((data) => MovieListModel.fromJson(data))),
      );
}

class MovieListModel {
  MovieListModel({
    required this.id,
    required this.originalTitle,
    required this.releaseDate,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
    this.genres,
  });

  int id;
  String originalTitle;
  String releaseDate;
  List<int> genreIds;
  num voteAverage;
  num voteCount;
  String posterPath;
  List<MovieGenres>? genres;

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        id: json['id'],
        originalTitle: json['original_title'],
        releaseDate: json['release_date'],
        genreIds: List<int>.from(
            json['genre_ids'].map((data) => int.parse(data.toString()))),
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
        posterPath: json['poster_path'],
        genres: json['genres'],
      );
}

class MovieGenres {
  MovieGenres({
    required this.id,
    required this.name,
  });
  int id;
  String name;

  factory MovieGenres.fromJson(Map<String, dynamic> json) =>
      MovieGenres(id: json['id'], name: json['name']);
}
