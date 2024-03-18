import 'package:Alhomaidhi/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/auth_provider.dart';
import 'package:Alhomaidhi/src/shared/widgets/form_input.dart';
import 'package:Alhomaidhi/src/shared/widgets/login_to_continue_widget.dart';
import 'package:Alhomaidhi/src/shared/widgets/refresh_button.dart';
import 'package:Alhomaidhi/src/utils/constants/cities.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/device_info.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:Alhomaidhi/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:searchfield/searchfield.dart';

class BillingAddress extends ConsumerStatefulWidget {
  const BillingAddress({super.key});

  @override
  ConsumerState<BillingAddress> createState() {
    return _BillingAddress();
  }
}

class _BillingAddress extends ConsumerState<BillingAddress> {
  final formkey = GlobalKey<FormState>();

  dynamic checkCityName(String city) {
    if (city != "") {
      return SearchFieldListItem(city);
    }
    return null;
  }

  @override
  Widget build(context) {
    final queryParams = GoRouter.of(context)
        .routeInformationProvider
        .value
        .uri
        .query; // Gets the query part
// from=/
    logger.i(queryParams);
    final addressGetProvider = ref.watch(addressProvider);

    final addressUpdateNotifier = ref.read(addressNotifier.notifier);
    final addressWatcher = ref.watch(addressNotifier);
    final isLoggedIn = ref.watch(authProvider);
    if (!isLoggedIn) {
      return const LoginToContinueWidget();
    }

    return addressGetProvider.when(
      data: (data) {
        if (data.status == "APP00") {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                TranslationHelper.translation(context)!.billingDetails,
              ),
              forceMaterialTransparency: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
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
                            color: Colors.black38,
                            blurRadius: 0.5,
                            spreadRadius: 1),
                      ],
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // ignore: unused_result
                        await ref.refresh(addressProvider.future);
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (queryParams == "from=/")
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    TranslationHelper.translation(context)!
                                        .weNeedYourBillingDetails),
                              ),
                            Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  const Gap(10),
                                  FormInput(
                                    value: data.message!.email,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .emailAddress,
                                    type: TextInputType.emailAddress,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {},
                                    readOnly: true,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.phone,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .mobileNumber,
                                    type: TextInputType.number,
                                    prefix: "+966 ",
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {},
                                    readOnly: true,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.firstName,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .firstName,
                                    type: TextInputType.name,
                                    isRequired: true,
                                    validator: (value) {
                                      return firstNameValidator(context, value);
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateFirstName(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.lastName,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .lastName,
                                    isRequired: true,
                                    type: TextInputType.name,
                                    validator: (value) {
                                      return lastNameValidator(context, value);
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateLastName(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  SearchField(
                                    initialValue: SearchFieldListItem(
                                      ((data.message!.city == "")
                                          ? cities[0]
                                          : data.message!.city!),
                                    ),
                                    suggestions: cities
                                        .map((e) => SearchFieldListItem(e))
                                        .toList(),
                                    suggestionState: Suggestion.expand,
                                    textInputAction: TextInputAction.next,
                                    hint:
                                        TranslationHelper.translation(context)!
                                            .cityState,
                                    searchStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                    validator: (value) {
                                      if (!cities.contains(value) ||
                                          value!.isEmpty) {
                                        return TranslationHelper.translation(
                                                context)!
                                            .pleaseEnterValidState;
                                      }
                                      return null;
                                    },
                                    suggestionsDecoration: SuggestionDecoration(
                                      padding: const EdgeInsets.only(left: 20),
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    searchInputDecoration: InputDecoration(
                                      labelText: TranslationHelper.translation(
                                              context)!
                                          .cityState,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    maxSuggestionsInViewPort: 4,
                                    itemHeight: 50,
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateCity(value.toString());
                                    },
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.postcode,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .postCode,
                                    isRequired: true,
                                    type: TextInputType.number,
                                    validator: (value) {
                                      return pinCodeValidator(
                                          context, value.toString());
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updatePostCode(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.address1,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .houseNumberBuildingName,
                                    isRequired: true,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return TranslationHelper.translation(
                                                context)!
                                            .pleaseEnterValidAddress;
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateAddress1(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    isObscure: true,
                                    value: data.message!.password,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .password,
                                    isRequired: true,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length < 7 ||
                                          value.trim().isEmpty) {
                                        return TranslationHelper.translation(
                                                context)!
                                            .pleaseAddValidPassword;
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updatePassword(value!);
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.address2,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .roadNameAreaColony,
                                    isRequired: true,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return TranslationHelper.translation(
                                                context)!
                                            .pleaseEnterValidAddress;
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateAddress2(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.nationalId,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .nationalId,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateNationalID(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.crNumber,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .crNumber,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateCRNumber(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.vatNumber,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .vatNumber,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateVatNumber(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.whatsappNumber,
                                    label:
                                        TranslationHelper.translation(context)!
                                            .whatsappNumber,
                                    type: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          value.trim().length != 9) {
                                        return TranslationHelper.translation(
                                                context)!
                                            .mobileNumberShouldBe9Digits;
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateWhatsappNumber(
                                              value.toString());
                                    },
                                    readOnly: false,
                                    prefix: "+966 ",
                                  ),
                                  const Gap(30),
                                  SizedBox(
                                    width: DeviceInfo.getDeviceWidth(context),
                                    child: ElevatedButton(
                                      onPressed: addressWatcher.isBtnDisable
                                          ? null
                                          : (queryParams == "from=/")
                                              ? () async {
                                                  await addressUpdateNotifier
                                                      .updateAddress(formkey,
                                                          context, ref);
                                                  if (!context.mounted) return;
                                                  context.go("/home");
                                                }
                                              : () {
                                                  addressUpdateNotifier
                                                      .updateAddress(formkey,
                                                          context, ref);
                                                },
                                      child: addressWatcher.isBtnDisable
                                          ? const CircularProgressIndicator()
                                          : Text(TranslationHelper.translation(
                                                  context)!
                                              .saveAddress),
                                    ),
                                  ),
                                  const Gap(30),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(data.errorMessage ??
                TranslationHelper.translation(context)!.unknownError),
          );
        }
      },
      error: (err, stk) => Scaffold(
        appBar: AppBar(
          title: Text(TranslationHelper.translation(context)!.myAddress),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(TranslationHelper.translation(context)!.serverErrorOccurred),
            RefreshButton(provider: addressProvider)
          ]),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
