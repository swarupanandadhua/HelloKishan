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

// INFO: Following APP_ID is used in AndroidManifest.xml as well
const String ADMOB_APP_ID = 'ca-app-pub-8285249568639559~5250421163';

const String COUNTRY_CODE_IN = '+91';

// 'FarmApp';
const String STRING_APP_NAME = 'ফার্ম অ্যাপ';

const String STRING_WELCOME_USER = 'Welcome User';

// Mobile
const String STRING_MOBILE = 'মোবাইল নম্বর';
// Enter Mobile Number
const String STRING_ENTER_MOBILE_NUMBER = 'মোবাইল নম্বর লিখুন';
const String STRING_MUST_BE_10_DIGITS = 'অবশ্যই ১০ সংখ্যার হবে';
// Must be 10 digits

// Send OTP
const String STRING_SEND_OTP = 'ও.টি.পি পাঠান';
// 'Sending OTP...'
const String STRING_SENDING_OTP = 'ও.টি.পি পাঠানো হচ্ছে...';
const String STRING_AUTO_READING_OTP = 'Auto reading OTP...';
// Enter the OTP
const String STRING_ENTER_OTP = 'ও.টি.পি লিখুন';
// OTP must be 6 digits
const String STRING_OTP_MUST_6_DIGITS = 'অবশ্যই ৬ সংখ্যার হবে';
// 'Invalid OTP !'
const String STRING_INVALID_OTP = 'ও.টি.পি সঠিক নয় !';
const String STRING_INVALID_VERIFICATION_CODE =
    'ERROR_INVALID_VERIFICATION_CODE';
// Submit
const String STRING_SUBMIT = 'সাবমিট করুন';

// Profile Update
const String STRING_PROFILE_UPDATE = 'প্রোফাইল আপডেট';

// Personal Information
const String STRING_PERSONAL_INFORMATION = 'ব্যক্তিগত তথ্য';

// Your Name
const String STRING_YOUR_NAME = 'আপনার নাম';
// Enter your name
const String STRING_ENTER_YOUR_NAME = 'আপনার নাম লিখুন';
// Enter a valid name
const String STRING_NAME_INVALID = 'নাম সঠিক নয়';

// Getting Location...
const String STRING_LOADING_LOCATION = 'অবস্থান নির্ণয় করা হচ্ছে...';

// Address Information
const String STRING_ADDRESS_INFORMATION = 'ঠিকানার তথ্য';

// Address
const String STRING_ADDRESS = 'ঠিকানা';

// House / Street / Locality Name
const String STRING_HOUSE_STREET_LOCALITY = 'বাড়ি / রাস্তা / লোকালয়ের নাম';
// Enter a valid address
const String STRING_ADDRESS_INVALID = 'ঠিকানা সঠিক নয়';

// District
const String STRING_DISTRICT_NAME = 'জেলার নাম';
// Enter your district
const String STRING_ENTER_YOUR_DISTRICT = 'জেলার নাম লিখুন';
const String STRING_DISTRICT_NAME_INVALID = 'জেলার নাম সঠিক নয়';

// State
const String STRING_STATE_NAME = 'রাজ্যের নাম';
// Enter State
const String STRING_ENTER_STATE = 'রাজ্যের নাম লিখুন';
// Enter a valid state
const String STRING_STATE_NAME_INVALID = 'রাজ্যের নাম সঠিক নয়';

// Pin Code
const String STRING_PIN_CODE = 'পিন কোড';
// Enter Pin Code
const String STRING_ENTER_PIN_CODE = 'পিন কোড লিখুন';
const String STRING_PINCODE_INVALID = 'পিন কোড সঠিক নয়';

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

// 'Enter a valid price';
const String STRING_ENTER_VALID_PRICE = 'দাম সঠিক নয়';

// 'Enter a valid quantity';
const String STRING_ENTER_VALID_QUANTITY = 'পরিমান সঠিক নয়';

// Home
const String STRING_HOME = 'Home';
// Profile
const String STRING_PROFILE = 'প্রোফাইল';

// History
const String STRING_HISTORY = 'History';

// 'No buyer found for ';
const String STRING_NO_BUYER_FOUND = 'এর কোনো ক্রেতা নেই !';

