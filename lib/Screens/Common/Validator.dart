class Validator {
  static String quantity(String val) {
    return (num.tryParse(val) > 0) ? null : 'Enter a valid quantity';
  }
}
