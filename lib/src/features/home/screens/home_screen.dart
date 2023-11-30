import 'package:alhomaidhi_customer_app/src/features/home/models/query_model.dart';
import 'package:alhomaidhi_customer_app/src/features/home/providers/brands_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/providers/products_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/widgets/brands_widget.dart';
import 'package:alhomaidhi_customer_app/src/features/home/widgets/product_card.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final allProductsQuery = AllProductsQuery(pageNo: 1, search: "", sortBy: "");
  @override
  Widget build(BuildContext context) {
    final height = DeviceInfo.getDeviceHeight(context);
    final products = ref.watch(allProductsProvider(allProductsQuery));
    ref.watch(brandsProvider);
    return products.when(data: (data) {
      if (data.status == "APP00") {
        return
            // add search widget
            // add brands widget

            ListView(
          children: [
            BrandsWidget(height: height * 0.2),
            GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7
                    // mainAxisExtent: DeviceInfo.getDeviceHeight(context) * 0.35,
                    ),
                itemCount: data.message!.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    imageUrl: data.message![index].images![0].src!,
                    title: data.message![index].productDetails!.name!,
                    priceBefore:
                        data.message![index].productDetails!.regularPrice!,
                    priceNow: data.message![index].productDetails!.salePrice!,
                  );
                }),
          ],
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
    }, error: (err, stackTrace) {
      return Center(child: Text("Server Error Occurred: $err"));
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
