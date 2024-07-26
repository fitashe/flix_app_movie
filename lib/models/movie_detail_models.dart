// import 'dart:convert';

class MovieDetailModels {
  final bool adult;
  final String backdropPath;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final int revenue;
  final String status;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieDetailModels({
    required this.adult,
    this.backdropPath = '',
    required this.genres,
    required this.homepage,
    required this.id,
    required this.overview,
    required this.popularity,
    this.posterPath = '',
    required this.releaseDate,
    required this.revenue,
    required this.status,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailModels.fromJson(Map<String, dynamic> json) =>
      MovieDetailModels(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );
}
