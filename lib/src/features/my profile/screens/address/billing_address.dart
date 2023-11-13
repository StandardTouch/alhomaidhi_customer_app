import 'package:alhomaidhi_customer_app/src/shared/widgets/form_input.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/cities.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:alhomaidhi_customer_app/src/utils/validators/validators.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:searchfield/searchfield.dart';

// @kahkashan
// Fix render overflow bug

class BillingAddress extends StatefulWidget {
  const BillingAddress({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BillingAddress();
  }
}

class _BillingAddress extends State<BillingAddress> {
  final _formKey = GlobalKey<FormState>();

  final cityData = ["Riyadh", "Jedha"];

  var themeMode = false;
  var _enterFullName = '';
  var _enterMobileNo = '';
  var _enterEmailAdd = '';
  var _selectedCity = '';
  var _enterPostCode = '';
  var _addressField1 = '';
  var _addressField2 = '';

  void _saveBillingDetails() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enterFullName);
      print(_enterMobileNo);
      print(_enterEmailAdd);
      print(_enterPostCode);
      print(_selectedCity);
      print(_addressField1);
      print(_addressField2);
    }
  }

  @override
  Widget build(context) {
    ThemeMode themeModeValue = EasyDynamicTheme.of(context).themeMode!;
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Billing Details",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        const Gap(30),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 50,
              right: 50,
              bottom: 0,
            ),
            decoration: BoxDecoration(
              color: (themeModeValue == ThemeMode.dark)
                  ? Colors.black
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38, blurRadius: 0.5, spreadRadius: 1),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Gap(10),
                        FormInput(
                          label: "First Name",
                          type: TextInputType.name,
                          validator: (value) {
                            return firstNameValidator(value);
                          },
                          onSaved: (value) {
                            _enterFullName = value.toString();
                          },
                          readOnly: false,
                        ),
                        const Gap(30),
                        FormInput(
                          label: "Mobile Number",
                          type: TextInputType.number,
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _enterMobileNo = value.toString();
                          },
                          readOnly: true,
                        ),
                        const Gap(30),
                        FormInput(
                          label: "Email Address",
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _enterEmailAdd = value.toString();
                          },
                          readOnly: true,
                        ),
                        const Gap(30),
                        SearchField(
                          suggestions: cities
                              .map((e) => SearchFieldListItem(e))
                              .toList(),
                          suggestionState: Suggestion.expand,
                          textInputAction: TextInputAction.next,
                          hint: 'City/State',
                          searchStyle: Theme.of(context).textTheme.labelMedium,
                          validator: (x) {
                            if (!cities.contains(x) || x!.isEmpty) {
                              return 'Please Enter a valid State';
                            }
                            return null;
                          },
                          searchInputDecoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          maxSuggestionsInViewPort: 6,
                          itemHeight: 50,
                          onSaved: (value) {
                            _selectedCity = value.toString();
                          },
                        ),
                        const Gap(30),
                        FormInput(
                          label: "Post Code",
                          type: TextInputType.text,
                          validator: (value) {
                            return pinCodeValidator(value.toString());
                          },
                          onSaved: (value) {
                            _enterPostCode = value.toString();
                          },
                          readOnly: false,
                        ),
                        const Gap(30),
                        FormInput(
                          label: "House No. Building Name",
                          type: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the valid address";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _addressField1 = value.toString();
                          },
                          readOnly: false,
                        ),
                        const Gap(30),
                        FormInput(
                          label: "Road Name, Area, Colony",
                          type: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the valid address";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _addressField2 = value.toString();
                          },
                          readOnly: false,
                        ),
                        const Gap(30),
                        SizedBox(
                          width: DeviceInfo.getDeviceWidth(context),
                          child: ElevatedButton(
                            onPressed: _saveBillingDetails,
                            child: const Text("Save Address"),
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
    );
  }
}
