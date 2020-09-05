import 'package:FarmApp/Models/Strings.dart';

class Validator {
  static String price(String val) {
    return (num.tryParse(val) > 0) ? null : STRING_ENTER_VALID_PRICE;
  }

  static String quantity(String val) {
    return (double.parse(val) > 0) ? null : STRING_ENTER_VALID_QUANTITY;
  }

  static String otp(String val) {
    return (val?.length == 6) ? null : STRING_OTP_MUST_6_DIGITS;
  }

  static String name(String val) {
    return (val != null && val.length >= 5) ? null : STRING_ENTER_VALID_NAME;
  }

  static String mobile(String val) {
    return (val != null && val.length == 10) ? null : STRING_MUST_BE_10_DIGITS;
  }

  static String addressLine(String val) {
    return (val != null && val.length >= 5) ? null : STRING_ENTER_VALID_ADDRESS;
  }

  static String district(String val) {
    return (val != null && val.length >= 5) ? null : STRING_ENTER_YOUR_DISTRICT;
  }

  static String pincode(String val) {
    return (val?.length == 6) ? null : STRING_ENTER_PIN_CODE;
  }

  static String state(String val) {
    return (val != null && val.length >= 5) ? null : STRING_ENTER_VALID_STATE;
  }
}
