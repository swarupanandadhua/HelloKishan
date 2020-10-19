import 'package:HelloKishan/Screens/Common/Translate.dart';

String displayRate(String rate) {
  return '$STRING_RATE : ${numE2B(rate)} $STRING_RS_PER_KG';
}

String displayQty(String qty) {
  return '$STRING_QUANTITY : ${numE2B(qty)} $STRING_KG';
}

String displayAmt(String amt) {
  return '$STRING_TOTAL_AMT: ${numE2B(amt)} $STRING_RS';
}

// INFO: Following APP_ID is used in AndroidManifest.xml as well
const String ADMOB_APP_ID = 'ca-app-pub-8285249568639559~5250421163';
const String COUNTRY_CODE_IN = '+91';
const String STRING_INVALID_VERIFICATION_CODE =
    'ERROR_INVALID_VERIFICATION_CODE';
const String STRING_TODO_IMPORTANT_FUNCTIONALITY = 'TODO : IMPORTANT FUNC.';
const String APP_PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=com.HelloKishan.HelloKishan';
const String STRING_SHARE_ARG = '$APP_DESC_MSG \n $APP_PLAY_STORE_URL';

const String STRING_APP_NAME = 'Hello Kishan';
const String STRING_WELCOME_USER = 'Welcome User';

const String STRING_MOBILE = 'Mobile';
const String STRING_ENTER_MOBILE_NUMBER = 'Enter Mobile Number';
const String STRING_MUST_BE_10_DIGITS = 'Must be 10 digits';
const String STRING_SEND_OTP = 'Send OTP';
const String STRING_SENDING_OTP = 'Sending OTP...';
const String STRING_ENTER_OTP = 'Enter the OTP';
const String STRING_OTP_MUST_6_DIGITS = 'OTP must be 6 digits';
const String STRING_INVALID_OTP = 'Invalid OTP !';

const String STRING_SUBMIT = 'Submit';

const String STRING_PROFILE_UPDATE = 'Profile Update';
const String STRING_PERSONAL_INFORMATION = 'Personal Information';
const String STRING_YOUR_NAME = 'Your Name';
const String STRING_ENTER_YOUR_NAME = 'Enter your name';
const String STRING_NAME_INVALID = 'Enter a valid name';

const String STRING_LOADING_LOCATION = 'Getting Location...';
const String STRING_ADDRESS_INFORMATION = 'Address Information';
const String STRING_ADDRESS = 'Address';
const String STRING_HOUSE_STREET_LOCALITY = 'House / Street / Locality Name';
const String STRING_ADDRESS_INVALID = 'Enter a valid address';
const String STRING_DISTRICT_NAME = 'District';
const String STRING_ENTER_YOUR_DISTRICT = 'Enter your district';
const String STRING_DISTRICT_NAME_INVALID = 'Enter a valid district';
const String STRING_STATE_NAME = 'State';
const String STRING_ENTER_STATE = 'Enter State';
const String STRING_STATE_NAME_INVALID = 'Enter a valid state';
const String STRING_PIN_CODE = 'Pin Code';
const String STRING_ENTER_PIN_CODE = 'Enter Pin Code';
const String STRING_PINCODE_INVALID = 'Enter a valid Pin Code';

const String STRING_PROCEED = 'PROCEED';

const String STRING_KG = 'kg';
const String STRING_RS_PER_KG = 'Rs/kg';
const String STRING_RS = 'Rs';
const String STRING_ENTER_PRICE_PER_KG = 'Enter price/kg';
const String STRING_ENTER_QUANTITY = 'Enter quantity (in kg)';

const String STRING_ENTER_VALID_PRICE = 'Enter a valid price';
const String STRING_ENTER_VALID_QUANTITY = 'Enter a valid quantity';

const String STRING_HOME = 'Home';
const String STRING_PROFILE = 'Profile';
const String STRING_TRADE = 'Trade';
const String STRING_HISTORY = 'History';

