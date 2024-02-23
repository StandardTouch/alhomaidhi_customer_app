import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/services/my_order_details_services.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SingleNotification extends StatelessWidget {
  const SingleNotification(
      {super.key,
      required this.title,
      required this.body,
      required this.sentTime,
      required this.imageUrl,
      required this.orderId,
      required this.productIndex});
  final String? title;
  final String? body;
  final DateTime? sentTime;
  final String? imageUrl;
  final String? orderId;
  final String? productIndex;

  String timeAgo(DateTime? dateTime) {
    final Duration difference = DateTime.now().difference(dateTime!);

    if (difference.inDays > 1) {
      return '${difference.inDays}days ago';
    } else if (difference.inDays == 1) {
      return '1day ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}mins ago';
    } else {
      return 'Just now';
    }
  }

  String getStatus(String title) {
    switch (title) {
      case 'wc-processing':
        title = "Order Processing'";
        break;

      case 'wc-order-approve':
        title = "Order Confirmation";
        break;

      case 'wc-out-for-delivery':
        title = "Order Shipped";
        break;
      case 'wc-completed':
        title = "Order Delivered"; // All stages completed
        break;
    }
    return title;
  }

  String extractEnglish(String productName) {
    RegExp regExp = RegExp(r'[A-Za-z ]+');
    Iterable<RegExpMatch> matches = regExp.allMatches(productName);

    return matches.map((match) => match.group(0)).join();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            getMyOrderDetails(orderId);
            context.pushNamed(
              "my_order_details",
              pathParameters: {
                "orderId": orderId!,
                "productIndex": productIndex!,
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: DeviceInfo.getDeviceWidth(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getStatus(title!),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.fill,
                        height: 90,
                        width: 90,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Gap(140),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                timeAgo(
                                  sentTime,
                                ),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const Gap(15),
                          Text(
                            extractEnglish(body!),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          const Gap(1),
                          FittedBox(
                            child: Text(
                              body!,
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
