import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SingleOrderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Function() onPressed;
  var borderRadius = const BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    topLeft: Radius.circular(10),
  );
  SingleOrderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: DeviceInfo.getDeviceHeight(context) * 0.1,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
            borderRadius: borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              width: 82,
              height: 82,
              child: Image.network(imageUrl),
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(start: 20),
              height: DeviceInfo.getDeviceHeight(context) * 0.1,
              width: DeviceInfo.getDeviceHeight(context) * 0.33,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
