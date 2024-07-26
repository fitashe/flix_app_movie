import 'package:flix_movie_app/models/movie_models.dart';
import 'package:flix_movie_app/repositories/movie_repositories.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieGetDiscoverProvider with ChangeNotifier {
  final MovieRepositories _movieRepository;

  MovieGetDiscoverProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModels> _movies = [];
  List<MovieModels> get movies => _movies;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getDiscover();

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
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

  void getDiscoverWithPagination(
    BuildContext context,
    PagingController pagingController,
    int page,
  ) async {
    final result = await _movieRepository.getDiscover(page: page);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );

        pagingController.error = errorMessage;

        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }

        return;
      },
    );
  }
}
