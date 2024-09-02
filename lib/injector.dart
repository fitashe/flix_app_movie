import 'package:dio/dio.dart';
import 'package:flix_movie_app/app_constants.dart';
import 'package:flix_movie_app/provider/movie_get_detail_provider.dart';
import 'package:flix_movie_app/provider/movie_get_discover_provider.dart';
import 'package:flix_movie_app/provider/movie_get_top_rated_provider.dart';
import 'package:flix_movie_app/provider/movie_get_videos_provider.dart';
import 'package:flix_movie_app/provider/movie_now_playing_provider.dart';
import 'package:flix_movie_app/provider/movie_search_provider.dart';
import 'package:flix_movie_app/repositories/movie_repositories.dart';
import 'package:flix_movie_app/repositories/movie_resp_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  //Register Provider
  getIt.registerFactory<MovieGetDiscoverProvider>(
    () => MovieGetDiscoverProvider(getIt()),
  );
  getIt.registerFactory<MovieGetTopRatedProvider>(
    () => MovieGetTopRatedProvider(getIt()),
  );
  getIt.registerFactory<MovieGetNowPlayingProvider>(
    () => MovieGetNowPlayingProvider(getIt()),
  );
  getIt.registerFactory<MovieGetDetailProvider>(
    () => MovieGetDetailProvider(getIt()),
  );
  getIt.registerFactory<MovieGetVideosProvider>(
    () => MovieGetVideosProvider(getIt()),
  );
  getIt.registerFactory<MovieSearchProvider>(
    () => MovieSearchProvider(getIt()),
  );

  // Register Repository
  getIt.registerLazySingleton<MovieRepositories>(
    () => MovieRespImpl(getIt()),
  );

  // Register Http Client (DIO)
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {'api_key': AppConstants.apiKey},
      ),
    ),
  );
}
