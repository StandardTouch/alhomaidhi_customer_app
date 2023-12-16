import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/models/single_product_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
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
        height: DeviceInfo.getDeviceHeight(context) * 0.3,
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
                    color: Colors.black.withOpacity(0.2))
              ]),
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  image.src ?? Assets.fallBackProductImage,
                  fit: BoxFit.contain,
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
