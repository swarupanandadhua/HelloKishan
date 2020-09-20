import 'package:FarmApp/Models/Strings.dart';
import 'package:flutter/cupertino.dart';

class Validator {
  static String price(String val) {
    double price = double.tryParse(val);
    return (price != null && price > 0) ? null : STRING_ENTER_VALID_PRICE;
  }

  static String quantity(String val) {
    double qty = double.tryParse(val);
    return (qty != null && qty > 0) ? null : STRING_ENTER_VALID_QUANTITY;
  }

  static String otp(String val) {
    return (val?.length == 6) ? null : STRING_OTP_MUST_6_DIGITS;
  }

  static String name(String val) {
    return (val != null && val.length >= 5) ? null : STRING_NAME_INVALID;
  }

  static String mobile(String val) {
    return (val != null && val.length == 10) ? null : STRING_MUST_BE_10_DIGITS;
  }

  static String addressLine(String val) {
    return (val != null && val.length >= 5) ? null : STRING_ADDRESS_INVALID;
  }

  static String district(String val) {
    return (val != null && val.length >= 5)
        ? null
        : STRING_DISTRICT_NAME_INVALID;
  }

  static String pincode(String val) {
    return (val?.length == 6) ? null : STRING_PINCODE_INVALID;
  }

  static String state(String val) {
    return (val != null && val.length >= 5) ? null : STRING_STATE_NAME_INVALID;
  }

  static void defaultErrorHandler() {
    debugPrint(StackTrace.current.toString());
  }
}
