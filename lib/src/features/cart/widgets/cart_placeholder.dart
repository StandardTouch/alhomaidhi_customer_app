import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartPlaceHolder extends StatelessWidget {
  const CartPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0XFFF5F5F5),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              Assets.protectIcon,
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
          const Gap(15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Safe and secure payments.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                "100% Authentic Product.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
