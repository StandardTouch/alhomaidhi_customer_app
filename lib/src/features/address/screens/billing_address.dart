import 'package:alhomaidhi_customer_app/src/shared/widgets/form_input.dart';
import 'package:alhomaidhi_customer_app/src/utils/theme/theme.dart';
import 'package:alhomaidhi_customer_app/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BillingAddress extends StatefulWidget {
  const BillingAddress({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BillingAddress();
  }
}

class _BillingAddress extends State<BillingAddress> {
  final _formKey = GlobalKey<FormState>();
  var _enterFullName = '';
  var _enterMobileNo = '';
  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text(
              "Billing Address",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [cardBoxShadow],
              ),
              child: Column(
                children: [
                  const Gap(20),
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
