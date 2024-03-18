import 'package:Alhomaidhi/main.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/providers/orders_provider.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/widgets/single_order.dart';
import 'package:Alhomaidhi/src/shared/providers/auth_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/loading_provider.dart';
import 'package:Alhomaidhi/src/shared/widgets/login_to_continue_widget.dart';
import 'package:Alhomaidhi/src/shared/widgets/refresh_button.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});

  String formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  void onRefresh(WidgetRef ref) async {
    globalContainer.read(isLoadingProvider.notifier).state = true;

    try {
      // ignore: unused_result
      await ref.refresh(myOrdersListProvider.future);
    } catch (_) {
    } finally {
      globalContainer.read(isLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myOrders = ref.watch(myOrdersListProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final isLoggedIn = ref.watch(authProvider);
    if (!isLoggedIn) {
      return const LoginToContinueWidget();
    }

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return myOrders.when(
      data: (data) {
        if (data.status == "APP00") {
          return Scaffold(
            appBar: AppBar(
              title: Text(TranslationHelper.translation(context)!.myOrders),
              forceMaterialTransparency: true,
              actions: context.canPop()
                  ? null
                  : [
                      IconButton(
                        onPressed: () {
                          context.go("/home");
                        },
                        icon: const Icon(Icons.home),
                      )
                    ],
            ),
            body: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  // ignore: unused_result
                  await ref.refresh(myOrdersListProvider.future);
                },
                child: ListView.builder(
                  itemCount: data.message!.length,
                  itemBuilder: (context, index) {
                    String? orderId =
                        data.message![index].orderDetails!.orderId;
                    String? orderStatus =
                        data.message![index].orderDetails!.orderStatus;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.message![index].items!.length,
                      itemBuilder: (context, indexItem) {
                        var item = data.message![index].items![indexItem];
                        return SingleOrderCard(
                          isOrderPending: (orderStatus == 'wc-pending'),
                          imageUrl: item.image,
                          title: (orderStatus == 'wc-completed')
                              ? TranslationHelper.translation(context)!
                                  .orderDelivered
                              : (orderStatus == 'wc-pending')
                                  ? TranslationHelper.translation(context)!
                                      .orderPending
                                  : TranslationHelper.translation(context)!
                                      .orderProcessing,
                          subtitle: item.itemName ?? 'No subtitle',
                          orderStatus:
                              data.message![index].orderDetails!.orderStatus,
                          onPressed: (orderStatus == 'wc-pending')
                              ? null
                              : () {
                                  ref.invalidate(myOrderDetailsProvider);
                                  context.pushNamed("my_order_details",
                                      pathParameters: {
                                        "orderId": orderId!,
                                        "productIndex": "$indexItem",
                                      });
                                },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              actions: context.canPop()
                  ? null
                  : [
                      IconButton(
                        onPressed: () {
                          context.go("/home");
                        },
                        icon: const Icon(Icons.home),
                      )
                    ],
              title: Text(TranslationHelper.translation(context)!.noOrders),
            ),
            body: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data.errorMessage ??
                      TranslationHelper.translation(context)!.unknownError),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {
                      onRefresh(ref);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:
                        Text(TranslationHelper.translation(context)!.refresh),
                  )
                ],
              ),
            ),
          );
        }
      },
      error: (err, stk) => Scaffold(
          appBar: AppBar(
            title: Text(TranslationHelper.translation(context)!.myOrders),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(TranslationHelper.translation(context)!.serverErrorOccurred),
              RefreshButton(provider: myOrdersListProvider),
            ],
          ))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
