import 'package:flix_movie_app/models/movie_video_models.dart';
import 'package:flix_movie_app/repositories/movie_repositories.dart';
import 'package:flutter/material.dart';

class MovieGetVideosProvider with ChangeNotifier {
  final MovieRepositories _movieRepositories;

  MovieGetVideosProvider(this._movieRepositories);

  MovieVideosModels? _videos;
  MovieVideosModels? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    final result = await _movieRepositories.getVideos(id: id);

    notifyListeners();

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );

        _videos = null;
        notifyListeners();

        return;
      },
      (response) {
        _videos = response;
        notifyListeners();

        return;
      },
    );
  }
}
