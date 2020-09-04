import 'package:FarmApp/Models/Strings.dart';
import 'package:flutter/cupertino.dart';

class Validator {
  static String price(String val) {
    String s = (num.tryParse(val) > 0) ? null : STRING_ENTER_VALID_PRICE;
    if (s != null) {
      debugPrint("Validation Failed");
    }
    return s;
  }

  static String quantity(String val) {
    String s = (double.parse(val) > 0) ? null : STRING_ENTER_VALID_QUANTITY;
    if (s != null) {
      debugPrint("Validation Failed");
    }
    return s;
  }

  static String otp(String val) {
    String s = (val?.length == 6) ? null : STRING_OTP_MUST_6_DIGITS;
    if (s != null) {
      debugPrint("Validation Failed");
    }
    return s;
  }

  static String name(String val) {
    // TODO: Move `RegExp('[a-zA-Z ]?').hasMatch(val)` to TextFormField
    String s =
        (val != null && val.length >= 5) ? null : STRING_ENTER_VALID_NAME;
    if (s != null) {
      debugPrint("Validation Failed");
    }
    return s;
  }

  static String mobile(String val) {
    String s =
        (val != null && val.length == 10) ? null : STRING_MUST_BE_10_DIGITS;
    if (s != null) {
      debugPrint("Validation Failed");
    }
    return s;
  }

  static String addressLine(String val) {
    return (val != null && val.length >= 5) ? null : 'Enter a valid address';
  }

  static String district(String val) {
    return (val != null && val.length >= 5) ? null : 'Enter a valid district';
  }

  static String pincode(String val) {
    return (val?.length == 6) ? null : 'Enter a valid pincode';
  }

  static String state(String val) {
    return (val != null && val.length >= 5) ? null : 'Enter a valid state';
  }
}
