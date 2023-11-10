import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
  var themeMode = false;

  @override
  Widget build(context) {
    final height = DeviceInfo.getDeviceHeight(context);
    final width = DeviceInfo.getDeviceWidth(context);
    ThemeMode themeModeValue = EasyDynamicTheme.of(context).themeMode!;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      // height: height * 0.8,
      width: width,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            height: height * 0.10,
            width: width,
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
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 50,
              right: 50,
              bottom: 0,
            ),
            decoration: BoxDecoration(
              color: (themeModeValue == ThemeMode.dark)
                  ? Colors.black
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38, blurRadius: 0.5, spreadRadius: 1),
              ],
            ),
            height: height * 0.82,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Image(image: AssetImage(Assets.profile), width: 100),
                  const Gap(20),
                  const Text("Hey, User Name"),
                  const Gap(20),
                  const MyAccountMenuItems(
                    menuItemLink: '/address',
                    menuitemName: "Billing Address",
                    menuItemImage: Assets.profile,
                  ),
                  const Gap(20),
                  const MyAccountMenuItems(
                    menuItemLink: 'my_orders',
                    menuitemName: "My Orders",
                    menuItemImage: Assets.myOrders,
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
                      title: Text("Theme"),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: themeMode,
                          onChanged: (value) {
                            setState(() {
                              themeMode = value;
                              if (themeMode) {
                                EasyDynamicTheme.of(context)
                                    .changeTheme(dynamic: false, dark: true);
                              } else {
                                EasyDynamicTheme.of(context)
                                    .changeTheme(dynamic: true, dark: false);
                              }
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    // child: Row(
                    //   children: [
                    //     const Image(
                    //       image: AssetImage(Assets.themeMode),
                    //       width: 33,
                    //     ),
                    //     const Gap(20),
                    //     const Text("Theme"),
                    //     const Gap(30),
                    // Transform.scale(
                    //   scale: 0.8,
                    //   child: Switch(
                    //     value: themeMode,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         themeMode = value;
                    //         if (themeMode) {
                    //           EasyDynamicTheme.of(context)
                    //               .changeTheme(dynamic: false, dark: true);
                    //         } else {
                    //           EasyDynamicTheme.of(context)
                    //               .changeTheme(dynamic: true, dark: false);
                    //         }
                    //       });
                    //     },
                    //     activeColor: Theme.of(context).primaryColor,
                    //   ),
                    // ),
                    //   ],
                    // ),
                  ),
                  const Gap(20),
                  const MyAccountMenuItems(
                    menuItemLink: 'delete_account',
                    menuitemName: "Delete Account",
                    menuItemImage: Assets.myOrders,
                  ),
                  const Gap(50),
                  SizedBox(
                    width: width,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAccountMenuItems extends StatelessWidget {
  const MyAccountMenuItems(
      {super.key,
      required this.menuItemLink,
      required this.menuitemName,
      required this.menuItemImage});

  final String menuItemLink;
  final String menuitemName;
  final String menuItemImage;

  @override
  Widget build(context) {
    return InkWell(
      onTap: () {
        context.push(menuItemLink);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage(menuItemImage),
              width: 33,
            ),
            const Gap(20),
            Text(menuitemName),
          ],
        ),
      ),
    );
  }
}
