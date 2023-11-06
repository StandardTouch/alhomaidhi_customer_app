import 'package:alhomaidhi_customer_app/src/features/signup/screens/widgets/form_input.dart';
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
    if (_formKey.currentState == null) {
      return;
    }
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                      const Image(
                        image: AssetImage('assets/images/alhomaidhi.png'),
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
                          _enterFirstName = value!;
                        },
                      ),
                      const Gap(20),
                      FormInput(
                        label: "Last Name",
                        type: TextInputType.name,
                        validator: (value) {
                          return lastNameValidator(value);
                        },
                        onSaved: (value) {
                          _enterLastName = value!;
                        },
                      ),
                      const Gap(20),
                      FormInput(
                        label: "Mobile Number",
                        type: TextInputType.number,
                        validator: (value) {
                          return mobileNumberValidator(value);
                        },
                        onSaved: (value) {
                          _enterMobileNo = value!;
                        },
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
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: _registerUser,
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
