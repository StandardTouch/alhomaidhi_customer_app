import 'package:alhomaidhi_customer_app/src/shared/widgets/form_input.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enterMobileNo = '';

  void _loginUser() {
    if (_formKey.currentState == null) {
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enterMobileNo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image: AssetImage(Assets.logoLight),
                  width: 250,
                ),
                const Gap(30),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 0.5,
                            spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Gap(20),
                        FormInput(
                          maxLength: 9,
                          label: "Phone Number",
                          type: TextInputType.number,
                          prefix: "+966",
                          validator: (value) {
                            return mobileNumberValidator(value);
                          },
                          onSaved: (value) {
                            _enterMobileNo = value!;
                          },
                        ),
                        const Gap(30),
                        ElevatedButton.icon(
                          onPressed: _loginUser,
                          icon: const Icon(Icons.arrow_circle_right_sharp,
                              color: Colors.white),
                          label: const Text(
                            "Send OTP",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const Gap(50),
                        const Text("Don't have an account?"),
                        const Gap(10),
                        InkWell(
                          onTap: () {
                            context.push("/signup");
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
