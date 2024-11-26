import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller for Accommodation Preferences
class AccommodationPreferenceController extends GetxController {
  var stay = <String>[].obs;

  void toggleItem(String accommodation) {
    stay.contains(accommodation)
        ? stay.remove(accommodation)
        : stay.add(accommodation);
  }
}

class FoodPreferenceController extends GetxController {
  // Observable list to track selected food preferences
  var foods = <String>[].obs;

  // Toggle food selection
  void toggleFood(String food) {
    if (foods.contains(food)) {
      foods.remove(food);
    } else {
      foods.add(food);
    }
  }
}

class TravelPreferenceController extends GetxController {
  // Observable list to track selected travel preferences
  var travels = <String>[].obs;

  // Toggle travel preference selection
  void toggleTravel(String travel) {
    if (travels.contains(travel)) {
      travels.remove(travel);
    } else {
      travels.add(travel);
    }
  }
}

class ActivityPreferenceController extends GetxController {
  // Observable list for selected activity preferences
  var selectedActivities = <String>[].obs;

  // Toggle activity preference selection
  void toggleActivity(String activity) {
    if (selectedActivities.contains(activity)) {
      selectedActivities.remove(activity);
    } else {
      selectedActivities.add(activity);
    }
  }
}

class KidController extends GetxController {
  // Create an observable variable for kid
  var kid =
      false.obs; // Initially false, you can change this based on your need

  // Function to toggle the kid value
  void toggleKid(bool value) {
    kid.value = value;
  }
}

class SwitchController extends GetxController {
  // Define the reactive bool state
  var localEvents = false.obs;

  // Function to toggle the value
  void toggleLocalEvents(bool value) {
    localEvents.value = value;
  }
}

class SingleFoodPrefController extends GetxController {
  // Define the reactive bool for food preference
  var singleFoodPref = false.obs;

  // Toggle function to update the preference
  void toggleSingleFoodPref(bool value) {
    singleFoodPref.value = value;
  }
}

class RatingController extends GetxController {
  var rating = 3.0.obs; // Define the reactive rating variable

  void updateRating(double newRating) {
    rating.value = newRating; // Update the rating
  }
}

class OriginCityController extends GetxController {
  var originCity = ''.obs; // Reactive variable for originCity

  void updateCity(String city) {
    originCity.value = city;
  }

  void clearCity() {
    originCity.value = '';
  }
}

class BudgetController extends GetxController {
  var budget = "50000".obs; // Observable budget value
  var isEditing = false.obs; // Observable editing state
  TextEditingController textController = TextEditingController();

  // Method to update the budget
  void updateBudget(String newBudget) {
    budget.value = newBudget;
    textController.text = newBudget; // Update the controller's text value
  }
}
