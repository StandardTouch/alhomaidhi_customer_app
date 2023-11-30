import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/profile/widgets/my_profile_menu_item.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyProfileScreen();
  }
}

// @kahkashan
// Add list tile widget for billing address to my orders and delete account

class _MyProfileScreen extends State<MyProfileScreen> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(context) {
    // ThemeMode themeModeValue = EasyDynamicTheme.of(context).themeMode!;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "My Account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        const Gap(30),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 50,
              right: 50,
              bottom: 0,
            ),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38, blurRadius: 0.5, spreadRadius: 1),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Image(image: AssetImage(Assets.profile), width: 100),
                  const Gap(20),
                  const Text("Hey, User Name"),
                  const Gap(20),
                  const MyProfiletMenuItem(
                    menuItemLink: '/address',
                    menuitemName: "Billing Address",
                    menuItemImage: Assets.profile,
                    additionalWidget: Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                  const Gap(20),
                  const MyProfiletMenuItem(
                    menuItemLink: 'my_orders',
                    menuitemName: "My Orders",
                    menuItemImage: Assets.myOrders,
                    additionalWidget: Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Image(
                        image: AssetImage(Assets.themeMode),
                        width: 33,
                      ),
                      title: const Text("Theme"),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            setState(() {
                              value
                                  ? EasyDynamicTheme.of(context)
                                      .changeTheme(dynamic: false, dark: true)
                                  : EasyDynamicTheme.of(context)
                                      .changeTheme(dynamic: true, dark: false);
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  const MyProfiletMenuItem(
                    menuItemLink: 'delete_account',
                    menuitemName: "Delete Account",
                    menuItemImage: Assets.delete,
                    additionalWidget: Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                  const Gap(30),
                  SizedBox(
                    width: DeviceInfo.getDeviceWidth(context),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Logout"),
                    ),
                  ),
                  const Gap(30),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
