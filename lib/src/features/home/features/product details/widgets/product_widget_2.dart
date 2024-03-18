import 'package:Alhomaidhi/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:Alhomaidhi/src/utils/exceptions/homaidhi_exception.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductWidget2 extends ConsumerWidget {
  const ProductWidget2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(addressProvider);
    return address.when(data: (data) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text:
                            "${TranslationHelper.translation(context)!.deliveredTo}: ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey,
                            ),
                        children: [
                          TextSpan(
                            text: (data.message!.firstName != "" &&
                                    data.message!.lastName != "")
                                ? "${data.message!.firstName} ${data.message!.lastName}"
                                : TranslationHelper.translation(context)!
                                    .noNameProvided,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          ),
                        ]),
                  ),
                  const Gap(5),
                  Text(
                    (data.message!.address1 != "" &&
                            data.message!.address2 != "")
                        ? "${data.message!.address1}, ${data.message!.address2}"
                        : TranslationHelper.translation(context)!
                            .noAddressProvided,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                        ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  onTap: () {
                    context.push("/address");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    child: Text(TranslationHelper.translation(context)!.change),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }, error: (err, stk) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Text((err is HomaidhiException)
            ? TranslationHelper.translation(context)!.youAreNotSignedIn
            : TranslationHelper.translation(context)!.errorWhileFetchingData),
      );
    }, loading: () {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const CircularProgressIndicator(),
      );
    });
  }
}
