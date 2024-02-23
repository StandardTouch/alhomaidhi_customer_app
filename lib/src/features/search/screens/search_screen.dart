import 'package:Alhomaidhi/main.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/widgets/product_card.dart';
import 'package:Alhomaidhi/src/shared/providers/loading_provider.dart';
import 'package:Alhomaidhi/src/shared/widgets/homaidhi_appbar.dart';
import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(allProductsProvider);
    final query = ref.read(productQueryProvider.notifier);
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
        appBar: const HomaidhiAppbar(),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextField(
                controller: searchController,
                enabled: true,
                autofocus: true,
                decoration: searchInputDecoration(),
                onSubmitted: (search) {
                  query.updateSearch(search);
                },
              ),
            ),
            products.when(data: (data) {
              if (data.status == "APP00") {
                return ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    GridView.builder(
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: data.message!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: DeviceInfo.getDeviceWidth(context) /
                              (DeviceInfo.getDeviceHeight(context) / 1.5),
                        ),
                        itemBuilder: (ctx, index) {
                          return ProductCard(
                            imageUrl: data.message![index].images!.isEmpty
                                ? Assets.fallBackProductImage
                                : data.message![index].images![0].src!,
                            title: data.message![index].productDetails!.name!,
                            priceBefore: data
                                .message![index].productDetails!.regularPrice!,
                            priceNow:
                                data.message![index].productDetails!.price!,
                            isSearch: true,
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
                        }),
                  ],
                );
              } else {
                return SizedBox(
                  height: DeviceInfo.getDeviceHeight(context) * 0.8,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data.errorMessage!),
                      ],
                    ),
                  ),
                );
              }
            }, error: (err, stk) {
              return SizedBox(
                height: DeviceInfo.getDeviceHeight(context) * 0.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("An Error Occurred"),
                      const Gap(15),
                      ElevatedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () async {
                                globalContainer
                                    .read(isLoadingProvider.notifier)
                                    .state = true;
                                try {
                                  // ignore: unused_result
                                  await ref.refresh(allProductsProvider.future);
                                } catch (_) {
                                } finally {
                                  globalContainer
                                      .read(isLoadingProvider.notifier)
                                      .state = false;
                                }
                              },
                        icon: const Icon(Icons.refresh),
                        label: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Text("Refresh"),
                      )
                    ],
                  ),
                ),
              );
            }, loading: () {
              return SizedBox(
                height: DeviceInfo.getDeviceHeight(context) * 0.8,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            })
          ],
        ));
  }

  InputDecoration searchInputDecoration() {
    return InputDecoration(
      labelText: "Search Products",
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      fillColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
