import 'package:Alhomaidhi/src/features/my%20profile/features/profile/widgets/my_profile_menu_item.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
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
    storage.delete(key: "username");
    storage.delete(key: "full_name");
        storage.delete(key: "masterCustomerId");

    context.go("/login");
  }

  Future<String> getUserName() async {
    const storage = FlutterSecureStorage();
    final String userName = await storage.read(key: "full_name") ?? "User";
    return userName;
  }

  @override
  Widget build(context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white),
          ),
          forceMaterialTransparency: true,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: logout,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  height: DeviceInfo.getDeviceHeight(context) * 0.2,
                ),
                Gap(DeviceInfo.getDeviceHeight(context) * 0.15),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: MyProfileMenuItem(
                              menuItemLink: "/address",
                              menuitemName: "My Address",
                              icon: Icons.location_city,
                            ),
                          ),
                          Gap(10),
                          Expanded(
                            flex: 1,
                            child: MyProfileMenuItem(
                              menuItemLink: "/my_orders",
                              menuitemName: "My Orders",
                              icon: Icons.list,
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: MyProfileMenuItem(
                              menuItemLink: "/my_invoices",
                              menuitemName: "My Invoices",
                              icon: Icons.receipt_outlined,
                            ),
                          ),
                          Gap(10),
                          Expanded(
                            flex: 1,
                            child: MyProfileMenuItem(
                              isDeleteAccount: true,
                              menuItemLink: "/delete_profile",
                              menuitemName: "Delete Account",
                              icon: Icons.delete_forever,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),

            // profile card
            Positioned(
                right: 0,
                left: 0,
                top: DeviceInfo.getDeviceHeight(context) * 0.2 / 2,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.3))
                    ],
                  ),
                  height: DeviceInfo.getDeviceHeight(context) * 0.2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(
                            Icons.account_circle,
                            size: 50,
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: getUserName(),
                          builder: (context, snapshot) {
                            return Text(
                              "Hello, ${snapshot.data}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            );
                          }),
                    ],
                  ),
                ))
          ],
        )

        //  Expanded(
        //   child: Container(
        //     padding: const EdgeInsets.only(
        //       top: 50,
        //       left: 50,
        //       right: 50,
        //       bottom: 0,
        //     ),
        //     decoration: const BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(25),
        //         topRight: Radius.circular(25),
        //       ),
        //       boxShadow: [
        //         BoxShadow(
        //             color: Colors.black38, blurRadius: 0.5, spreadRadius: 1),
        //       ],
        //     ),
        //     child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           CircleAvatar(
        //             radius: 60,
        //             backgroundColor: Theme.of(context).primaryColor,
        //             child: const Icon(
        //               Icons.account_circle,
        //               size: 120,
        //             ),
        //           ),
        //           const Gap(20),
        //           FutureBuilder(
        //               future: getUserName(),
        //               builder: (context, snapshot) {
        //                 return Text("Hey, ${snapshot.data}");
        //               }),
        //           const Gap(20),
        //           const MyProfiletMenuItem(
        //             menuItemLink: '/address',
        //             menuitemName: "Billing Address",
        //             menuItemImage: Assets.profile,
        //             additionalWidget: Icon(Icons.keyboard_arrow_right_rounded),
        //           ),
        //           const Gap(20),
        //           const MyProfiletMenuItem(
        //             menuItemLink: '/my_orders',
        //             menuitemName: "My Orders",
        //             menuItemImage: Assets.myOrders,
        //             additionalWidget: Icon(Icons.keyboard_arrow_right_rounded),
        //           ),
        //           const Gap(20),
        //           const MyProfiletMenuItem(
        //             menuItemLink: '/my_invoices',
        //             menuitemName: "My Invoices",
        //             menuItemImage: Assets.invoice,
        //             additionalWidget: Icon(Icons.keyboard_arrow_right_rounded),
        //           ),
        //           const Gap(20),
        //           const MyProfiletMenuItem(
        //             menuItemLink: '/delete_profile',
        //             menuitemName: "Delete Account",
        //             menuItemImage: Assets.delete,
        //             additionalWidget: Icon(Icons.keyboard_arrow_right_rounded),
        //           ),
        //           const Gap(30),
        //           SizedBox(
        //             width: DeviceInfo.getDeviceWidth(context),
        //             child: ElevatedButton(
        //               onPressed: logout,
        //               child: const Text("Logout"),
        //             ),
        //           ),
        //           const Gap(100),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
