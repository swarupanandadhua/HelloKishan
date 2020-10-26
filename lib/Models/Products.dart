const List<List<String>> FERTLIZERS = [
  ['পরশ SSP', 'Paras SSP', 'assets/images/paras-ssp.png', '0'],
  ['পরশ ১০-২৬', 'Paas 10-26', 'assets/images/paras-10-26-26.png', '1'],
  ['পরশ 12-32', 'Paras 12-32', 'assets/images/paras-12-32-16.png', '2'],
  ['পরশ 14-35', 'Paras 14-35', 'assets/images/paras-14-35-14.png', '3'],
  ['পরশ ডি.এ.পি.', 'Paras DAP', 'assets/images/paras-dap.png', '4'],
  ['পরশ MOP', 'Paras MOP', 'assets/images/paras-mop.png', '5'],
];

/* main() {
  for (int i = 0; i < PRODUCTS.length; i++) {
    print("['${PRODUCTS[i][1]}', '${PRODUCTS[i][2]}', '${PRODUCTS[i][3]}'],");
  }
} */

const PROD_NAME_IDX = 0;
const PROD_LOGO_IDX = 1;
const PROD_ID_IDX = 2;

const List<List<String>> PRODUCTS = [
  // TODO: Inserting the index at the end is a hack, get rid of it
  // সবজি
  ['Arum', 'assets/images/arum.jpg', '0'],
  ['Bitter Gourd', 'assets/images/bitter_gourd.jpg', '1'],
  ['Green Chili', 'assets/images/green_chili.jpg', '2'],
  ['Coccinia', 'assets/images/coccinia.jpg', '3'],
  ['Pumpkin', 'assets/images/pumpkin.jpg', '4'],
  ['Ridge Gourd', 'assets/images/ridge_gourd.jpg', '5'],
  ['Ladies Finger', 'assets/images/ladies_finger.jpg', '6'],
  ['Parwal', 'assets/images/parwal.jpg', '7'],
  ['Bean - Cowpea', 'assets/images/bean_cowpea.jpg', '8'],
  ['Brinjal', 'assets/images/brinjal.jpg', '9'],
  ['Eggplant', 'assets/images/eggplant.jpg', '10'],
  ['Bottle Gourd', 'assets/images/bottle_gourd.jpg', '11'],
  ['Cucumber', 'assets/images/cucumber.jpg', '12'],

  // Winter
  ['Kohlrabi', 'assets/images/kohlrabi.jpg', '13'],
  ['Carrot', 'assets/images/carrot.jpg', '14'],
  ['Tomato', 'assets/images/tomato.jpg', '15'],
  ['Coriander Leaves', 'assets/images/coriander_leaves.jpg', '16'],
  ['Spinach', 'assets/images/spinach.jpg', '17'],
  ['Cauliflower', 'assets/images/cauliflower.jpg', '18'],
  ['Cabbage', 'assets/images/cabbage.jpg', '19'],
  ['Bean', 'assets/images/bean.jpg', '20'],
  ['Beet', 'assets/images/beet.jpg', '21'],
  ['Green Pea', 'assets/images/green_pea.jpg', '22'],
  ['Radish', 'assets/images/radish.jpg', '23'],
  ['Broad Bean', 'assets/images/broad_bean.jpg', '24'],
  ['Capsicum', 'assets/images/capsicum.jpg', '25'],
  ['Red Capsicum', 'assets/images/capsicum_red.jpg', '26'],

  ['Ginger', 'assets/images/ginger.jpg', '27'],
  ['Garlic', 'assets/images/garlic.jpg', '28'],
  ['Onion', 'assets/images/onion.jpg', '29'],
  ['Potato', 'assets/images/potato.jpg', '30'],

  ['Turmeric', 'assets/images/app_logo.jpg', '31'],
  ['Elephant Foot Yam', 'assets/images/app_logo.jpg', '32'],
  ['Drum Stick', 'assets/images/app_logo.jpg', '33'],
  ['Banana Flower', 'assets/images/app_logo.jpg', '34'],
  ['Guava', 'assets/images/guava.jpg', '35'],
  ['Green Banana', 'assets/images/app_logo.jpg', '36'],
  ['Green Papaya', 'assets/images/app_logo.jpg', '37'],
  ['Maize', 'assets/images/app_logo.jpg', '38'],
  ['Lemon', 'assets/images/app_logo.jpg', '39'],

  ['Green Cucumber', 'assets/images/app_logo.jpg', '40'],
  ['Snake Gourd', 'assets/images/app_logo.jpg', '41'],
  ['Zucchini', 'assets/images/app_logo.jpg', '42'],
  ['Broccoli', 'assets/images/broccoli.jpg', '43'],
  ['Mushroom', 'assets/images/app_logo.jpg', '44'],
  ['Turnip', 'assets/images/app_logo.jpg', '45'],
  ['Sweet Bitter Gourd', 'assets/images/sweet_bitter_gourd.jpg', '46'],

  // শাক
  ['Bindweed', 'assets/images/app_logo.jpg', '47'],
  ['Basil', 'assets/images/app_logo.jpg', '48'],
  ['Mint', 'assets/images/app_logo.jpg', '49'],
  ['Leek', 'assets/images/app_logo.jpg', '50'],
  ['Read Leafy', 'assets/images/app_logo.jpg', '51'],
  ['Lettuce', 'assets/images/app_logo.jpg', '52'],
  ['Cress', 'assets/images/app_logo.jpg', '53'],
  //['পাট শাক', '???', 'assets/images/app_logo.jpg', '54'],
  //['শুশনী শাক', '???', 'assets/images/app_logo.jpg', '55'],
  //['কুলেখাড়া শাক', '???', 'assets/images/app_logo.jpg', '56'],
  //['লাউ শাক', '???', 'assets/images/app_logo.jpg', '57'],
  //['বেথুয়া শাক', '???', 'assets/images/app_logo.jpg', '58'],
  //['গিমা শাক', '???', 'assets/images/app_logo.jpg', '59'],
  //['সজনে শাক', '???', 'assets/images/app_logo.jpg', '60'],
  //['কুমড়ো শাক', '???', 'assets/images/app_logo.jpg', '61'],
  //['মুলো শাক', '???', 'assets/images/app_logo.jpg', '62'],
  //['পুটুস শাক', '???', 'assets/images/app_logo.jpg', '63'],

  //['বাদাম', '???', 'assets/images/app_logo.jpg', '57'],
  //['কুরকুরি ছাতু', '???', 'assets/images/app_logo.jpg', '57'],
  ['Watermelon', 'assets/images/watermelon.jpg', '54'],
  //['উচ্ছে', '???', 'assets/images/app_logo.jpg', '57'],
];

/****সবজি****
এঁচোড়
চালতা
কামরাঙ্গা
আমড়া
কালমেঘ লঙ্কা
লুরকি বেগুন
**************/

/****ফল****
আম
জাম
খেজুর
মুসাম্বি লেবু
কাগজি লেবু
বাতাবি লেবু
গন্ধরাজ লেবু
তাল
আনারস
কাঁঠাল
কলা পাকা
সিঙ্গাপুরি কলা
পেয়ারা
লিচু
আপেল
আঙ্গুর
কুল
নারকেল কুল
চেরি
তরমুজ
পাকা পেঁপে
কাজুবাদাম
নারকেল
ডাব
************/
