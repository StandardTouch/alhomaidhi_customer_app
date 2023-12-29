import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tamara_sdk/tamara_sdk.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({
    super.key,
    required this.totalBal,
  });
  final String totalBal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: ListView(),
    );
  }
}
