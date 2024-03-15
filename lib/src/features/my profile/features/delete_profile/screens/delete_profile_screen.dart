import 'package:Alhomaidhi/src/features/my%20profile/features/delete_profile/provider/delete_profile_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/auth_provider.dart';
import 'package:Alhomaidhi/src/shared/widgets/login_to_continue_widget.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
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
    final isLoggedIn = ref.watch(authProvider);
    if (!isLoggedIn) {
      return const LoginToContinueWidget();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationHelper.translation(context)!.deleteProfile,
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
                    Text(
                      TranslationHelper.translation(context)!
                          .precautionaryNotice,
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    Text(
                      TranslationHelper.translation(context)!
                          .beforeProceedingWithAccount,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(20),
                    Text(
                      TranslationHelper.translation(context)!
                          .lossOfDataAndAccess,
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    Text(
                      TranslationHelper.translation(context)!
                          .byDeletingYourAccount,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(20),
                    Text(
                      TranslationHelper.translation(context)!.impactOnServices,
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    Text(
                      TranslationHelper.translation(context)!
                          .deletingYourAccountMeans,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(20),
                    Text(
                      TranslationHelper.translation(context)!
                          .accountRecoveryAndFutureAccess,
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    Text(
                      TranslationHelper.translation(context)!
                          .onceYourAccountIsDeleted,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(10),
                    SizedBox(
                      width: DeviceInfo.getDeviceWidth(context),
                      child: ElevatedButton(
                        onPressed: deleteProfileWatcher.isBtnDisable
                            ? null
                            : () {
                                deleteProfileNotify.deleteProfile(context, ref);
                              },
                        child: deleteProfileWatcher.isBtnDisable
                            ? const CircularProgressIndicator()
                            : Text(TranslationHelper.translation(context)!
                                .deleteProfile),
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
