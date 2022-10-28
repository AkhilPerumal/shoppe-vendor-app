import 'package:cached_network_image/cached_network_image.dart';
import 'package:carclenx_vendor_app/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  final String placeholder;

  CustomImage(
      {@required this.image,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.placeholder});

  final CacheManager cacheManager = CacheManager(Config('images_Key',
      maxNrOfCacheObjects: 200, stalePeriod: const Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: cacheManager,
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      // progressIndicatorBuilder: (context, url, downloadProgress) =>
      //     Center(child: CircularProgressIndicator()),
      placeholder: (context, url) => Center(
        child: Image.asset(Images.placeholder,
            height: height != null ? height : 45,
            width: width != null ? width : 45,
            fit: BoxFit.cover),
      ),
      errorWidget: (context, url, error) => Center(
        child: Image.asset(Images.placeholder,
            height: height != null ? height : 45,
            width: width != null ? width : 45,
            fit: BoxFit.cover),
      ),
    );
  }
}
