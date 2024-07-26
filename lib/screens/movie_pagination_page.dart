import 'package:flix_movie_app/models/movie_models.dart';
import 'package:flix_movie_app/provider/movie_get_discover_provider.dart';
import 'package:flix_movie_app/provider/movie_get_top_rated_provider.dart';
import 'package:flix_movie_app/provider/movie_now_playing_provider.dart';
import 'package:flix_movie_app/widgets/item_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

enum TypeMovie {
  discover,
  topRated,
  nowPlaying,
}

class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key, required this.typeMovie});

  final TypeMovie typeMovie;

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  final PagingController<int, MovieModels> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener(
      (pageKey) {
        switch (widget.typeMovie) {
          case TypeMovie.discover:
            context.read<MovieGetDiscoverProvider>().getDiscoverWithPagination(
                  context,
                  _pagingController,
                  pageKey,
                );
            break;
          case TypeMovie.topRated:
            context.read<MovieGetTopRatedProvider>().getTopRatedWithPagination(
                  context,
                  _pagingController,
                  pageKey,
                );
          case TypeMovie.nowPlaying:
            context
                .read<MovieGetNowPlayingProvider>()
                .getNowPlayingWithPagination(
                  context,
                  _pagingController,
                  pageKey,
                );
            break;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (_) {
            switch (widget.typeMovie) {
              case TypeMovie.discover:
                return const Text('Discover Movie');
              case TypeMovie.topRated:
                return const Text('Top Rated Movie');
              case TypeMovie.nowPlaying:
                return const Text('Now Playing Movie');
            }
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: PagedListView.separated(
        padding: const EdgeInsets.all(16),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModels>(
          itemBuilder: (context, movie, index) => ItemMovieWidget(
            movie: movie,
            heightBackdrop: 300,
            widthBackdrop: double.infinity,
            heightPoster: 140,
            widthPoster: 100,
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
