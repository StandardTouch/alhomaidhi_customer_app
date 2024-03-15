import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SuccessPaymentScreen extends StatelessWidget {
  const SuccessPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.thumbsUpIcon),
          Text(
            TranslationHelper.translation(context)!.orderSuccessful,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green[800],
                ),
          ),
          const Gap(5),
          Text(
            TranslationHelper.translation(context)!.thankYou,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
          ),
          const Gap(5),
          Text(
            TranslationHelper.translation(context)!.orderOnWay,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 25,
                ),
          ),
          const Gap(30),
          SizedBox(
            width: DeviceInfo.getDeviceWidth(context) * 0.7,
            child: ElevatedButton(
                onPressed: () {
                  context.go("/my_orders");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: FittedBox(
                  child: Text(
                    TranslationHelper.translation(context)!.myOrders,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
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
              child: FittedBox(
                  child: Text(TranslationHelper.translation(context)!
                      .viewOtherProducts)),
            ),
          ),
        ],
      ),
    );
  }
}
