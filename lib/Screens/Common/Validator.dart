import 'package:FarmApp/Models/Strings.dart';

class Validator {
  static String quantity(String val) {
    return (num.tryParse(val) > 0) ? null : 'Enter a valid quantity';
  }

  static String otp(String val) {
    return (val?.length == 6) ? null : STRING_OTP_MUST_6_DIGITS;
  }

  static String name(String val) {
    return (RegExp('[a-zA-Z ]?').hasMatch(val) && val.length > 4)
        ? null
        : 'Enter a valid name';
  }

  static String mobile(String val) {
    return (val.length == 10) ? null : 'Must be 10 digits';
  }

  static String pincode(String val) {
    return null;
  }

  static String price(String val) {
    return (num.tryParse(val) > 0) ? null : 'Enter a valid price';
  }
}
