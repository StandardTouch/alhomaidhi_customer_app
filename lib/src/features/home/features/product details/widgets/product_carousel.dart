import 'package:Alhomaidhi/src/features/home/features/product%20details/models/single_product_model.dart';
import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({
    super.key,
    required this.images,
  });
  final List<Images> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        // enlargeFactor: 0.5,
        height: DeviceInfo.getDeviceHeight(context) * 0.4,
        viewportFraction: 1,
      ),
      items: images.map((image) {
        return Container(
          width: DeviceInfo.getDeviceWidth(context),
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset.fromDirection(360),
                blurRadius: 4,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: CachedNetworkImage(
                    imageUrl: image.src ?? Assets.fallBackProductImage,
                    placeholder: (context, url) =>
                        Image.asset(Assets.placeHolderImage),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var index in images)
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (index.id == image.id)
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                      ),
                    ),
                ],
              ),
              const Gap(5),
            ],
          ),
        );
      }).toList(),
    );
  }
}
