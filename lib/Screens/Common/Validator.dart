import 'package:HelloKishan/Models/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String price(String val) {
    double price = double.tryParse(val);
    return (price != null && price > 0) ? null : STRING_ENTER_VALID_PRICE.tr();
  }

  static String quantity(String val) {
    double qty = double.tryParse(val);
    return (qty != null && qty > 0) ? null : STRING_ENTER_VALID_QUANTITY.tr();
  }

  static String otp(String val) {
    return (val?.length == 6) ? null : STRING_OTP_MUST_6_DIGITS.tr();
  }

  static String name(String val) {
    return (val != null && val.length >= 5) ? null : STRING_NAME_INVALID.tr();
  }

  static String mobile(String val) {
    return (val != null && val.length == 10)
        ? null
        : STRING_MUST_BE_10_DIGITS.tr();
  }

  static String addressLine(String val) {
    return (val != null && val.length >= 5)
        ? null
        : STRING_ADDRESS_INVALID.tr();
  }

  static String district(String val) {
    return (val != null && val.length >= 5)
        ? null
        : STRING_DISTRICT_NAME_INVALID.tr();
  }

  static String pincode(String val) {
    return (val?.length == 6) ? null : STRING_PINCODE_INVALID.tr();
  }

  static String state(String val) {
    return (val != null && val.length >= 5)
        ? null
        : STRING_STATE_NAME_INVALID.tr();
  }

  static void defaultErrorHandler() {
    debugPrint(StackTrace.current.toString());
  }
}
