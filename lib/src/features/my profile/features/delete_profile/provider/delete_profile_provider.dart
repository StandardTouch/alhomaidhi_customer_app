import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/delete_profile/models/delete_profile_request_model.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/delete_profile/services/delete_profile_service.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/top_snackbar.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class DeleteProfileNotifier extends StateNotifier<DeleteProfileRequestModel> {
  DeleteProfileNotifier() : super(DeleteProfileRequestModel());

  void deleteProfile(context) async {
    try {
      state = state.copyWith(isBtnDisable: true);
      DeleteProfileRequestResponseModel response = await deleteProfileRequest();
      logger.e(response);
      if (response.status == "APP00") {
        logger.i(response.message);
        if (!context.mounted) {
          return;
        }
        getSnackBar(
          context: context,
          message: "Account Deleted Successfully",
          type: SNACKBARTYPE.success,
        );
        const storage = FlutterSecureStorage();
        storage.delete(key: "token");
        storage.delete(key: "userId");
        // context.go('/login');

        GoRouter.of(context).go('/login');
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

final deleteProfileNotifier =
    StateNotifierProvider<DeleteProfileNotifier, DeleteProfileRequestModel>(
        (ref) {
  return DeleteProfileNotifier();
});
