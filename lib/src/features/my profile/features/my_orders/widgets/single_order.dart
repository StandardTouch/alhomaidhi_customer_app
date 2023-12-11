import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';

class SingleOrderCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final Function() onPressed;
  final String? orderStatus;
  final borderRadius = const BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    topLeft: Radius.circular(10),
  );

  const SingleOrderCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.onPressed,
      required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: DeviceInfo.getDeviceHeight(context) * 0.1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 4),
              width: 60,
              height: 60,
              child: Image.network(
                imageUrl!,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: orderStatus == 'wc-processing'
                            ? Color.fromARGB(255, 3, 104, 45)
                            : Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
