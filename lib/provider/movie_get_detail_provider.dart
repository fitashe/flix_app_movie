import 'package:flix_movie_app/models/movie_detail_models.dart';
import 'package:flix_movie_app/repositories/movie_repositories.dart';
import 'package:flutter/material.dart';

class MovieGetDetailProvider with ChangeNotifier {
  final MovieRepositories _movieRepositories;

  MovieGetDetailProvider(this._movieRepositories);

  MovieDetailModels? _movie;
  MovieDetailModels? get movie => _movie;

  void getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    final result = await _movieRepositories.getDetail(id: id);

    notifyListeners();

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );

        _movie = null;
        notifyListeners();

        return;
      },
      (response) {
        _movie = response;
        notifyListeners();

        return;
      },
    );
  }
}
