import 'dart:async';

import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/brands_provider.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandsWidget extends ConsumerStatefulWidget {
  const BrandsWidget({super.key});

  @override
  ConsumerState<BrandsWidget> createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends ConsumerState<BrandsWidget> {
  late ScrollController brandScrollController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    brandScrollController = ScrollController(onAttach: (pos) {
      _startAutoScroll(pos);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    brandScrollController.dispose();
    super.dispose();
  }

  void updateSelectedItem(int index, int brandId) {
    ref.read(productQueryProvider.notifier).updateBrand(brandId);
  }

  void _startAutoScroll(ScrollPosition pos) {
    const duration = Duration(milliseconds: 20);
    _timer = Timer.periodic(duration, (timer) {
      double currentPosition = pos.pixels;
      double maxScrollExtent = pos.maxScrollExtent;
      if (pos.userScrollDirection.name != "idle") {
        _timer.cancel();
        return;
      }

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
    final query = ref.watch(productQueryProvider);
    return brands.when(
      data: (data) {
        if (data.status == "APP00") {
          return ListView.builder(
              controller: brandScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: data.message!.length,
              itemBuilder: (context, index) {
                final itemIndex = index % data.message!.length;
                return GestureDetector(
                  onTap: () {
                    updateSelectedItem(itemIndex, data.message![itemIndex].id!);
                  },
                  child: Container(
                    width: DeviceInfo.getDeviceWidth(context) * 0.25,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            (data.message![itemIndex].img != "")
                                ? data.message![itemIndex].img ??
                                    Assets.fallBackProductImage
                                : Assets.fallBackProductImage,
                          ),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).highlightColor,
                        boxShadow: query.brandId == data.message![itemIndex].id!
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset.fromDirection(360),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                )
                              ]
                            : []),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  ),
                );
              });
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
        return const Center(child: Text("Server Error Occurred"));
      },
      loading: () {
        return const Center(child: LinearProgressIndicator());
      },
    );
  }
}
