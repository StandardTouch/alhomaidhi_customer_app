import 'package:alhomaidhi_customer_app/src/features/checkout/widgets/choose_payment_widget.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tamara_sdk/tamara_sdk.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.totalBal,
  });
  final String totalBal;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        forceMaterialTransparency: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const AddressWidget(),
          const Gap(10),
          ChoosePayment(
            onSelected: (value) {},
          ),
        ],
      ),
    );
  }
}
