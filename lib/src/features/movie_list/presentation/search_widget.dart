import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_list_app/src/features/movie_list/presentation/movie_list_controller.dart';
import 'package:movie_list_app/src/res/colors.dart';

class SearchWidget extends ConsumerStatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends ConsumerState<SearchWidget> {
  bool _isSearching = false;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isSearching
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CupertinoSearchTextField(
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: white,
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark_circle_fill,
                color: white,
              ),
              placeholder: "Search by Title",
              suffixMode: OverlayVisibilityMode.always,
              onSuffixTap: () {
                setState(() {
                  _isSearching = false;
                  _controller.clear();
                  ref.read(movieListControllerProvider.notifier).cancelSearch();
                });
              },
              controller: _controller,
              onSubmitted: (value) {
                ref
                    .read(movieListControllerProvider.notifier)
                    .searchMovieList(value);
              },
            ),
          )
        : IconButton(
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
            icon: const Icon(Icons.search));
  }
}
