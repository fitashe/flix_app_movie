import 'package:flix_movie_app/app_constants.dart';
import 'package:flutter/material.dart';

enum TypeSrcImage {
  movieDb,
  external,
}

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    super.key,
    this.imageSrc,
    this.height,
    this.width,
    this.radius = 0.0,
    this.onTap,
    this.type = TypeSrcImage.movieDb,
  });

  final String? imageSrc;
  final TypeSrcImage type;
  final double? height;
  final double? width;
  final double radius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            type == TypeSrcImage.movieDb
                ? '${AppConstants.imgUrlw500}$imageSrc'
                : imageSrc!,
            height: height,
            width: width,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              return Container(
                height: height,
                width: width,
                color: Colors.black26,
                child: child,
              );
            },
            errorBuilder: (_, __, ___) {
              return SizedBox(
                height: height,
                width: width,
                child: const Icon(
                  Icons.broken_image_rounded,
                ),
              );
            },
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
}
