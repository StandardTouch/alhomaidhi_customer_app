import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';

class ConversionHelper {
  static String getEnglishPart(String inputString) {
    int slashIndex = inputString.indexOf('/');

    if (slashIndex != -1) {
      return inputString.substring(0, slashIndex).trim();
    } else {
      // If there is no "/", return the entire input string
      return inputString.trim();
    }
  }

  static String formatPrice(String inputString) {
    try {
      double value = double.parse(inputString);
      return value.toStringAsFixed(2);
    } catch (e) {
      // Handle the exception if the input is not a valid number
      return inputString;
    }
  }

  static int calculateDiscountPercentage(
      String priceBeforeStr, String priceAfterStr) {
    try {
      double priceBefore = double.parse(priceBeforeStr);
      double priceAfter = double.parse(priceAfterStr);

      double discountAmount = priceBefore - priceAfter;
      double discountPercentage = (discountAmount / priceBefore) * 100;
      return discountPercentage.round();
    } on FormatException {
      logger.e('Invalid input: please enter valid numbers.');
      return 0;
    }
  }
}
