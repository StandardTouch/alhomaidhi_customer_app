import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TranslationHelper {
  static AppLocalizations translation(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static Future<bool> getIsArabic() async {
    const storage = FlutterSecureStorage();
    final String language = await storage.read(key: "language") ?? "en";
    if (language == "ar") {
      return true;
    } else {
      return false;
    }
  }
}
