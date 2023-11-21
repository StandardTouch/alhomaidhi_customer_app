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
}
