import 'package:Alhomaidhi/main.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/widgets/brands_widget.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/widgets/product_card.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/services/my_order_details_services.dart';
import 'package:Alhomaidhi/src/shared/providers/loading_provider.dart';
import 'package:Alhomaidhi/src/features/notification/provider/provider.dart';
import 'package:Alhomaidhi/src/shared/widgets/homaidhi_appbar.dart';
import 'package:Alhomaidhi/src/shared/widgets/refresh_button.dart';
import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool noMoreProducts = false;

  @override
  void initState() {
    _initMessaging();
    super.initState();
  }

  Future<void> _initMessaging() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      navigateToOrder(initialMessage.data);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigateToOrder(message.data);
    });
  }

  void navigateToOrder(Map<String, dynamic> data) {
    if (data.containsKey('orderId')) {
      final orderId = data['orderId'];
      final productIndex = data['productIndex'] ?? '0';
      logger.e(orderId);
      getMyOrderDetails(orderId);
      GoRouter.of(context).pushNamed("my_order_details", pathParameters: {
        "orderId": orderId,
        "productIndex": productIndex,
      });
    }
  }

  // Instance of MessagingService for handling notifications
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
    ref.watch(notificationServiceProvider);
    final isLoading = ref.watch(isLoadingProvider);
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
            FlutterNativeSplash.remove();
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
                        (DeviceInfo.getDeviceHeight(context) / 1.2),
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
                      discountPercentage: data
                          .message![index].productDetails!.discountPercentage!,
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
                            const Gap(20),
                            RefreshButton(
                              provider: allProductsProvider,
                              isAllProducts: true,
                            )
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
            FlutterNativeSplash.remove();

            return SizedBox(
                height: DeviceInfo.getDeviceHeight(context) * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("An Error Occurred. Try Refreshing"),
                    const Gap(10),
                    ElevatedButton(
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
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text("Refresh"),
                    )
                  ],
                ));
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
          : Padding(
              padding: const EdgeInsets.only(bottom: 65),
              child: FloatingActionButton(
                onPressed: () {
                  ref.read(productQueryProvider.notifier).updateBrand(0);
                },
                child: const Icon(
                  Icons.clear,
                ),
              ),
            ),
    );
  }
}
