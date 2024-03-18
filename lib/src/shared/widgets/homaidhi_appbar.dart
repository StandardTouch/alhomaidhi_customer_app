import 'package:Alhomaidhi/src/features/home/features/all%20products/widgets/sort_button.dart';
import 'package:Alhomaidhi/src/shared/providers/language_provider.dart';
import 'package:Alhomaidhi/src/utils/config/router/routes.dart';
import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomaidhiAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const HomaidhiAppbar({
    super.key,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
    this.isProductScreen = false,
  });
  @override
  final Size preferredSize;
  final bool isProductScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(languageProvider);
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
            isArabic ? Assets.brandsButtonAr : Assets.brandsButton,
            width: 60,
          ),
        ),
        IconButton(
          onPressed: () {
            context.push("/notifications");
          },
          icon: Icon(
            Icons.notifications_on,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SortByButton(),
      ],
    );
  }
}
