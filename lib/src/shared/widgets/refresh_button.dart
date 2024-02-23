import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshButton extends ConsumerStatefulWidget {
  const RefreshButton({super.key, required this.provider});
  final FutureProvider<dynamic> provider;

  @override
  ConsumerState<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends ConsumerState<RefreshButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.refresh),
      label:
          isLoading ? const CircularProgressIndicator() : const Text("Refresh"),
      onPressed: isLoading
          ? null
          : () async {
              try {
                setState(() {
                  isLoading = true;
                });
                // ignore: unused_result
                await ref.refresh(widget.provider.future);
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
