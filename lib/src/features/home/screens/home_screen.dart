import 'package:alhomaidhi_customer_app/src/features/home/providers/brands_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/providers/products_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/widgets/brands_widget.dart';
import 'package:alhomaidhi_customer_app/src/features/home/widgets/product_card.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool noMoreProducts = false;

  void pageNavigator({required bool isPrev}) {
    final query = ref.read(productQueryProvider.notifier);
    if (isPrev) {
      query.decrementPage();
    } else {
      query.incrementPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = DeviceInfo.getDeviceHeight(context);
    final products = ref.watch(allProductsProvider);
    final query = ref.watch(productQueryProvider);
    ref.watch(brandsProvider);
    return products.when(data: (data) {
      if (data.status == "APP00") {
        if (data.message!.length < 100) {
          noMoreProducts = true;
        } else {
          noMoreProducts = false;
        }
        return ListView(
          children: [
            BrandsWidget(height: height * 0.1),
            GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 10,
                  childAspectRatio: DeviceInfo.getDeviceWidth(context) /
                      (DeviceInfo.getDeviceHeight(context) / 1.5),
                  // mainAxisExtent: DeviceInfo.getDeviceHeight(context) * 0.35,
                ),
                itemCount: data.message!.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    imageUrl: data.message![index].images!.isEmpty
                        ? Assets.fallBackProductImage
                        : data.message![index].images![0].src!,
                    title: data.message![index].productDetails!.name!,
                    priceBefore:
                        data.message![index].productDetails!.regularPrice!,
                    priceNow: data.message![index].productDetails!.salePrice!,
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: (query.pageNo == 1)
                      ? null
                      : () {
                          pageNavigator(isPrev: true);
                        },
                  icon: const Icon(Icons.arrow_circle_left),
                  label: const Text("previous"),
                ),
                TextButton.icon(
                  onPressed: noMoreProducts
                      ? null
                      : () {
                          pageNavigator(isPrev: false);
                        },
                  icon: Icon(Icons.arrow_circle_right),
                  label: Text("next"),
                ),
              ],
            )
          ],
        );
      } else {
        return Column(
          children: [
            BrandsWidget(height: height * 0.1),
            const Spacer(),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  children: [
                    const Text("An Error Occurred!"),
                    Text(data.errorMessage!),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        );
      }
    }, error: (err, stackTrace) {
      return Center(child: Text("Server Error Occurred: $err"));
    }, loading: () {
      return Column(
        children: [
          BrandsWidget(height: height * 0.1),
          const Spacer(),
          const CircularProgressIndicator(),
          const Spacer(),
        ],
      );
    });
  }
}
