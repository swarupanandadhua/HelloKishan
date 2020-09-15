import 'package:FarmApp/Screens/Common/Translate.dart';

String displayRate(String rate) {
  return '$STRING_RATE : ${numE2B(rate)} $STRING_RS_PER_KG';
}

String displayQty(String qty) {
  return '$STRING_QUANTITY : ${numE2B(qty)} $STRING_KG';
}

String displayAmt(String amt) {
  return '$STRING_TOTAL_AMT: ${numE2B(amt)} $STRING_RS';
}

const String STRING_APP_NAME = 'FarmApp';

// Mobile
const String STRING_MOBILE = 'মোবাইল নম্বর';
// Enter Mobile Number
const String STRING_ENTER_MOBILE_NUMBER = 'মোবাইল নম্বর লিখুন';
const String STRING_MUST_BE_10_DIGITS = 'অবশ্যই ১০ সংখ্যার হবে';
// Must be 10 digits

// Send OTP
const String STRING_SEND_OTP = 'ও.টি.পি পাঠান';
// Enter the OTP
const String STRING_ENTER_OTP = 'ও.টি.পি লিখুন';
// OTP must be 6 digits
const String STRING_OTP_MUST_6_DIGITS = 'অবশ্যই ৬ সংখ্যার হবে';

// Profile Update
const String STRING_PROFILE_UPDATE = 'প্রোফাইল আপডেট';

// Personal Information
const String STRING_PERSONAL_INFORMATION = 'ব্যক্তিগত তথ্য';

// Your Name
const String STRING_YOUR_NAME = 'আপনার নাম';
// Enter your name
const String STRING_ENTER_YOUR_NAME = 'আপনার নাম লিখুন';
// Enter a valid name
const String STRING_ENTER_VALID_NAME = 'সঠিক নাম লিখুন';

// Getting Location...
const String STRING_GETTING_LOCATION = 'অবস্থান নির্ণয় করা হচ্ছে...';

// Address Information
const String STRING_ADDRESS_INFORMATION = 'ঠিকানার তথ্য';

// Address
const String STRING_ADDRESS = 'ঠিকানা';
// House / Street / Locality Name
const String STRING_HOUSE_STREET_LOCALITY = 'বাড়ি / রাস্তা / লোকালয়ের নাম';
// Enter a valid address
const String STRING_ENTER_VALID_ADDRESS = 'ঠিকানা সঠিক নয়';

// District
const String STRING_DISTRICT = 'জেলার নাম';
// Enter your district
const String STRING_ENTER_YOUR_DISTRICT = 'জেলার নাম লিখুন';

// State
const String STRING_STATE = 'রাজ্যের নাম';
// Enter State
const String STRING_ENTER_STATE = 'রাজ্যের নাম লিখুন';
// Enter a valid state
const String STRING_ENTER_VALID_STATE = 'রাজ্যের নাম সঠিক নয়';

// Pin Code
const String STRING_PIN_CODE = 'পিন কোড';
// Enter Pin Code
const String STRING_ENTER_PIN_CODE = 'পিন কোড লিখুন';

// PROCEED
const String STRING_PROCEED = 'সেভ করুন';

// KG
const String STRING_KG = 'কেজি';

// RS_PER_KG
const String STRING_RS_PER_KG = 'টাকা/কেজি';
// RS
const String STRING_RS = 'টাকা';
// Enter price/kg
const String STRING_ENTER_PRICE_PER_KG = 'দাম (প্রতি কেজি)';

// Enter quantity (in kg)
const String STRING_ENTER_QUANTITY = 'পরিমান (কেজি)';

const String STRING_ENTER_VALID_PRICE = 'Enter a valid price';

const String STRING_ENTER_VALID_QUANTITY = 'Enter a valid quantity';

// Home
const String STRING_HOME = 'Home';
// Profile
const String STRING_PROFILE = 'প্রোফাইল';
// History
const String STRING_HISTORY = 'History';

