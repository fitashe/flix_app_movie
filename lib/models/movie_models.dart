// import 'package:meta/meta.dart';
// import 'dart:convert';

class MovieResponseModels {
  final int page;
  final List<MovieModels> results;
  final int totalPages;
  final int totalResults;

  MovieResponseModels({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModels.fromJson(Map<String, dynamic> json) =>
      MovieResponseModels(
        page: json["page"],
        results: List<MovieModels>.from(
            json["results"].map((x) => MovieModels.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class MovieModels {
  final String? backdropPath;
  final int id;
  final String overview;
  final String posterPath;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieModels({
    this.backdropPath,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModels.fromJson(Map<String, dynamic> json) => MovieModels(
        backdropPath: json["backdrop_path"] ?? '',
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? '',
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
