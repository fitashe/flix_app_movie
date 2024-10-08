class MovieVideosModels {
  final int id;
  final List<Result> results;

  MovieVideosModels({
    required this.id,
    required this.results,
  });

  factory MovieVideosModels.fromJson(Map<String, dynamic> json) =>
      MovieVideosModels(
        id: json["id"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String id;

  Result({
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        id: json["id"],
      );
}
