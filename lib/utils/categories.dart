import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/utils/utilities.dart';

const String jsonCategories = '''[
  {
    "id": 1,
    "category": "Toiletries*",
    "item": "Qtips",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 2,
    "category": "Toiletries*",
    "item": "Toothbrush",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 3,
    "category": "Toiletries*",
    "item": "Nail Clippers",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 4,
    "category": "Toiletries*",
    "item": "Contact Solution",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 5,
    "category": "Toiletries*",
    "item": "Blemish Stick",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 6,
    "category": "Toiletries*",
    "item": "Toothpaste",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 7,
    "category": "Toiletries*",
    "item": "Hairbrush",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 8,
    "category": "Toiletries*",
    "item": "Floss",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 9,
    "category": "Toiletries*",
    "item": "Deodorant",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 10,
    "category": "Toiletries*",
    "item": "Tweezers",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 11,
    "category": "Toiletries*",
    "item": "Contacts",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 12,
    "category": "Toiletries*",
    "item": "Comb",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 13,
    "category": "Toiletries_m",
    "item": "Cologne",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 14,
    "category": "Toiletries_m",
    "item": "Shaving Gel",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 15,
    "category": "Toiletries_m",
    "item": "Shaver",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 16,
    "category": "Toiletries_m",
    "item": "Razor",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 17,
    "category": "Toiletries_f",
    "item": "Bobby pins",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 18,
    "category": "Toiletries_f",
    "item": "Hair Ties",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 19,
    "category": "Beach",
    "item": "Swimsuit",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 20,
    "category": "Beach",
    "item": "Sunglasses",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 21,
    "category": "Beach",
    "item": "Sunscreen",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 22,
    "category": "Beach",
    "item": "Hat",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 23,
    "category": "Beach",
    "item": "Sandals",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 24,
    "category": "Beach",
    "item": "Beach Towel",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 25,
    "category": "Bicycling",
    "item": "Bicycle Shoes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 26,
    "category": "Bicycling",
    "item": "Helmet",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 27,
    "category": "Bicycling",
    "item": "Sunglasses",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 28,
    "category": "Bicycling",
    "item": "Bicycle Shorts",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 29,
    "category": "Bicycling",
    "item": "Bicycle Shirt",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 30,
    "category": "Bicycling",
    "item": "Bicycle Light",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 31,
    "category": "Swimming",
    "item": "Swimsuit",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 32,
    "category": "Swimming",
    "item": "Goggles",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 33,
    "category": "Swimming",
    "item": "Sandals",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 34,
    "category": "Gym",
    "item": "Gym Shoes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 35,
    "category": "Gym",
    "item": "Gym Shorts",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 36,
    "category": "Gym",
    "item": "Gym Shirt",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 37,
    "category": "Gym",
    "item": "Gym Socks",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 38,
    "category": "Gym",
    "item": "Music Player",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 39,
    "category": "Gym",
    "item": "Headphones",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 40,
    "category": "Gym",
    "item": "Gym Towel",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 41,
    "category": "Gym",
    "item": "Sandals",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 42,
    "category": "Gym",
    "item": "Padlock",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 43,
    "category": "Gym",
    "item": "Water Bottle",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 44,
    "category": "Essentials*",
    "item": "Hand Sanitizer",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 45,
    "category": "Essentials*",
    "item": "Chapstick",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 46,
    "category": "Essentials*",
    "item": "Vitamins",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 47,
    "category": "Essentials*",
    "item": "Medications",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 48,
    "category": "Essentials*",
    "item": "Pain Reliever Pills",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 49,
    "category": "Essentials*",
    "item": "Wallet",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 50,
    "category": "Essentials*",
    "item": "Casual Watch",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 51,
    "category": "Essentials*",
    "item": "House Key",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 52,
    "category": "Essentials*",
    "item": "Socks - Long",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 53,
    "category": "Essentials*",
    "item": "Casual Shirts",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 54,
    "category": "Essentials*",
    "item": "Casual Pants",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 55,
    "category": "Essentials*",
    "item": "Belt",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 56,
    "category": "Essentials*",
    "item": "Pajamas",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 57,
    "category": "Essentials*",
    "item": "Reading Glasses",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 58,
    "category": "Essentials*",
    "item": "Sunglasses",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 59,
    "category": "Essentials*",
    "item": "Condoms",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 60,
    "category": "Essentials*",
    "item": "Ear Plugs",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 61,
    "category": "Essentials*",
    "item": "Eye Mask",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 62,
    "category": "Essentials*",
    "item": "Book",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 63,
    "category": "Essentials*",
    "item": "Camera",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 64,
    "category": "Essentials*",
    "item": "Heavy Jacket",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 65,
    "category": "Essentials*",
    "item": "Cell Phone",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 66,
    "category": "Essentials*",
    "item": "Cell Phone Charger",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 67,
    "category": "Essentials*",
    "item": "Boarding Pass",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 68,
    "category": "Essentials*",
    "item": "Printed Trip Itinerary",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 69,
    "category": "Essentials_f",
    "item": "Panties",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 70,
    "category": "Essentials_f",
    "item": "Bra",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 71,
    "category": "Essentials_f",
    "item": "Sanitary Pads",
    "is_hidden": 1,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 72,
    "category": "International",
    "item": "Passport",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 73,
    "category": "International",
    "item": "Visa (Immigration)",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 74,
    "category": "International",
    "item": "Vaccination Certificates",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 75,
    "category": "International",
    "item": "Medical Insurance Card",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 76,
    "category": "International",
    "item": "Foreign Currency",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 77,
    "category": "International",
    "item": "Power Adapter",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 78,
    "category": "International",
    "item": "Power Transformer",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 79,
    "category": "International",
    "item": "Check Electronics Voltages",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 80,
    "category": "International",
    "item": "Pen",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 81,
    "category": "Business Casual",
    "item": "Suit Jacket",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 82,
    "category": "Business Casual",
    "item": "Work Shirt",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 83,
    "category": "Business Casual",
    "item": "Work Pants",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 84,
    "category": "Business Casual",
    "item": "Work Shoes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 85,
    "category": "Business Casual",
    "item": "Work Socks",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 86,
    "category": "Business Casual",
    "item": "Work Belt",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 87,
    "category": "Business Casual",
    "item": "Formal Watch",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 88,
    "category": "Business Casual",
    "item": "Shoe Polish",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 89,
    "category": "Business Formal",
    "item": "Work Shirt",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 90,
    "category": "Business Formal",
    "item": "Work Pants",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 91,
    "category": "Business Formal",
    "item": "Work Shoes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 92,
    "category": "Business Formal",
    "item": "Work Socks",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 93,
    "category": "Business Formal",
    "item": "Work Belt",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 94,
    "category": "Business Formal",
    "item": "Formal Watch",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 95,
    "category": "Business Formal",
    "item": "Shoe Polish",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 96,
    "category": "Business Formal",
    "item": "Tie",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 97,
    "category": "Business Formal",
    "item": "Cufflinks",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 98,
    "category": "Baby",
    "item": "Diapers",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 99,
    "category": "Baby",
    "item": "Changing Pad",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 100,
    "category": "Baby",
    "item": "Blankets",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 101,
    "category": "Baby",
    "item": "Plastic Bags",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 102,
    "category": "Baby",
    "item": "Daiper Rash Cream",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 103,
    "category": "Baby",
    "item": "Baby Wipes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 104,
    "category": "Baby",
    "item": "Disinfecting Hand Gel",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 105,
    "category": "Baby",
    "item": "Baby Soap",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 106,
    "category": "Baby",
    "item": "Baby Lotion",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 107,
    "category": "Baby",
    "item": "Tissues",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 108,
    "category": "Baby",
    "item": "Pacifier",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 109,
    "category": "Baby",
    "item": "Baby Toys",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 110,
    "category": "Baby",
    "item": "Baby Clothes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 111,
    "category": "Baby",
    "item": "Baby Socks",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 112,
    "category": "Baby",
    "item": "Baby Shoes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 113,
    "category": "Baby",
    "item": "Baby Bib",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 114,
    "category": "Baby",
    "item": "Baby Hat",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 115,
    "category": "Baby",
    "item": "Baby Food",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 116,
    "category": "Baby",
    "item": "Baby Formula",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 117,
    "category": "Baby",
    "item": "Plastic Utensils",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 118,
    "category": "Baby",
    "item": "Water And/or Juice",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 119,
    "category": "Baby",
    "item": "Baby Bottle + Nipples",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 120,
    "category": "Baby",
    "item": "Baby Sippy Cup",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 121,
    "category": "Baby",
    "item": "Energy Snacks",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 122,
    "category": "Baby",
    "item": "Breastpump",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 123,
    "category": "Baby",
    "item": "Night Light",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 124,
    "category": "Baby",
    "item": "First Aid Kit",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 125,
    "category": "Baby",
    "item": "Baby Pain Reliever",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 126,
    "category": "Baby",
    "item": "Baby Sling or Front Carrier",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 127,
    "category": "Baby",
    "item": "Portable Crib",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 128,
    "category": "Baby",
    "item": "Inflatable Baby Batchtub",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 129,
    "category": "Baby",
    "item": "Baby Car Seat",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:53",
    "updated_at": "2022-08-21 06:47:53"
  },
  {
    "id": 130,
    "category": "Baby",
    "item": "Collapsible Stroller",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 131,
    "category": "Baby",
    "item": "Baby Birth Certificate",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 132,
    "category": "Baby",
    "item": "Baby Gas Reliever",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 133,
    "category": "Baby",
    "item": "Consent To Travel Form",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 134,
    "category": "Baby",
    "item": "Baby Sunscreen",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 135,
    "category": "Hiking",
    "item": "Hiking Shoes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 136,
    "category": "Hiking",
    "item": "Shirts (non-cotton)",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 137,
    "category": "Hiking",
    "item": "Socks (non-cotton)",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 138,
    "category": "Hiking",
    "item": "Pants (non-cotton)",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 139,
    "category": "Hiking",
    "item": "Water Bottle",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 140,
    "category": "Hiking",
    "item": "Hat",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 141,
    "category": "Hiking",
    "item": "Bug Spray",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 142,
    "category": "Hiking",
    "item": "Sunscreen",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 143,
    "category": "Hiking",
    "item": "First Aid Kit",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 144,
    "category": "Hiking",
    "item": "Sunglasses",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 145,
    "category": "Hiking",
    "item": "Compass",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 146,
    "category": "Hiking",
    "item": "GPS",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 147,
    "category": "Photography",
    "item": "Camera",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 148,
    "category": "Photography",
    "item": "Tripod",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 149,
    "category": "Photography",
    "item": "Monopod",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 150,
    "category": "Photography",
    "item": "Memory Cards",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 151,
    "category": "Photography",
    "item": "Batteries",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 152,
    "category": "Photography",
    "item": "Camera Charger",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 153,
    "category": "Photography",
    "item": "Battery Charger",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 154,
    "category": "Photography",
    "item": "Camera Bag",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 155,
    "category": "Working",
    "item": "Laptop",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 156,
    "category": "Working",
    "item": "Laptop Charger",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 157,
    "category": "Working",
    "item": "Work Badge",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 158,
    "category": "Working",
    "item": "Work Cell Phone",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 159,
    "category": "Working",
    "item": "Work Cell Phone Charger",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 160,
    "category": "Working",
    "item": "Business Cards",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 161,
    "category": "Snow Sports",
    "item": "Snow Jacket",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 162,
    "category": "Snow Sports",
    "item": "Snow Pants",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 163,
    "category": "Snow Sports",
    "item": "Snow Gat/Beanie",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 164,
    "category": "Snow Sports",
    "item": "Sunglasses",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 165,
    "category": "Snow Sports",
    "item": "Snow Gloves",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 166,
    "category": "Snow Sports",
    "item": "Chapstick",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 167,
    "category": "Snow Sports",
    "item": "Skin Moisturizer",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 168,
    "category": "Snow Sports",
    "item": "Sunscreen",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 169,
    "category": "Snow Sports",
    "item": "Long Underwear",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 170,
    "category": "Motorcycling",
    "item": "Motorcycle Jacket",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 171,
    "category": "Motorcycling",
    "item": "Motorcycle Pants",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 172,
    "category": "Motorcycling",
    "item": "Motorcycle Boots",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 173,
    "category": "Motorcycling",
    "item": "Motorcycle Gloves",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 174,
    "category": "Motorcycling",
    "item": "Helmet",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 175,
    "category": "Motorcycling",
    "item": "Ear Plugs",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 176,
    "category": "Motorcycling",
    "item": "Headphones",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 177,
    "category": "Motorcycling",
    "item": "Music Player",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 178,
    "category": "Motorcycling",
    "item": "Shield Cleaner",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 179,
    "category": "Motorcycling",
    "item": "Microfiber Towels",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 180,
    "category": "Motorcycling",
    "item": "Rain Gear",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 181,
    "category": "Motorcycling",
    "item": "Spare Gloves",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 182,
    "category": "Motorcycling",
    "item": "Spare Sunglasses",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 183,
    "category": "Motorcycling",
    "item": "Dry Bag for Clothing",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 184,
    "category": "Motorcycling",
    "item": "Bungee Cords",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 185,
    "category": "Motorcycling",
    "item": "Tool Bag",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 186,
    "category": "Motorcycling",
    "item": "Tire Repair Kit",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 187,
    "category": "Motorcycling",
    "item": "Electrical Tape",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 188,
    "category": "Motorcycling",
    "item": "Zip Ties",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 189,
    "category": "Motorcycling",
    "item": "Rescue Tape",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 190,
    "category": "Motorcycling",
    "item": "Chain Lube",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 191,
    "category": "Motorcycling",
    "item": "Motorcycle GPS",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 192,
    "category": "Motorcycling",
    "item": "SPOT Beacon",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 193,
    "category": "Motorcycling",
    "item": "Solar Charger for Gadgets",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 194,
    "category": "Motorcycling",
    "item": "Hard Case for Gadgets",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 195,
    "category": "Motorcycling",
    "item": "Waterproof Pouch",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 196,
    "category": "Camping",
    "item": "Tent",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 197,
    "category": "Camping",
    "item": "Sleeping Bag",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 198,
    "category": "Camping",
    "item": "Sleeping Pad",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 199,
    "category": "Camping",
    "item": "Pillow",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 200,
    "category": "Camping",
    "item": "Eating Utensils",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 201,
    "category": "Camping",
    "item": "Cooking Tools",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 202,
    "category": "Camping",
    "item": "Flashlight",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 203,
    "category": "Camping",
    "item": "Headlamp",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 204,
    "category": "Camping",
    "item": "Firewood",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 205,
    "category": "Camping",
    "item": "Matches/Lighter",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 206,
    "category": "Camping",
    "item": "Camping Food",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 207,
    "category": "Camping",
    "item": "Snacks",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 208,
    "category": "Camping",
    "item": "Tick Remover",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 209,
    "category": "Camping",
    "item": "Shirts (non-cotton)",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 210,
    "category": "Camping",
    "item": "Socks (non-cotton)",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 211,
    "category": "Camping",
    "item": "Pants (non-cotton)",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 212,
    "category": "Camping",
    "item": "First Aid Kit",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 213,
    "category": "Camping",
    "item": "Water Filter",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 214,
    "category": "Camping",
    "item": "Compass",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 215,
    "category": "Camping",
    "item": "Towel",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 216,
    "category": "Camping",
    "item": "Utility Knife",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 217,
    "category": "Camping",
    "item": "Long Underwear",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 218,
    "category": "Fancy Dinner",
    "item": "Suit Jacket",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 219,
    "category": "Fancy Dinner",
    "item": "Work Shirt",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 220,
    "category": "Fancy Dinner",
    "item": "Work Pants",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 221,
    "category": "Fancy Dinner",
    "item": "Work Shoes",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 222,
    "category": "Fancy Dinner",
    "item": "Work Socks",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 223,
    "category": "Fancy Dinner",
    "item": "Work Belt",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 224,
    "category": "Fancy Dinner",
    "item": "Formal Watch",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  },
  {
    "id": 225,
    "category": "Fancy Dinner",
    "item": "Shoe Polish",
    "is_hidden": 0,
    "created_at": "2022-08-21 06:47:54",
    "updated_at": "2022-08-21 06:47:54"
  }
]''';

