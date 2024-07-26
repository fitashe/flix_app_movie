import 'package:flix_movie_app/models/movie_models.dart';
import 'package:flix_movie_app/repositories/movie_repositories.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieGetNowPlayingProvider with ChangeNotifier{
  final MovieRepositories _movieRepository;

  MovieGetNowPlayingProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModels> _movies = [];
  List<MovieModels> get movies => _movies;

  void getNowPlaying(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getNowPlaying();

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(messageError),
          ),
        );

        _isLoading = false;
        notifyListeners();

        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);

        _isLoading = false;
        notifyListeners();

        return null;
      },
    );
  }


  void getNowPlayingWithPagination(
    BuildContext context,
    PagingController pagingController,
    int page,
  ) async {
    final result = await _movieRepository.getNowPlaying(page: page);

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(messageError),
          ),
        );

        pagingController.error = messageError;
      },
      (response) {
        if (response.results.isEmpty) {
          pagingController.appendLastPage(response.results);
        } else {
          final isLastPage = response.page == response.totalPages;
          if (isLastPage) {
            pagingController.appendLastPage(response.results);
          } else {
            final nextPageKey = page + 1;
            pagingController.appendPage(response.results, nextPageKey);
          }
        }
      },
    );
  }

}