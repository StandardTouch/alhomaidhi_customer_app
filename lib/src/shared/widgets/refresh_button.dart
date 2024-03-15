// ignore_for_file: unused_result

import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/brands_provider.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshButton extends ConsumerStatefulWidget {
  const RefreshButton({
    super.key,
    required this.provider,
    this.isAllProducts = false,
  });
  final FutureProvider<dynamic> provider;
  final bool isAllProducts;

  @override
  ConsumerState<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends ConsumerState<RefreshButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.refresh),
      label: isLoading
          ? const CircularProgressIndicator()
          : Text(TranslationHelper.translation(context)!.refresh),
      onPressed: isLoading
          ? null
          : () async {
              try {
                setState(() {
                  isLoading = true;
                });

                await ref.refresh(widget.provider.future);
                if (widget.isAllProducts) {
                  await ref.refresh(brandsProvider.future);
                }
              } catch (_) {
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            },
    );
  }
}
