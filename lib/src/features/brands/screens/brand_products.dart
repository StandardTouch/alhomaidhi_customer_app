import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/widgets/product_card.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BrandProducts extends ConsumerWidget {
  const BrandProducts({super.key, required this.brandName});
  final String brandName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(allProductsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(brandName),
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            ref.read(productQueryProvider.notifier).updateBrand(0);
            context.pop();
          },
        ),
      ),
      body: products.when(data: (data) {
        if (data.status == "APP00") {
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
                priceBefore: data.message![index].productDetails!.regularPrice!,
                priceNow: data.message![index].productDetails!.salePrice!,
                discountPercentage:
                    data.message![index].productDetails!.discountPercentage!,
                onButtonPress: () {
                  context.pushNamed(
                    "product_details_screen",
                    pathParameters: {
                      "productId":
                          "${data.message![index].productDetails!.productId!}"
                    },
                  );
                },
              );
            },
          );
        } else {
          return Center(
            child: Text("An Error Occurred ${data.errorMessage}"),
          );
        }
      }, error: (err, stk) {
        return Center(
          child: Text("An Error Occurred $err"),
        );
      }, loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