const String STRING_NO_BUYER_FOUND = 'No buyer found for';
const String STRING_WANTS_TO_BUY = 'Wants to buy';
const String STRING_NO_REQUIREMENTS_FOUND = 'No requirements found !';
const String STRING_NO_TRANSACTIONS_FOUND = 'No transactions found !';

const String STRING_POST = 'POST';
const String STRING_POST_REQUIREMENT = 'Post Requirement';
const String STRING_POST_REQUIREMENT_HEADER =
    'Please enter what do you want to buy, how much, at what rate and where is your shop located';

const String STRING_REQUIREMENTS = 'Requirements';
const String STRING_SAVE = 'Save';
const String STRING_SEARCH_RESULTS = 'Search Results';

const String STRING_BUY_WHAT = 'What do you want to buy ?';
const String STRING_WRITE_BUY_WHAT = 'Enter what do you want to buy ?';
const String STRING_BUY_HOW_MUCH = 'How much (kg) do you want to buy ?';
const String STRING_BUY_WHAT_PRICE = 'At what price ?';

const String STRING_WHAT_SELL_SELECT_FROM_LIST =
    'Please select a product from list';

const String STRING_SELL = 'Sell';
const String STRING_BOUGHT_FROM = 'Bought from';
const String STRING_BUY = 'Buy';
const String STRING_SELLING_TO = 'Selling to';
const String STRING_BUYING_FROM = 'Buying from';
const String STRING_SOLD_TO = 'Sold to';
const String STRING_SELL_REQUEST = 'Sell Request';

const String STRING_RATE = 'Rate';
const String STRING_QUANTITY = 'Quantity';
const String STRING_TOTAL_AMT = 'Total Amount';

const String STRING_ACCEPTED = 'ACCEPTED';
const String STRING_REQUESTED = 'REQUESTED';
const String STRING_ACCEPT = 'ACCEPT';
const String STRING_REJECT = 'REJECT';
const String STRING_CANCEL = 'CANCEL';
const String STRING_COMPLETE = 'COMPLETE';
const String STRING_DELETE = 'DELETE';
const String STRING_DELETE_SUCCESS = 'Deleted Successfully!';
const String STRING_UPDATE = 'UPDATE';
const String STRING_DISMISS = 'Dismiss';

const String STRING_SIGN_OUT = 'Sign Out';

const String STRING_WENT_WRONG = 'Something went wrong!';

const String STRING_SENDING_SELL_REQUEST = 'Sending Sell Request...';
const String STRING_DELETING = 'Deleting...';
const String STRING_UPDATING = 'Updating...';
const String STRING_PLEASE_WAIT = 'Please Wait...';
const String STRING_SIGNING_IN = 'Signing in...';
const String STRING_SIGNING_OUT = 'Signing out...';
const String STRING_VERIFICATION_FAILED = 'Verification failed !';
const String STRING_SIGNING_OUT_FAILED = 'Signing out failed...';

const String STRING_LANGUAGE = 'Language';
const String STRING_SELECT_LANGUAGE = 'Select Language';
const String STRING_SHARE = 'Share';

const String APP_DESC_MSG = 'APP_DESC_MSG';

const String STRING_HELP = 'Help';

const String STRING_HELP_BODY = 'body=Please%20type%20your%20query%20here...';
const String STRING_HELP_SUB = 'subject=HelloKishan%20Help';

const String STRING_LOWEST_PRICE_FIRST = 'Lowest Price First';
const String STRING_HIGHEST_PRICE_FIRST = 'Highest Price First';
const String STRING_NEAREST_FIRST = 'Nearest first';

const String STRING_MAXIMUM = 'Maximum';

const String STRING_VEGETABLES = 'Vegetables';
const String STRING_FERTILIZERS = 'Fertilizers';
const String STRING_PESTICIDES = 'Pesticides';
const String STRING_INSECTICIDES = 'Insecticides';
const String STRING_FUNGICIDES = 'Fungicides';
const String STRING_HERBICIDES = 'Herbicides';
