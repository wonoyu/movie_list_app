class MovieListAPI {
  MovieListAPI(this.apiKey);

  final String apiKey;

  static const _baseUrl = "api.themoviedb.org";
  static const _pathGenres = "/3/genre/movie/list";
  static const _path = "/3/movie/popular";

  Uri movieList() => Uri(
        scheme: "https",
        host: _baseUrl,
        path: _path,
        queryParameters: {
          "api_key": apiKey,
          "language": "en-US",
          "page": "1",
        },
      );

  Uri movieGenres() => Uri(
        scheme: "https",
        host: _baseUrl,
        path: _pathGenres,
        queryParameters: {
          "api_key": apiKey,
          "language": "en-US",
        },
      );
}
