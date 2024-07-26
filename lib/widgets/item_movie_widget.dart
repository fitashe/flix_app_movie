import 'package:flix_movie_app/models/movie_detail_models.dart';
import 'package:flix_movie_app/models/movie_models.dart';
import 'package:flix_movie_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class ItemMovieWidget extends Container {
  final MovieModels? movie;
  final MovieDetailModels? movieDetail;
  final double heightBackdrop;
  final double widthBackdrop;
  final double heightPoster;
  final double widthPoster;
  final double radius;
  final void Function()? onTap;

  ItemMovieWidget(
      {required this.heightBackdrop,
      required this.widthBackdrop,
      required this.heightPoster,
      required this.widthPoster,
      this.radius = 12,
      this.movie,
      this.movieDetail,
      this.onTap,
      super.key});

  @override
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      );

  @override
  Widget? get child => Stack(
        children: [
          ImageNetworkWidget(
            imageSrc:
                '${movieDetail != null ? movieDetail!.backdropPath : movie!.backdropPath}',
            height: heightBackdrop,
            width: widthBackdrop,
          ),
          Container(
            height: heightBackdrop,
            width: widthBackdrop,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkWidget(
                  imageSrc: movieDetail != null
                      ? movieDetail!.posterPath
                      : movie!.posterPath,
                  height: heightPoster,
                  width: widthPoster,
                  radius: 12,
                ),
                const SizedBox(height: 8),
                Text(
                  movieDetail != null ? movieDetail!.title : movie!.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    Text(
                      '${movieDetail != null ? movieDetail!.voteAverage : movie!.voteAverage} (${movieDetail != null ? movieDetail!.voteCount : movie!.voteCount})',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      );
}
