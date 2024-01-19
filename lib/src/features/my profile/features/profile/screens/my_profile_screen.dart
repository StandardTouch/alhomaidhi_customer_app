import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/profile/widgets/my_profile_menu_item.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyProfileScreen();
  }
}

class _MyProfileScreen extends State<MyProfileScreen> {
  void logout() async {
    const storage = FlutterSecureStorage();
    storage.delete(key: "token");
    storage.delete(key: "userId");
    context.go("/login");
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Gap(30),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 50,
                right: 50,
                bottom: 0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
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
                      additionalWidget:
                          Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    const Gap(20),
                    const MyProfiletMenuItem(
                      menuItemLink: '/my_orders',
                      menuitemName: "My Orders",
                      menuItemImage: Assets.myOrders,
                      additionalWidget:
                          Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    const Gap(20),
                    const MyProfiletMenuItem(
                      menuItemLink: '/my_invoices',
                      menuitemName: "My Invoices",
                      menuItemImage: Assets.invoice,
                      additionalWidget:
                          Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    const Gap(20),
                    const MyProfiletMenuItem(
                      menuItemLink: '/delete_profile',
                      menuitemName: "Delete Account",
                      menuItemImage: Assets.delete,
                      additionalWidget:
                          Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                    const Gap(30),
                    SizedBox(
                      width: DeviceInfo.getDeviceWidth(context),
                      child: ElevatedButton(
                        onPressed: logout,
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
      ),
    );
  }
}
