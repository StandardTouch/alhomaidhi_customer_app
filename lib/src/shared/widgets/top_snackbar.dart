import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum SNACKBARTYPE {
  success,
  error,
  info,
}

// defaults to success
void getSnackBar(
    {required BuildContext context,
    SNACKBARTYPE? type,
    required String message}) {
  showTopSnackBar(
    Overlay.of(context),
    (type == SNACKBARTYPE.success)
        ? CustomSnackBar.success(message: message)
        : (type == SNACKBARTYPE.info)
            ? CustomSnackBar.info(message: message)
            : (type == SNACKBARTYPE.error)
                ? CustomSnackBar.error(message: message)
                : CustomSnackBar.success(message: message),
  );
}
