import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text(
              "My Account",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [cardBoxShadow],
              ),
              child: Column(
                children: [
                  const Image(image: AssetImage(Assets.profile), width: 100),
                  const Gap(10),
                  Text("Hey, User Name"),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(Assets.myOrders),
                        ),
                        const Gap(20),
                        Text("My Orders")
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(Assets.profile),
                          width: 33,
                        ),
                        const Gap(20),
                        Text("Saved Addresses"),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(Assets.themeMode),
                          width: 33,
                        ),
                        const Gap(20),
                        Text("Theme"),
                        const Gap(30),
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Logout"),
                  ),
                  const Gap(20),
                  const Text(
                    "Delete My Account",
                    style: TextStyle(color: Colors.red),
                  ),
                  const Gap(20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
