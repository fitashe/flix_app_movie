import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flix_movie_app/models/movie_detail_models.dart';
import 'package:flix_movie_app/models/movie_models.dart';
import 'package:flix_movie_app/repositories/movie_repositories.dart';

class MovieRespImpl implements MovieRepositories {
  final Dio _dio;

  MovieRespImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModels>> getDiscover(
      {int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModels.fromJson(result.data);
        return Right(model);
      } else {
        return const Left('Error get discover movies');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data.toString());
      }
      return const Left('Another error get dicover movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModels>> getTopRated(
      {int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModels.fromJson(result.data);
        return Right(model);
      } else {
        return const Left('Error get top rated movies');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data.toString());
      }
      return const Left('Another error get top rated movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModels>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModels.fromJson(result.data);
        return Right(model);
      } else {
        return const Left('Error get now playing movies');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data.toString());
      }
      return const Left('Another error get now playing movies');
    }
  }

  @override
  Future<Either<String, MovieDetailModels>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModels.fromJson(result.data);
        return Right(model);
      } else {
        return const Left('Error get detail movies');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data.toString());
      }
      return const Left('Another error get detail movies');
    }
  }
}
