import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});
  // @Zaid - add your code here
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text("My Orders Screen"),
    );
  }
}
