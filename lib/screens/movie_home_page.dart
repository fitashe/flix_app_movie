import 'package:flix_movie_app/component/movie_discover_component.dart';
import 'package:flix_movie_app/component/movie_now_playing_component.dart';
import 'package:flix_movie_app/component/movie_top_rated_component.dart';
import 'package:flix_movie_app/screens/movie_pagination_page.dart';
import 'package:flutter/material.dart';

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const Text(
                  'FlixApp',
                  style: TextStyle(
                      color: Color(0xFFFFD369),
                      fontFamily: 'Roboto',
                      fontSize: 20),
                ),
              ],
            ),
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: const Color(0xFF202040),
            foregroundColor: Colors.black,
          ),
          _WidgetTitle(
            title: 'Discover Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    typeMovie: TypeMovie.discover,
                  ),
                ),
              );
            },
          ),
          const MovieDiscoverComponent(),
          _WidgetTitle(
            title: 'Top Rated Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    typeMovie: TypeMovie.topRated,
                  ),
                ),
              );
            },
          ),
          const MovieTopRatedComponent(),
          _WidgetTitle(
            title: 'Now Playing Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    typeMovie: TypeMovie.nowPlaying,
                  ),
                ),
              );
            },
          ),
          const MovieNowPlayingComponent(),
        ],
      ),
    );
  }
}

class _WidgetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const _WidgetTitle({required this.title, required this.onPressed});

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFFFD369),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFFF6363),
                shape: const StadiumBorder(),
                side: const BorderSide(
                  color: Color(0xFFFFD369),
                ),
              ),
              child: const Text(
                'See All',
                style: TextStyle(
                  color: Color(0xFFFFD369),
                ),
              ),
            ),
          ],
        ),
      );
}
