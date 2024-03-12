import 'package:Alhomaidhi/src/shared/widgets/homaidhi_appbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginToContinueWidget extends StatelessWidget {
  const LoginToContinueWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Please login to continue",
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          const Gap(20),
          ElevatedButton.icon(
            onPressed: () {
              context.go("/login");
            },
            icon: const Icon(Icons.login),
            label: const Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ])));
  }
}
