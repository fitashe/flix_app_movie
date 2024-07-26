import 'package:carousel_slider/carousel_slider.dart';
import 'package:flix_movie_app/provider/movie_get_discover_provider.dart';
import 'package:flix_movie_app/screens/movie_detail_page.dart';
import 'package:flix_movie_app/widgets/item_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDiscoverComponent extends StatefulWidget {
  const MovieDiscoverComponent({super.key});

  @override
  State<MovieDiscoverComponent> createState() => _MovieDiscoverComponentState();
}

class _MovieDiscoverComponentState extends State<MovieDiscoverComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.movies.length,
              itemBuilder: (_, index, __) {
                final movie = provider.movies[index];
                return ItemMovieWidget(
                  movie: movie,
                  heightBackdrop: 320,
                  widthBackdrop: double.infinity,
                  heightPoster: 160,
                  widthPoster: 100,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return MovieDetailPage(id: movie.id);
                        },
                      ),
                    );
                  },
                );
              },
              options: CarouselOptions(
                height: 320,
                viewportFraction: 0.8,
                reverse: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Not Found Discover Movies',
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
