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

  String formatPrice(String inputString) {
    try {
      double value = double.parse(inputString);
      return value.toStringAsFixed(2);
    } catch (e) {
      // Handle the exception if the input is not a valid number
      return inputString;
    }
  }
}
