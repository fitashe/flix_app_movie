import 'package:flix_movie_app/injector.dart';
import 'package:flix_movie_app/provider/movie_get_detail_provider.dart';
import 'package:flix_movie_app/widgets/item_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          getIt<MovieGetDetailProvider>()..getDetail(context, id: id),
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(context),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;

  const _WidgetAppBar(this.context);

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Color? get foregroundColor => Colors.black;

  @override
  double? get expandedHeight => 300;

  @override
  List<Widget>? get actions => [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: const Icon(Icons.public),
              onPressed: () {},
            ),
          ),
        ),
      ];

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );

  @override
  Widget? get flexibleSpace => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return ItemMovieWidget(
              movieDetail: movie,
              heightBackdrop: double.infinity,
              widthBackdrop: double.infinity,
              heightPoster: 150,
              widthPoster: 100,
              radius: 0,
            );
          }

          return Container();
        },
      );
}

class _WidgetSummary extends SliverToBoxAdapter {
  Widget _content({required String title, required Widget body}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          body,
          const SizedBox(height: 12),
        ],
      );

  TableRow _tableContent({required String title, required String content}) =>
      TableRow(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;

            if (movie != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _content(
                    title: 'Release Date',
                    body: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          movie.releaseDate.toString().split(' ').first,
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _content(
                    title: 'Genres',
                    body: Wrap(
                      spacing: 6,
                      children: movie.genres
                          .map((genre) => Chip(label: Text(genre.name)))
                          .toList(),
                    ),
                  ),
                  _content(
                    title: 'Overview',
                    body: Text(
                      movie.overview,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _content(
                    title: 'Summary',
                    body: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      border: TableBorder.all(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      children: [
                        _tableContent(
                          title: "Adult",
                          content: movie.adult ? "Yes" : "No",
                        ),
                        _tableContent(
                          title: "Popularity",
                          content: '${movie.popularity}',
                        ),
                        _tableContent(
                          title: "Status",
                          content: movie.status,
                        ),
                        _tableContent(
                          title: "Revenue",
                          content: "${movie.revenue}",
                        ),
                        _tableContent(
                          title: "Tagline",
                          content: movie.tagline,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      );
}
