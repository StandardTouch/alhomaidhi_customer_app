import 'package:Alhomaidhi/main.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/loading_provider.dart';
import 'package:Alhomaidhi/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddressWidget extends ConsumerWidget {
  const AddressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(addressProvider);
    final isLoading = ref.watch(isLoadingProvider);
    return address.when(
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (data.message!.firstName != "" && data.message!.lastName != "")
                    ? "Delivered to: ${data.message!.firstName!} ${data.message!.lastName!}"
                    : "Delivered to User",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Gap(5),
              Text(
                (data.message!.address1 != "" && data.message!.address2 != "")
                    ? "${data.message!.address1}, ${data.message!.address2}"
                    : "Please add address",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                    ),
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (data.message!.city != "" && data.message!.country != "")
                        ? "${data.message!.city}, ${data.message!.country!}"
                        : "",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: (data.message!.address1 == "" &&
                                data.message!.address2 == "")
                            ? Colors.red
                            : Colors.black,
                      ),
                      onPressed: () {
                        context.push("/address");
                      },
                      icon: const Icon(Icons.change_circle),
                      label: Text(
                        (data.message!.address1 == "" &&
                                data.message!.address2 == "")
                            ? "Add Address"
                            : "Change",
                      ))
                ],
              ),
            ],
          );
        },
        error: (err, stk) {
          if (err is HomaidhiException) {
            return Row(
              children: [
                const Expanded(
                    flex: 3,
                    child: Text("Error getting Address, try refreshing")),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                try {
                                  globalContainer
                                      .read(isLoadingProvider.notifier)
                                      .state = true;

                                  await ref.refresh(addressProvider.future);
                                } catch (_) {
                                } finally {
                                  globalContainer
                                      .read(isLoadingProvider.notifier)
                                      .state = false;
                                }
                              },
                        icon: isLoading
                            ? const CircularProgressIndicator()
                            : Icon(Icons.refresh))),
              ],
            );
          }
          return Text(
            "An error occurred $err",
            style: Theme.of(context).textTheme.bodyMedium,
          );
        },
        loading: () => const LinearProgressIndicator());
  }
}
