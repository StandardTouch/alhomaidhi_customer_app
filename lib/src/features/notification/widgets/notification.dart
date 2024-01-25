import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SingleNotification extends StatelessWidget {
  const SingleNotification(
      {super.key,
      required this.title,
      required this.body,
      required this.sentTime,
      required this.imageUrl});
  final String? title;
  final String? body;
  final DateTime? sentTime;
  final String? imageUrl;

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
          child: FittedBox(
            fit: BoxFit.fitHeight,
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
                      Column(
                        children: [
                          const Gap(2),
                          Image.network(
                            imageUrl!,
                            fit: BoxFit.fill,
                            height: 90,
                            width: 90,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Gap(140),
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
                          Text(body!,
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
