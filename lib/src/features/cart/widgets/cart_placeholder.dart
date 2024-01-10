import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartPlaceHolder extends StatelessWidget {
  const CartPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0XFFF5F5F5),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                Assets.protectIcon,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Gap(5),
          const Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                    child: Text(
                  "Safe and secure payments.",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                )),
                FittedBox(
                  child: Text(
                    "100% Authentic Product.",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
