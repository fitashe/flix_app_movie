import 'package:flix_movie_app/models/movie_models.dart';
import 'package:flix_movie_app/repositories/movie_repositories.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieGetTopRatedProvider with ChangeNotifier {
  final MovieRepositories _movieRepository;

  MovieGetTopRatedProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModels> _movies = [];
  List<MovieModels> get movies => _movies;

  void getTopRated(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getTopRated();

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

  void getTopRatedWithPagination(
    BuildContext context,
    PagingController pagingController,
    int page,
  ) async {
    final result = await _movieRepository.getTopRated(page: page);

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(messageError),
          ),
        );
        pagingController.error = messageError;

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