List<String> flightClasses = [
  'Economy Class',
  'Premium Economy Class',
  'Business Class',
  'First Class'
];
List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

List<String> continents = [
  'Asia',
  'Australia',
  'Africa',
  'South America',
  'North America',
  'Europe',
];

List<String> accommodations = [
  'Hotel',
  'Hostel',
  'Homestay',
];

final climates = [
  DropdownType("Warm and sunny", Assets.assetsColdweather, isPng: true),
  DropdownType("Mild and cloudy", Assets.assetsCold),
  DropdownType("Rainy with showers", Assets.assetsModerate),
  DropdownType("Cold and snowy", Assets.assetsHot),
  DropdownType("Humid with tropical", Assets.assetsHot),
  DropdownType("Dry and arid", Assets.assetsHot)
];
final landscapes = [
  DropdownType("Mountains", Assets.assetsColdweather, isPng: true),
  DropdownType("Beaches", Assets.assetsCold),
  DropdownType("Forests", Assets.assetsModerate),
  DropdownType("Desert", Assets.assetsHot)
];
final modeOfTravel = [
  DropdownType('Flight', Assets.assetsFlight),
  DropdownType('Train', Assets.assetsTrain),
  DropdownType('Bus', Assets.assetsBus),
  DropdownType('Car', Assets.assetsCar)
];
final itineraryTravel = [
  DropdownType('Flight', Assets.assetsFlight),
  DropdownType('Train', Assets.assetsTrain),
  DropdownType('Bus', Assets.assetsBus),
  DropdownType('Car Rental', Assets.assetsCarRent),
  DropdownType('Bike Rental', Assets.assetsBikeRent),
  DropdownType('Public Transport only', Assets.assetsBikeRent)
];