const String STRING_WANTS_TO_BUY = 'কিনতে চান';
const String STRING_NO_REQUIREMENTS_FOUND = 'আপনি এখনও কিছু কিনতে চাননি !';
// No requirements found!

const String STRING_NO_TRANSACTIONS_FOUND = 'কোনো লেন-দেন হয়নি !';
// No transactions found!

// 'POST';
const String STRING_POST = 'পোষ্ট করুন';
const String STRING_POST_REQUIREMENT = 'Post Requirement';
// Post Requirement Header
const String STRING_POST_REQUIREMENT_HEADER =
    'আপনি কী কিনতে চান, কত কেজি কিনতে চান, কত দামে কিনতে চান এবং আপনার দোকান কোথায় - নীচের শূন্যস্থান গুলিতে লিখুন';

const String STRING_REQUIREMENTS = 'Requirements';
const String STRING_SAVE = 'Save';
const String STRING_SEARCH_RESULTS = 'Search Results';

const String STRING_BUY_WHAT = 'কী কিনতে চান ?';
const String STRING_BUY_HOW_MUCH = 'কত কেজি কিনতে চান ?';
const String STRING_BUY_WHAT_PRICE = 'কত দামে কিনতে চান ?';
const String STRING_WRITE_BUY_WHAT = 'কী কিনতে চান এখনে লিখুন';

// 'Please select a product from list';
const String STRING_WHAT_SELL_SELECT_FROM_LIST =
    'কী বিক্রি করতে চান লিস্ট থেকে সিলেক্ট করুন !';

// Sell
const String STRING_SELL = 'বিক্রি করুন';

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
const String STRING_ACCEPTED = 'কিনতে ইচ্ছুক';
// REQUESTED : TODO : IMPORTANT
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

const String STRING_DELETE_SUCCESS = 'মুছে ফেলা সফল হয়েছে';

// UPDATE
const String STRING_UPDATE = 'আপডেট করুন';

// 'Dismiss'
const String STRING_DISMISS = 'বাদ দিন';

const String STRING_SELL_REQUEST = 'Sell Request';

// 'Sign Out';
const String STRING_SIGN_OUT = 'লগ আউট করুন';

const String STRING_SOLD_TO = 'Sold to';

// 'Something went wrong!';
const String STRING_WENT_WRONG = 'কিছু একটা সমস্যা হয়েছে !';

const String STRING_TODO_IMPORTANT_FUNCTIONALITY = 'TODO : IMPORTANT FUNC.';
const String STRING_TRADE = 'Trade';

// 'Sending Sell Request...';
const String STRING_SENDING_SELL_REQUEST = 'বিক্রির অনুরোধ করা হচ্ছে...';
const String STRING_DELETING = 'Deleting...';
const String STRING_UPDATING = 'Updating...';
// 'Please Wait...';
const String STRING_PLEASE_WAIT = 'অপেক্ষা করুন...';
// 'Signing in...'
const String STRING_SIGNING_IN = 'লগ ইন করা হচ্ছে...';
// 'Signing out...
const String STRING_SIGNING_OUT = 'লগ আউট করা হচ্ছে...';
// 'Verification failed !'
const String STRING_VERIFICATION_FAILED = 'লগ ইন ব্যর্থ হয়েছে !';
// 'Signing out failed...'
const String STRING_SIGNING_OUT_FAILED = 'লগ আউট ব্যর্থ হয়েছে !';

// Language
// Language
const String STRING_LANGUAGE = 'ভাষা বদলান';

// 'Share';
const String STRING_SHARE = 'সেয়ার করুন';
const String STRING_SHARE_ARG = 'TODO IMPORTANT';

// 'Help';
const String STRING_HELP = 'সাহায্য চান';

const String STRING_HELP_BODY = 'body=Please%20type%20your%20query%20here...';
const String STRING_HELP_SUB = 'subject=FarmApp%20Help';

// 'Lowest Price First';
const String STRING_LOWEST_PRICE_FIRST = 'দর : কম থেকে বেশি';
// 'Highest Price First';
const String STRING_HIGHEST_PRICE_FIRST = 'দর : বেশি থেকে কম';
// 'Nearest first';
const String STRING_NEAREST_FIRST = 'দূরত্ব : কম থেকে বেশি';

// Maximum
const String STRING_MAXIMUM = 'সর্বোচ্চ';
