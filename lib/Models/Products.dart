const List<List<String>> PRODUCTS = [
  // TODO: Inserting the index at the end is a hack, get rid of it
  // সবজি
  ['কচু', 'Arum', 'assets/images/arum.jpg', '0'],
  ['করলা', 'Bitter Gourd', 'assets/images/bitter_gourd.jpg', '1'],
  ['কাঁচা লংকা', 'Green Chili', 'assets/images/green_chili.jpg', '2'],
  ['কুন্দরি', 'Coccinia', 'assets/images/coccinia.jpg', '3'],
  ['কুমড়া', 'Pumpkin', 'assets/images/pumpkin.jpg', '4'],
  ['ঝিংগে', 'Ridge Gourd', 'assets/images/ridge_gourd.jpg', '5'],
  ['ঢেঁড়স', 'Ladies Finger', 'assets/images/ladies_finger.jpg', '6'],
  ['পটল', 'Parwal', 'assets/images/parwal.jpg', '7'],
  ['বরবটি', 'Bean - Cowpea', 'assets/images/bean_cowpea.jpg', '8'],
  ['বেগুন', 'Brinjal', 'assets/images/brinjal.jpg', '9'],
  ['লম্বা বেগুন', 'Eggplant', 'assets/images/eggplant.jpg', '10'],
  ['লাউ', 'Bottle Gourd', 'assets/images/bottle_gourd.jpg', '11'],
  ['শসা', 'Cucumber', 'assets/images/cucumber.jpg', '12'],

  // Winter
  ['ওলকপি', 'Kohlrabi', 'assets/images/kohlrabi.jpg', '13'],
  ['গাঁজর', 'Carrot', 'assets/images/carrot.jpg', '14'],
  ['টমেটো', 'Tomato', 'assets/images/tomato.jpg', '15'],
  ['ধনেপাতা', 'Coriander Leaves', 'assets/images/coriander_leaves.jpg', '16'],
  ['পালং শাক', 'Spinach', 'assets/images/spinach.jpg', '17'],
  ['ফুলকপি', 'Cauliflower', 'assets/images/cauliflower.jpg', '18'],
  ['বাঁধাকপি', 'Cabbage', 'assets/images/cabbage.jpg', '19'],
  ['বিন', 'Bean', 'assets/images/bean.jpg', '20'],
  ['বীট', 'Beet', 'assets/images/beet.jpg', '21'],
  ['মটরশুঁটি', 'Green Pea', 'assets/images/green_pea.jpg', '22'],
  ['মুলা', 'Radish', 'assets/images/radish.jpg', '23'],
  ['শিম', 'Broad Bean', 'assets/images/broad_bean.jpg', '24'],
  ['ক্যাপসিকাম', 'Capsicum', 'assets/images/capsicum.jpg', '25'],
  ['লাল ক্যাপসিকাম', 'Red Capsicum', 'assets/images/capsicum_red.jpg', '26'],

  ['আদা', 'Ginger', 'assets/images/ginger.jpg', '27'],
  ['রসুন', 'Garlic', 'assets/images/garlic.jpg', '28'],
  ['পেঁয়াজ', 'Onion', 'assets/images/onion.jpg', '29'],
  ['আলু', 'Potato', 'assets/images/potato.jpg', '30'],

  ['হলুদ', 'Turmeric', 'assets/images/app_logo.jpg', '31'],
  ['ওল', 'Elephant Foot Yam', 'assets/images/app_logo.jpg', '32'],
  ['সজনে ডাঁটা', 'Drum Stick', 'assets/images/app_logo.jpg', '33'],
  ['কলার মোচা', 'Banana Flower', 'assets/images/app_logo.jpg', '34'],
  ['পেয়ারা', 'Guava', 'assets/images/guava.jpg', '35'],
  ['কাঁচা কলা', 'Green Banana', 'assets/images/app_logo.jpg', '36'],
  ['কাঁচা পেঁপে', 'Green Papaya', 'assets/images/app_logo.jpg', '37'],
  ['ভূট্টা', 'Maize', 'assets/images/app_logo.jpg', '38'],
  ['কাগজি লেবু', 'Lemon', 'assets/images/app_logo.jpg', '39'],

  ['চালকুমড়া', 'Green Cucumber', 'assets/images/app_logo.jpg', '40'],
  ['চিচিংগা', 'Snake Gourd', 'assets/images/app_logo.jpg', '41'],
  ['ধুন্দুল', 'Zucchini', 'assets/images/app_logo.jpg', '42'],
  ['ব্রোকলি', 'Broccoli', 'assets/images/broccoli.jpg', '43'],
  ['মাশরুম', 'Mushroom', 'assets/images/app_logo.jpg', '44'],
  ['শালগম', 'Turnip', 'assets/images/app_logo.jpg', '45'],
  [
    'কাঁকরোল',
    'Sweet Bitter Gourd',
    'assets/images/sweet_bitter_gourd.jpg',
    '46'
  ],

  // শাক
  ['কলমি শাক', 'Bindweed', 'assets/images/app_logo.jpg', '47'],
  ['পুঁই শাক', 'Basil', 'assets/images/app_logo.jpg', '48'],
  ['পুদিনা পাতা', 'Mint', 'assets/images/app_logo.jpg', '49'],
  ['পেঁয়াজ পাতা', 'Leek', 'assets/images/app_logo.jpg', '50'],
  ['লাল শাক', 'Read Leafy', 'assets/images/app_logo.jpg', '51'],
  ['লেটুসপাতা', 'Lettuce', 'assets/images/app_logo.jpg', '52'],
  ['হেলেঞ্চা শাক', 'Cress', 'assets/images/app_logo.jpg', '53'],
  ['পাট শাক', '???', 'assets/images/app_logo.jpg', '54'],
  ['শুশনী শাক', '???', 'assets/images/app_logo.jpg', '55'],
  ['কুলেখাড়া শাক', '???', 'assets/images/app_logo.jpg', '56'],
  ['লাউ শাক', '???', 'assets/images/app_logo.jpg', '57'],
  ['বেথুয়া শাক', '???', 'assets/images/app_logo.jpg', '58'],
  ['গিমা শাক', '???', 'assets/images/app_logo.jpg', '59'],
  ['সজনে শাক', '???', 'assets/images/app_logo.jpg', '60'],
  ['কুমড়ো শাক', '???', 'assets/images/app_logo.jpg', '61'],
  ['মুলো শাক', '???', 'assets/images/app_logo.jpg', '62'],
  ['পুটুস শাক', '???', 'assets/images/app_logo.jpg', '63'],

  ['বাদাম', '???', 'assets/images/app_logo.jpg', '57'],
  ['মাশরুম', 'Mushroom', 'assets/images/app_logo.jpg', '57'],
  ['কুরকুরি ছাতু', '???', 'assets/images/app_logo.jpg', '57'],
  ['তরমুজ', 'Watermelon', 'assets/images/watermelon.jpg', '57'],
  ['উচ্ছে', '???', 'assets/images/app_logo.jpg', '57'],
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
