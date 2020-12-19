class Category {
  final String id;
  final String name;
  final String image;
  final List<Category> subcategories;
  final List<List<String>> prodList;

  int getHash() {
    return id.hashCode;
  }

  const Category(
    this.id,
    this.name,
    this.image,
    this.subcategories,
    this.prodList,
  );
}

const List<Category> CATEGORIES = [
  Category('VEG', 'Vegetables', 'assets/images/app_logo.jpg', null, VEGETABLES),
  Category('FRUIT', 'Fruits', 'assets/images/app_logo.jpg', null, null),
  Category('FLWR', 'Flowers', 'assets/images/app_logo.jpg', null, null),
  Category('FERT', 'Fertilizers', 'assets/images/app_logo.jpg', null, FERTLIZERS),
  Category('PSIDE', 'Pesticides', 'assets/images/app_logo.jpg', null, null),
  Category('ISIDE', 'Insecticides', 'assets/images/app_logo.jpg', null, null),
  Category('FSIDE', 'Fungicides', 'assets/images/app_logo.jpg', null, null),
  Category('HSIDE', 'Herbicides', 'assets/images/app_logo.jpg', null, null),
  Category(
    'SEED',
    'Seeds',
    'assets/images/app_logo.jpg',
    <Category>[
      Category('SEED-VEG', 'Vegetable Seeds', 'assets/images/app_logo.jpg', null, null),
      Category('SEED-FRUIT', 'Fruit Seeds', 'assets/images/app_logo.jpg', null, null),
      Category('SEED-FLWR', 'Flower Seeds', 'assets/images/app_logo.jpg', null, null),
    ],
    null,
  ),
  Category('MACH', 'Machinaries', 'assets/images/app_logo.jpg', null, null),
];

const List<List<String>> FERTLIZERS = [
  ['Paras SSP', 'assets/images/paras-ssp.png', '0'],
  ['Paras 10-26', 'assets/images/paras-10-26-26.png', '1'],
  ['Paras 12-32', 'assets/images/paras-12-32-16.png', '2'],
  ['Paras 14-35', 'assets/images/paras-14-35-14.png', '3'],
  ['Paras DAP', 'assets/images/paras-dap.png', '4'],
  ['Paras MOP', 'assets/images/paras-mop.png', '5'],
];

const PROD_NAME_IDX = 0;
const PROD_LOGO_IDX = 1;
const PROD_ID_IDX = 2;

const List<String> HOME_PAGE_BANNERS = [
  'assets/images/banner.jpg',
  'assets/images/banner.jpg',
  'assets/images/banner.jpg',
  'assets/images/banner.jpg',
];

const List<List<String>> VEGETABLES = [
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

  ['Watermelon', 'assets/images/watermelon.jpg', '54'],
  // বাদাম, কুরকুরি ছাতু, উচ্ছে
];

// শাক : পাট শাক, শুশনী শাক, কুলেখাড়া শাক, লাউ শাক, বেথুয়া শাক, গিমা শাক, সজনে শাক, কুমড়ো শাক, মুলো শাক, পুটুস শাক
// সবজি : এঁচোড়, চালতা, কামরাঙ্গা, আমড়া, কালমেঘ লঙ্কা, লুরকি বেগুন
// ফল : আম, জাম, খেজুর, মুসাম্বি লেবু, কাগজি লেবু, বাতাবি লেবু, গন্ধরাজ লেবু, তাল, আনারস, কাঁঠাল, কলা পাকা, সিঙ্গাপুরি কলা, পেয়ারা, লিচু, আপেল, আঙ্গুর, কুল, নারকেল কুল, চেরি, তরমুজ, পাকা পেঁপে, কাজুবাদাম, নারকেল, ডাব
