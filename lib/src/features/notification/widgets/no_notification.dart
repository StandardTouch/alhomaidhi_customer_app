import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';

class NoNotification extends StatelessWidget {
  const NoNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: DeviceInfo.getDeviceHeight(context) * 0.08,
          ),
          Text("No Notifications!",
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(
            height: DeviceInfo.getDeviceHeight(context) * 0.08,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "We will let you know once we have something for you",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: DeviceInfo.getDeviceHeight(context) * 0.08,
          ),
          Image.asset(Assets.noNotification)
        ],
      ),
    );
  }
}
