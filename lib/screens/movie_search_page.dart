import 'package:flix_movie_app/provider/movie_search_provider.dart';
import 'package:flix_movie_app/screens/movie_detail_page.dart';
import 'package:flix_movie_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search Movies';
  @override
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.white);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF202040),
          foregroundColor: Colors.black,
          elevation: 0.5),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<MovieSearchProvider>().search(context, query: query);
      }
    });

    return Consumer<MovieSearchProvider>(
      builder: (_, provider, __) {
        if (query.isEmpty) {
          return const Center(
              child: Text(
            'Search Movies',
            style: TextStyle(
              color: Colors.white,
            ),
          ));
        }

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.movies.isEmpty) {
          return const Center(
            child: Text(
              'Movies Not Found',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }

        if (provider.movies.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (_, index) {
              final movie = provider.movies[index];
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ImageNetworkWidget(
                          imageSrc: movie.posterPath,
                          height: 120,
                          width: 80,
                          radius: 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                movie.overview,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                      child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        close(context, null);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return MovieDetailPage(id: movie.id);
                            },
                          ),
                        );
                      },
                    ),
                  )),
                ],
              );
            },
            itemCount: provider.movies.length,
            separatorBuilder: (_, __) => const SizedBox(),
          );
        }

        return const Center(
          child: Text(
            'Another Error on Seacrh Movies',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
