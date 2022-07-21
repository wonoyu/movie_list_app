import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_list_app/src/features/movie_list/domain/movie_list_model.dart';
import 'package:movie_list_app/src/features/movie_list/presentation/movie_list_controller.dart';
import 'package:movie_list_app/src/shared/api_keys.dart';

class MovieListView extends ConsumerWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieListData = ref.watch(movieListControllerProvider);
    return movieListData.when(
      data: (data) => RefreshIndicator(
        onRefresh: () async {
          ref.read(movieListControllerProvider.notifier).getMovieList();
        },
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) => ListViewContent(
            data: data[index],
            genres: data.last.genres ?? [],
          ),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, __) => Center(
        child: Text(e.toString()),
      ),
    );
  }
}

class ListViewContent extends ConsumerWidget {
  const ListViewContent({Key? key, required this.data, required this.genres})
      : super(key: key);
  final MovieListModel data;
  final List<MovieGenres> genres;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: "$imageBaseUrl${data.posterPath}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 100,
                  color: Colors.red,
                ),
              )
              // Image.network(
              //   "$imageBaseUrl${data.posterPath}",
              //   scale: 1.1,
              // ),
              ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      data.originalTitle,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Text(
                    data.releaseDate,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 16.0,
                    ),
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.genreIds.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Chip(
                              label: Text(data
                                  .genres![data.genres!.indexWhere((element) =>
                                      element.id == data.genreIds[index])]
                                  .name)),
                        );
                      },
                    ),
                  ),
                  Text(
                    "Score : ",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Wrap(
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4.0,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.orange,
                      ),
                      Text(
                        "${data.voteAverage} (${data.voteCount} Users)",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