final purposes = [
  DropdownType('Bachelors trip', Assets.assetsBachelors),
  DropdownType('Bachelorette trip', Assets.assetsBachelorette),
  DropdownType('Leisure trip', Assets.assetsLeisure),
  DropdownType('Family vacation', Assets.assetsFamily),
  DropdownType('Honeymoon', Assets.assetsHoneymoonRec),
  DropdownType('Business trip', Assets.assetsBusinessRec),
  DropdownType('Spiritual retreat', Assets.assetsSpiritual),
];
final itineraryTrips = [
  DropdownType('Honeymoon', Assets.assetsHoneymoon),
  DropdownType('Family vacation', Assets.assetsFamityVacation),
  DropdownType('Party and night life', Assets.assetsPartyLife),
  DropdownType('Cultural exploration', Assets.assetsCulture),
  DropdownType('Relaxed getaway', Assets.assetsRelex),
  DropdownType('Adventure', Assets.assetsRelex),
];
final itineraryFood = [
  DropdownType('Vegetarian', Assets.assetsIndianFood),
  DropdownType('Vegan', Assets.assetsChinaFood),
  DropdownType('italian', Assets.assetsItalianFood),
  DropdownType('Indian', Assets.assetsIndianFood),
  DropdownType('Chinese', Assets.assetsChinaFood),
  DropdownType('American', Assets.assetsThaiFood),
  DropdownType('Mexican', Assets.assetsMexicanFood),
  DropdownType('Japanese', Assets.assetsJapanFood),
  DropdownType('Thai', Assets.assetsThaiFood),
];

final itineraryActivity = [
  DropdownType('Sightseeing and CulturalExploration', ''),
  DropdownType('Adventure and Outdoor Activities', ''),
  DropdownType('Nature and wildlife', ''),
  DropdownType('Relaxation and wellness', ''),
  DropdownType('Food & Drink Experiences', ''),
  DropdownType('Nightlife & Entertainment', ''),
  DropdownType('Shopping & Local Market', ''),
  DropdownType('Religioud and Spiritual', ''),
];
