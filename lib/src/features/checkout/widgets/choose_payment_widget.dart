import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

enum PaymentType { HYPERGATEWAY, TAMARA, TABBY }

// Define a callback type for better readability
typedef PaymentSelectionCallback = void Function(PaymentType);

class ChoosePayment extends ConsumerStatefulWidget {
  final PaymentSelectionCallback onSelected;

  const ChoosePayment({super.key, required this.onSelected});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChoosePaymentState();
}

class _ChoosePaymentState extends ConsumerState<ChoosePayment> {
  PaymentType paymentType = PaymentType.HYPERGATEWAY;

  void _handlePaymentSelection(PaymentType selectedType) {
    if (selectedType != paymentType) {
      setState(() {
        paymentType = selectedType;
      });
      widget.onSelected(selectedType); // Invoke the callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Choose Your Payment Method"),
          const Gap(10),
          RadioListTile<PaymentType>(
            value: PaymentType.HYPERGATEWAY,
            onChanged: (_) => _handlePaymentSelection(PaymentType.HYPERGATEWAY),
            groupValue: paymentType,
            title: Row(
              children: [
                Expanded(
                  child: Image.asset(Assets.hyperPayLogo),
                ),
                const Spacer(),
              ],
            ),
          ),
          RadioListTile<PaymentType>(
            value: PaymentType.TABBY,
            onChanged: (_) => _handlePaymentSelection(PaymentType.TABBY),
            groupValue: paymentType,
            title: Row(
              children: [
                Expanded(child: Image.asset(Assets.tabbyIcon)),
                const Spacer(),
              ],
            ),
          ),
          RadioListTile<PaymentType>(
            value: PaymentType.TAMARA,
            onChanged: (_) => _handlePaymentSelection(PaymentType.TAMARA),
            groupValue: paymentType,
            title: Row(
              children: [
                Expanded(
                  child: Image.asset(
                    Assets.tamaraIcon,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
