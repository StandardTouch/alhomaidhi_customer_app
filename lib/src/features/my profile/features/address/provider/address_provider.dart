import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/models/address_request_model.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/models/address_response_model.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/top_snackbar.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alhomaidhi_customer_app/src/features/my profile/features/address/services/address_service.dart';

final addressProvider = FutureProvider<AddressResponseModel>((ref) async {
  AddressResponseModel response = await getProfileDetails();
  return response;
});

class AddressNotifier extends StateNotifier<AddressRequestModel> {
  AddressNotifier() : super(AddressRequestModel());

  // Update first name
  void updateFirstName(String value) {
    state = state.copyWith(firstName: value);
  }

  // update last name
  void updateLastName(String value) {
    state = state.copyWith(lastName: value);
  }

  // update city
  void updateCity(String value) {
    state = state.copyWith(city: value);
  }

  // update phone number
  void updatePhoneNo(String value) {
    state = state.copyWith(phone: value);
  }

  // update post code
  void updatePostCode(String value) {
    state = state.copyWith(postcode: value);
  }

  // update address 1
  void updateAddress1(String value) {
    state = state.copyWith(address1: value);
  }

  // update address 2
  void updateAddress2(String value) {
    state = state.copyWith(address2: value);
  }

  // update National ID
  void updateNationalID(String value) {
    state = state.copyWith(nationalId: value);
  }

  // update CR Number
  void updateCRNumber(String value) {
    state = state.copyWith(crNumber: value);
  }

  // update VAT Number
  void updateVatNumber(String value) {
    state = state.copyWith(vatNumber: value);
  }

  // update whatsapp Number
  void updateWhatsappNumber(String value) {
    state = state.copyWith(whatsAppNumber: value);
  }

  void updateAddress(
      GlobalKey<FormState> formkey, BuildContext context, WidgetRef ref) async {
    if (formkey.currentState == null) {
      return;
    }
    try {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        state = state.copyWith(isBtnDisable: true);
        Object data = {
          "first_name": state.firstName,
          "last_name": state.lastName,
          "country": "SA",
          "city": state.city,
          "postcode": state.postcode,
          "address_1": state.address1,
          "address_2": state.address2,
          "national_id": state.nationalId,
          "cr_number": state.crNumber,
          "vat_number": state.vatNumber,
          "whatsapp_number": state.whatsAppNumber,
        };
        AddressRequestResponseModel response = await updateProfileDetails(data);
        logger.e(response);
        if (response.status == "APP00") {
          if (!context.mounted) {
            return;
          }
          ref.invalidate(addressProvider);

          getSnackBar(
            context: context,
            message: "Address Details successfully Updated",
            type: SNACKBARTYPE.success,
          );
        } else {
          if (!context.mounted) {
            return;
          }
          getSnackBar(
            context: context,
            message: "Uh Oh. An error occurred: ${response.message}",
            type: SNACKBARTYPE.error,
          );
        }

        state = state.copyWith(isBtnDisable: false);
      }
    } catch (err) {
      if (!context.mounted) {
        return;
      }
      getSnackBar(
        context: context,
        message: "Server Error: Please try again later",
        type: SNACKBARTYPE.error,
      );
      state = state.copyWith(isBtnDisable: false);
    }
  }
}

final addressNotifier =
    StateNotifierProvider<AddressNotifier, AddressRequestModel>((ref) {
  return AddressNotifier();
});
