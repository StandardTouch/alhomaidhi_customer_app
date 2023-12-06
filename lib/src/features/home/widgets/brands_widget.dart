import 'dart:async';

import 'package:alhomaidhi_customer_app/src/features/home/models/brand_response.dart';
import 'package:alhomaidhi_customer_app/src/features/home/providers/brands_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/providers/products_provider.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandsWidget extends ConsumerStatefulWidget {
  const BrandsWidget({super.key, required this.height});
  final double height;

  @override
  ConsumerState<BrandsWidget> createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends ConsumerState<BrandsWidget> {
  final ScrollController brandScrollController = ScrollController();
  Timer? _timer;
  int? selectedIndex;

  @override
  void initState() {
    _startAutoScroll();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    brandScrollController.dispose();
    super.dispose();
  }

  void updateSelectedItem(int index, int brandId) {
    setState(() {
      selectedIndex = index;
    });
    logger.d("the brand id is $brandId");
    ref.read(productQueryProvider.notifier).updateBrand(brandId);
  }

  void _startAutoScroll() {
    const duration = Duration(milliseconds: 50);
    _timer = Timer.periodic(duration, (timer) {
      double currentPosition = brandScrollController.position.pixels;
      double maxScrollExtent = brandScrollController.position.maxScrollExtent;

      // Check if the current position is at the end of the list
      if (currentPosition < maxScrollExtent) {
        brandScrollController.jumpTo(
            currentPosition + 1.0); // Adjust the value to control step size
      } else {
        brandScrollController.jumpTo(0.0); // Go back to the start of the list
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final brands = ref.watch(brandsProvider);
    return brands.when(
      data: (data) {
        if (data.status == "APP00") {
          return SizedBox(
            height: widget.height,
            width: double.infinity,
            child: ListView.builder(
                controller: brandScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: data.message!.length,
                itemBuilder: (context, index) {
                  final itemIndex = index % data.message!.length;
                  return GestureDetector(
                    onTap: () {
                      updateSelectedItem(
                          itemIndex, data.message![itemIndex].id!);
                    },
                    child: Container(
                      height: widget.height,
                      width: DeviceInfo.getDeviceWidth(context) * 0.25,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(data.message![itemIndex].img!),
                            fit: BoxFit.contain,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).highlightColor,
                          boxShadow: selectedIndex == itemIndex
                              ? [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: Offset.fromDirection(360),
                                      spreadRadius: 2,
                                      blurRadius: 4)
                                ]
                              : []),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 8),
                    ),
                  );
                }),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("An Error Occurred!"),
              Text(data.errorMessage!),
            ],
          );
        }
      },
      error: (err, stackTrace) {
        return Center(child: Text("Server Error Occurred: $err"));
      },
      loading: () {
        return const Center(child: LinearProgressIndicator());
      },
    );
  }
}
