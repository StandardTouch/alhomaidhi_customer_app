import 'package:alhomaidhi_customer_app/src/features/login/providers/login_provider.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/form_input.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:alhomaidhi_customer_app/src/utils/theme/theme.dart';
import 'package:alhomaidhi_customer_app/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginNotifier = ref.read(loginProvider.notifier);
    final loginRef = ref.watch(loginProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(
                        DeviceInfo.isDarkMode(context)
                            ? Assets.logoDark
                            : Assets.logoLight,
                      ),
                      width: 250,
                    ),
                    const Gap(30),
                    Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 30),
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
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const Gap(20),
                            FormInput(
                              value: loginRef.getPhoneNumber,
                              // todo - change max length to 9 before production
                              maxLength: 10,
                              label: "Phone Number",
                              type: TextInputType.number,
                              prefix: "+966",
                              validator: (value) {
                                return mobileNumberValidator(value);
                              },
                              onSaved: (value) {
                                loginNotifier.updatephoneNumber(value);
                              },
                            ),
                            const Gap(30),
                            if (loginRef.isOTPVisible == true)
                              Pinput(
                                  length: 6,
                                  defaultPinTheme: getDefaultPinTheme(context),
                                  submittedPinTheme:
                                      getSubmittedPinTheme(context),
                                  onCompleted: (value) {
                                    loginNotifier.updateOtp(value);
                                    loginNotifier.verifyOtp(context);
                                    // todo - implement login api functionality
                                  }),
                            if (loginRef.isOTPVisible == true) const Gap(30),
                            if (!(loginRef.isOTPVisible == true))
                              ElevatedButton.icon(
                                onPressed: loginRef.isButtonLoading
                                    ? null
                                    : () {
                                        loginNotifier.sendOtp(formKey, context);
                                      },
                                // onPressed: () {
                                //   loginNotifier.startTimer();
                                // },
                                icon: loginRef.isButtonLoading
                                    ? const Icon(
                                        // what icon you give doesn't matter over here
                                        Icons.safety_check,
                                        size: 0,
                                      )
                                    : const Icon(Icons.arrow_circle_right_sharp,
                                        color: Colors.white),
                                label: loginRef.isButtonLoading
                                    ? const CircularProgressIndicator()
                                    : (loginRef.isOTPVisible == true)
                                        ? const Text("Login")
                                        : const Text(
                                            "Send OTP",
                                          ),
                              ),
                            if (loginRef.isOTPVisible == true) const Gap(10),
                            if (loginRef.isOTPVisible == true)
                              InkWell(
                                onTap: loginRef.isResendLoading ||
                                        (loginRef.timerDuration != 0)
                                    ? null
                                    : () {
                                        loginNotifier.resendOtp(context);
                                      },
                                child: loginRef.isResendLoading
                                    ? const CircularProgressIndicator()
                                    : (loginRef.timerDuration != 0)
                                        ? Text(
                                            "Resend in ${loginRef.timerDuration}",
                                            style: const TextStyle(
                                              color: Colors.redAccent,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.red,
                                            ),
                                          )
                                        : const Text(
                                            "Resend OTP",
                                            style: TextStyle(
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.red),
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
          if (loginRef.isVerificationLoading)
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
                  Text("Logging in"),
                ],
              ),
            )
        ],
      ),
    );
  }
}
