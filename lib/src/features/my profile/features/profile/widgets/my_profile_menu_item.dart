import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MyProfileMenuItem extends StatelessWidget {
  const MyProfileMenuItem({
    super.key,
    required this.menuItemLink,
    required this.menuitemName,
    required this.icon,
    this.isDeleteAccount = false,
  });
  final String menuItemLink;
  final String menuitemName;
  final IconData icon;
  final bool isDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.onSecondary,
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        context.push(menuItemLink);
      },
      child: Ink(
        height: DeviceInfo.getDeviceHeight(context) * 0.25,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: DeviceInfo.getDeviceWidth(context) * 0.15,
              backgroundColor: (isDeleteAccount)
                  ? Colors.red
                  : Theme.of(context).scaffoldBackgroundColor,
              child: Icon(
                icon,
                color: (isDeleteAccount)
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                size: 60,
              ),
            ),
            const Gap(10),
            FittedBox(
              child: Text(
                menuitemName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