const String STRING_I_WANT_TO = 'I want to...';
const String STRING_KYC = 'KYC';
const String STRING_LOADING_USER_DATA = 'Loading User Data...';
const String STRING_LOWEST_PRICE_FIRST = 'Lowest Price First';

const String STRING_NOTHING_FOUND = 'Nothing found!';
const String STRING_NO_BUYER_SELLER_FOUND = 'No buyer or seller found for ';

const String STRING_NO_REQUIREMENTS_FOUND = 'আপনি এখনও কিছু কিনতে চাননি !';
// No requirements found!

const String STRING_NO_TRANSACTIONS_FOUND = 'কোনো লেন-দেন হয়নি !';
// No transactions found!

const String STRING_POST = 'POST';
const String STRING_POST_REQUIREMENT = 'Post Requirement';

const String STRING_REQUIREMENTS = 'Requirements';
const String STRING_SAVE = 'Save';
const String STRING_SEARCH_RESULTS = 'Search Results';
const String STRING_SELECT_A_PRODUCT = 'Select a product';
const String STRING_SELECT_BUY_OR_SELL = 'Please select Buy of Sell';
const String STRING_SELECT_PRODUCT_FROM_LIST =
    'Please select a product from list';
const String STRING_SELL = 'Sell';
const String STRING_PLEASE_WAIT = 'Please Wait...';

const String STRING_BOUGHT_FROM = 'Bought from';
const String STRING_BUY = 'Buy';

const String STRING_SELLING_TO = 'বিক্রি হচ্ছে';
// Selling to

const String STRING_BUYING_FROM = 'কেনা হচ্ছে';
// Buying from

// Rate
const String STRING_RATE = 'দর';
// Quantity
const String STRING_QUANTITY = 'পরিমাণ';
// Total Amount
const String STRING_TOTAL_AMT = 'মোট দাম';

// ACCEPTED
const String STRING_ACCEPTED = 'Kinte i66uk';
// REQUESTED
const String STRING_REQUESTED = 'REQUESTED';

// গ্রহণ করুন ACCEPT
const String STRING_ACCEPT = 'নিয়ে আসুন';
// প্রত্যাখ্যান করুন REJECT
const String STRING_REJECT = 'নিতে চাইনা';
// CANCEL
const String STRING_CANCEL = 'বাতিল করুন';
// COMPLETE
const String STRING_COMPLETE = 'সফল হয়েছে';
// DELETE
const String STRING_DELETE = 'মুছে ফেলুন';
// UPDATE
const String STRING_UPDATE = 'আপডেট করুন';

const String STRING_SELL_REQUEST = 'Sell Request';
const String STRING_SENDING_REQUEST = 'Sending Request...';
const String STRING_DELETING = 'Deleting...';
const String STRING_SETTINGS = 'Settings';
const String STRING_SIGN_OUT = 'Sign Out';
const String STRING_SOLD_TO = 'Sold to';
const String STRING_SOMETHING_WENT_WRONG = 'Something went wrong!';
const String STRING_SORT_BY_DISTANCE = 'Sort by distance';
const String STRING_TODO_IMPORTANT_FUNCTIONALITY = 'TODO : IMPORTANT FUNC.';
const String STRING_TRADE = 'Trade';
const String STRING_UPDATING_PROFILE_INFO = 'Updating Profile Information...';
const String STRING_UPLOADING_PROFILE_PICTURE = 'Uploading Profile Picture...';
const String STRING_WELCOME_USER = 'Welcome User';
const String STRING_FEEDBACK = 'Feedback';
const String STRING_HELP = 'Help';
const String STRING_HELP_BODY = 'body=Please%20type%20your%20query%20here...';
const String STRING_HELP_SUB = 'subject=FarmApp%20Help';
const String STRING_HIGHEST_PRICE_FIRST = 'Highest Price First';
