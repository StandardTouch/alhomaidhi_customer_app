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

  var _width, _height;
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
    _height = DeviceInfo.getDeviceHeight(context);
    _width = DeviceInfo.getDeviceWidth(context);
    ThemeMode themeModeValue = EasyDynamicTheme.of(context).themeMode!;
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: _height,
        width: _width,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              height: _height * 0.10,
              width: _width,
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
            Container(
              height: _height * 0.90,
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
              width: _width,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          width: _width,
                          child: ElevatedButton(
                            onPressed: _saveBillingDetails,
                            child: const Text("Save Address"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
