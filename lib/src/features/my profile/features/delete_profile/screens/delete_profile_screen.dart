import 'package:Alhomaidhi/src/features/my%20profile/features/delete_profile/provider/delete_profile_provider.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class DeleteProfileScreen extends ConsumerStatefulWidget {
  const DeleteProfileScreen({super.key});

  @override
  ConsumerState<DeleteProfileScreen> createState() {
    return _DeleteProfileScreen();
  }
}

class _DeleteProfileScreen extends ConsumerState<DeleteProfileScreen> {
  @override
  Widget build(context) {
    final deleteProfileNotify = ref.read(deleteProfileNotifier.notifier);
    final deleteProfileWatcher = ref.watch(deleteProfileNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delete Profile",
        ),
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: DeviceInfo.getDeviceWidth(context),
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
                bottom: 0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38, blurRadius: 0.5, spreadRadius: 1),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Precautionary Notice: Deleting Your Account",
                        style: Theme.of(context).textTheme.labelLarge),
                    const Gap(10),
                    Text(
                      "Before proceeding with the account deletion process, we want to ensure that you are fully aware of the consequences and implications of this action. Deleting your account is an irreversible step and will result in the permanent removal of all your personal information, account history, and associated data from our platform.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(20),
                    Text(
                      "Loss of Data and Access",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Gap(10),
                    Text(
                      "By deleting your account, you will lose access to all features and services tied to your account. This includes order history, preferences, and any personalized settings you have configured. Additionally, any content you have created or uploaded, such as reviews or comments, will be permanently removed from our platform. Please make sure to download or save any crucial information before initiating the account deletion process.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(20),
                    Text(
                      "Impact on Services",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Gap(10),
                    Text(
                      "Deleting your account means the termination of your relationship with our platform. You will no longer be eligible for any benefits, promotions, or exclusive offers associated with your account. If you have any active subscriptions or memberships, those services will be discontinued, and any remaining credits or balances may be forfeited. Take a moment to review your current subscriptions and ensure you have made necessary arrangements before proceeding.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(20),
                    Text(
                      "Account Recovery and Future Access",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Gap(10),
                    Text(
                      "Once your account is deleted, you will not be able to recover it, and any attempts to do so will be unsuccessful. If you ever decide to return to our platform, you will need to create a new account and start afresh. Keep in mind that your previous account information, including usernames and email addresses, will no longer be available for reuse. Consider the implications of starting anew and whether this aligns with your future intentions.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(10),
                    SizedBox(
                      width: DeviceInfo.getDeviceWidth(context),
                      child: ElevatedButton(
                        onPressed: deleteProfileWatcher.isBtnDisable
                            ? null
                            : () {
                                deleteProfileNotify.deleteProfile(context);
                              },
                        child: deleteProfileWatcher.isBtnDisable
                            ? const CircularProgressIndicator()
                            : const Text("Delete Profile"),
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
