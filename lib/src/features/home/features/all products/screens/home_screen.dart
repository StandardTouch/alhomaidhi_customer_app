import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/widgets/brands_widget.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/widgets/product_card.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/homaidhi_appbar.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      appBar: const HomaidhiAppbar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: height * 0.1,
            child: const BrandsWidget(),
          ),
          products.when(data: (data) {
            if (data.status == "APP00") {
              if (data.message!.length < 100) {
                noMoreProducts = true;
              } else {
                noMoreProducts = false;
              }
              return GridView.builder(
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
                      onButtonPress: () {
                        context.pushNamed("product_details_screen",
                            pathParameters: {
                              "productId":
                                  "${data.message![index].productDetails!.productId!}"
                            });
                      },
                    );
                  });
            } else {
              return SizedBox(
                height: DeviceInfo.getDeviceHeight(context) * 0.7,
                child: Column(
                  children: [
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
                ),
              );
            }
          }, loading: () {
            return SizedBox(
              height: DeviceInfo.getDeviceHeight(context) * 0.7,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }, error: (err, stk) {
            return Center(child: Text("Server Error Occurred: $err"));
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
                icon: const Icon(Icons.arrow_circle_right),
                label: const Text("next"),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: (query.brandId == 0)
          ? const SizedBox.shrink()
          : FloatingActionButton(
              onPressed: () {
                ref.read(productQueryProvider.notifier).updateBrand(0);
              },
              child: const Icon(
                Icons.clear,
              ),
            ),
    );
  }
}
