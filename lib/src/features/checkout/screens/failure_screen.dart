import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FailurePaymentScreen extends StatelessWidget {
  const FailurePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.close_rounded,
              color: Colors.red,
              size: DeviceInfo.getDeviceWidth(context) / 3,
            ),
            Text(
              "Uh Oh! Order Failed",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red[800],
                  ),
            ),
            const Gap(5),
            Text(
              "Please Try Again",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
            ),
            const Gap(30),
            SizedBox(
              width: DeviceInfo.getDeviceWidth(context) * 0.7,
              child: ElevatedButton(
                  onPressed: () {
                    context.go("/cart");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const FittedBox(
                    child: Text(
                      "My Cart",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )),
            ),
            const Gap(10),
            SizedBox(
              width: DeviceInfo.getDeviceWidth(context) * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  context.go("/home");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const FittedBox(child: Text("Go Back Home")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
