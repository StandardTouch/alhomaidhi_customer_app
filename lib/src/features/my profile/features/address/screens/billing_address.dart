import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/form_input.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/cities.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:alhomaidhi_customer_app/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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

  @override
  Widget build(context) {
    final addressGetProvider = ref.watch(addressProvider);

    final addressUpdateNotifier = ref.read(addressNotifier.notifier);
    final addressWatcher = ref.watch(addressNotifier);

    return addressGetProvider.when(
        data: (data) {
          if (data.status == "APP00") {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Billing Details",
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  const Gap(10),
                                  FormInput(
                                    value: data.message!.firstName,
                                    label: "First Name",
                                    type: TextInputType.name,
                                    validator: (value) {
                                      return firstNameValidator(value);
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
                                    label: "Last Name",
                                    type: TextInputType.name,
                                    validator: (value) {
                                      return lastNameValidator(value);
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateLastName(value.toString());
                                    },
                                    readOnly: false,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.phone,
                                    label: "Mobile Number",
                                    type: TextInputType.number,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {},
                                    readOnly: true,
                                  ),
                                  const Gap(30),
                                  FormInput(
                                    value: data.message!.email,
                                    label: "Email Address",
                                    type: TextInputType.emailAddress,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {},
                                    readOnly: true,
                                  ),
                                  const Gap(30),
                                  SearchField(
                                    initialValue: SearchFieldListItem(
                                        (data.message!.city).toString()),
                                    suggestions: cities
                                        .map((e) => SearchFieldListItem(e))
                                        .toList(),
                                    suggestionState: Suggestion.expand,
                                    textInputAction: TextInputAction.next,
                                    hint: 'City/State',
                                    searchStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                    validator: (x) {
                                      if (!cities.contains(x) || x!.isEmpty) {
                                        return 'Please Enter a valid State';
                                      }
                                      return null;
                                    },
                                    suggestionsDecoration: SuggestionDecoration(
                                      padding: const EdgeInsets.only(left: 20),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.4)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    searchInputDecoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.2)),
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
                                    label: "Post Code",
                                    type: TextInputType.text,
                                    validator: (value) {
                                      return pinCodeValidator(value.toString());
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
                                    label: "House No. Building Name",
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter the valid address";
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
                                    value: data.message!.address2,
                                    label: "Road Name, Area, Colony",
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter the valid address";
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
                                    label: "National ID",
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter National ID";
                                      }
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
                                    label: "CR Number",
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter CR Number";
                                      }
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
                                    label: "VAT Number",
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter VAT Number";
                                      }
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
                                    label: "WhatsApp Number",
                                    type: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isNotEmpty &&
                                          value.trim().length == 9) {
                                        return 'Mobile number should be 9 digits long';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressUpdateNotifier
                                          .updateWhatsappNumber(
                                              value.toString());
                                    },
                                    readOnly: false,
                                    prefix: "966",
                                  ),
                                  const Gap(30),
                                  SizedBox(
                                    width: DeviceInfo.getDeviceWidth(context),
                                    child: ElevatedButton(
                                      onPressed: addressWatcher.isBtnDisable
                                          ? null
                                          : () {
                                              addressUpdateNotifier
                                                  .updateAddress(
                                                      formkey, context, ref);
                                            },
                                      child: addressWatcher.isBtnDisable
                                          ? const CircularProgressIndicator()
                                          : const Text("Save Address"),
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
                ],
              ),
            );
          } else {
            return Center(
              child: Text(data.errorMessage ?? 'Unknown error'),
            );
          }
        },
        error: (err, stk) => Center(
              child: Text("$err"),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
