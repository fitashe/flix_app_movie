import 'package:dartz/dartz.dart';
import 'package:flix_movie_app/models/movie_detail_models.dart';
import 'package:flix_movie_app/models/movie_models.dart';
import 'package:flix_movie_app/models/movie_video_models.dart';

abstract class MovieRepositories {
  Future<Either<String, MovieResponseModels>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModels>> getTopRated({int page = 1});
  Future<Either<String, MovieResponseModels>> getNowPlaying({int page = 1});
  Future<Either<String, MovieResponseModels>> search({required String query});
  Future<Either<String, MovieDetailModels>> getDetail({required int id});
  Future<Either<String, MovieVideosModels>> getVideos({required int id});
}
