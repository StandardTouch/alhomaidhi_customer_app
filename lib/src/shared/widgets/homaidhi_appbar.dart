import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/widgets/sort_button.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/router/routes.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomaidhiAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomaidhiAppbar({
    super.key,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
    this.isProductScreen = false,
  });
  @override
  final Size preferredSize;
  final bool isProductScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isProductScreen
          ? null
          : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
      title: Image.asset(
        Assets.logoLight,
        fit: BoxFit.contain,
        width: DeviceInfo.getDeviceWidth(context) * 0.35,
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.push("/all_brands");
          },
          icon: Image.asset(
            Assets.brandsButton,
            width: 60,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notification_important_outlined,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SortByButton(),
      ],
    );
  }
}
