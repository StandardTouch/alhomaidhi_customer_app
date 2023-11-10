import 'package:alhomaidhi_customer_app/src/shared/widgets/form_input.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:alhomaidhi_customer_app/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enterFirstName = '';
  var _enterLastName = '';
  var _enterMobileNo = '';
  var _enterEmailAdd = '';
  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enterFirstName);
      print(_enterLastName);
      print(_enterMobileNo);
      print(_enterEmailAdd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: DeviceInfo.getDeviceHeight(context),
          width: DeviceInfo.getDeviceWidth(context),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(DeviceInfo.isDarkMode(context)
                            ? Assets.logoDark
                            : Assets.logoLight),
                        width: 250,
                      ),
                      const Gap(30),
                      FormInput(
                        label: "First Name",
                        type: TextInputType.name,
                        validator: (value) {
                          return firstNameValidator(value);
                        },
                        onSaved: (value) {
                          _enterFirstName = value.toString();
                        },
                        readOnly: false,
                      ),
                      const Gap(20),
                      FormInput(
                        label: "Last Name",
                        type: TextInputType.name,
                        validator: (value) {
                          return lastNameValidator(value);
                        },
                        onSaved: (value) {
                          _enterLastName = value.toString();
                        },
                        readOnly: false,
                      ),
                      const Gap(20),
                      FormInput(
                        label: "Mobile Number",
                        type: TextInputType.number,
                        validator: (value) {
                          return mobileNumberValidator(value);
                        },
                        onSaved: (value) {
                          _enterMobileNo = value.toString();
                        },
                        readOnly: false,
                      ),
                      const Gap(20),
                      FormInput(
                        label: "Email Address",
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          return emailValidator(value);
                        },
                        onSaved: (value) {
                          _enterEmailAdd = value.toString();
                        },
                        readOnly: false,
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: _registerUser,
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
