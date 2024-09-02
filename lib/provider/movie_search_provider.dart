import 'package:flix_movie_app/models/movie_models.dart';
import 'package:flix_movie_app/repositories/movie_repositories.dart';
import 'package:flutter/material.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepositories _movieRepositories;

  MovieSearchProvider(this._movieRepositories);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModels> _movies = [];
  List<MovieModels> get movies => _movies;

  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepositories.search(query: query);

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

        return;
      },
    );
  }
}
