import 'package:alhomaidhi_customer_app/src/features/home/providers/products_provider.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortByButton extends ConsumerStatefulWidget {
  const SortByButton({super.key});

  @override
  ConsumerState<SortByButton> createState() => _SortByButtonState();
}

class _SortByButtonState extends ConsumerState<SortByButton> {
  List<PopupMenuEntry<String>> menuItems = const [
    PopupMenuItem(
      value: 'asc',
      child: Text('Earliest first'),
    ),
    PopupMenuItem(
      value: 'desc',
      child: Text('Latest Release'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final query = ref.read(productQueryProvider.notifier);
    return PopupMenuButton(
      icon: Image.asset(
        Assets.sort,
        height: 25,
      ),
      initialValue: null,
      itemBuilder: (context) {
        return menuItems;
      },
      onSelected: (value) {
        query.updateSort(value ?? "");
      },
    );
  }
}
