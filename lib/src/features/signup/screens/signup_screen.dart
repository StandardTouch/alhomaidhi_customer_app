import 'package:alhomaidhi_customer_app/src/shared/widgets/form_input.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
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
  void _regiterUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(Theme.of(context).brightness);
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 218, 241, 253),
                Color.fromARGB(255, 218, 241, 253),
                Color.fromARGB(255, 218, 241, 253),
              ],
            ),
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 123, 151, 166),
                          blurRadius: 1.0),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(
                            (Theme.of(context).brightness == Brightness.dark)
                                ? Assets.logoDark
                                : Assets.logoLight),
                        width: 250,
                      ),
                      const Gap(30),
                      FormInput(
                        label: "First Name",
                        type: TextInputType.name,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length <= 1 ||
                              value.trim().length > 50) {
                            return 'Must be between 1 and 50 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enterFirstName = value.toString();
                        },
                      ),
                      const Gap(20),
                      FormInput(
                        label: "Last Name",
                        type: TextInputType.name,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length <= 1 ||
                              value.trim().length > 20) {
                            return 'Must be between 1 and 20 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enterLastName = value.toString();
                        },
                      ),
                      const Gap(20),
                      FormInput(
                        label: "Mobile Number",
                        type: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length != 10) {
                            return 'Mobile number should be 9 digits long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enterMobileNo = value.toString();
                        },
                      ),
                      const Gap(20),
                      FormInput(
                        label: "Email Address",
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.') ||
                              value.trim().length >= 100) {
                            return 'Email address validated failed';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enterEmailAdd = value.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: _regiterUser,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 18, horizontal: 60),
                    elevation: 0.2,
                    backgroundColor: Theme.of(context).primaryColor),
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
