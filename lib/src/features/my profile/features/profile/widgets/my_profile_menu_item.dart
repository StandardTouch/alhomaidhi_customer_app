import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyProfiletMenuItem extends ConsumerWidget {
  const MyProfiletMenuItem(
      {super.key,
      required this.menuItemLink,
      required this.menuitemName,
      required this.menuItemImage,
      required this.additionalWidget});

  final String menuItemLink;
  final String menuitemName;
  final String menuItemImage;
  final Widget? additionalWidget;

  @override
  Widget build(context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () async {
          // if (menuItemLink == "/address") {
          //   // ignore: unused_result
          //   await ref.refresh(addressProvider.future);
          // }
          if (!context.mounted) return;
          context.push(menuItemLink);
        },
        leading: Image(
          image: AssetImage(menuItemImage),
          width: 33,
        ),
        title: Text(menuitemName),
        trailing: additionalWidget,
      ),
    );
  }
}
