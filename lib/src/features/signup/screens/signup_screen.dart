import 'package:alhomaidhi_customer_app/src/features/signup/providers/signup_provider.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/form_input.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:alhomaidhi_customer_app/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signUpNotifer = ref.read(signUpProvider.notifier);
    final signUpRef = ref.watch(signUpProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 50),
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 0.5,
                              spreadRadius: 1),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(Assets.logoLight),
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
                              // _enterFirstName = value.toString();
                              signUpNotifer.updateFistname(value);
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
                              // _enterLastName = value.toString();
                              signUpNotifer.updateLastName(value);
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
                              // _enterMobileNo = value.toString();
                              signUpNotifer.updatephoneNumber(value);
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
                              // _enterEmailAdd = value.toString();
                              signUpNotifer.updateEmail(value);
                            },
                            readOnly: false,
                          ),
                          const Gap(30),
                          ElevatedButton(
                            onPressed: () {
                              signUpNotifer.registerUser(formKey, context);
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const Gap(50),
                          const Text("Already have an account?"),
                          const Gap(10),
                          InkWell(
                            onTap: () {
                              context.push("/login");
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.error),
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
          if (signUpRef.isVerificationLoading)
            Container(
              height: DeviceInfo.getDeviceHeight(context),
              width: DeviceInfo.getDeviceWidth(context),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: LinearProgressIndicator(),
                  ),
                  Text("Signing In"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
