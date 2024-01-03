import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NoNotification extends StatelessWidget {
  const NoNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: DeviceInfo.getDeviceHeight(context) * 0.08,
          ),
          Text("No Notification"),
          SizedBox(
            height: DeviceInfo.getDeviceHeight(context) * 0.08,
          ),
          Center(
              child:
                  Text("We will let you know once we have something for you")),
          SizedBox(
            height: DeviceInfo.getDeviceHeight(context) * 0.08,
          ),
          Image.asset(Assets.noNotification)
        ],
      ),
    );
  }
}
