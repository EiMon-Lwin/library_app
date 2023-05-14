import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({Key? key, required this.imgUrl, required this.borderRadius, required this.imageWidth, required this.imageHeight}) : super(key: key);

  final String imgUrl;
  final double borderRadius;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(

      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover

          )
        ),
      ),
      imageUrl: imgUrl,
      height: imageHeight,
      width: imageWidth,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
    );
  }
}