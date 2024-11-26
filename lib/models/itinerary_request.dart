import 'dart:convert';

String recommendationRequestToJson(ItineraryRequest data) =>
    json.encode(data.toJson());

class ItineraryRequest {
  ItineraryRequest(
      {this.destinations = const [],
      this.tripType = '', // Changed to String
      this.budget = 0,
      this.startDate = '',
      this.endDate = '',
      this.originCity = '',
      this.departureCity = '',
      this.food = const [],
      this.singleFoodPreferred = false,
      this.modeOfTransport = const [],
      this.customText = '',
      this.accommodationType = const [],
      this.hotelCategory = 0,
      this.travelingWithKid = false,
      this.addLocalEvents = false,
      this.activityPreferences = const []});

  List<String> destinations;
  String tripType; // Changed to String
  num budget;
  String? startDate;
  String? endDate;
  String originCity;
  String departureCity;
  List<String> food;
  bool singleFoodPreferred;
  List<String> modeOfTransport;
  String customText;

  // New fields
  List<String> accommodationType;
  int hotelCategory;
  bool travelingWithKid;
  bool addLocalEvents;
  List<String> activityPreferences;

  factory ItineraryRequest.fromJson(Map<String, dynamic> json) {
    return ItineraryRequest(
      destinations: json["destinations"] == null
          ? []
          : List<String>.from(json["destinations"]!.map((x) => x)),
      tripType: json["tripType"] ?? '',
      budget: json["budget"] ?? 0,
      startDate: json["startDate"] ?? "",
      endDate: json["endDate"] ?? "",
      originCity: json["originCity"] ?? "",
      departureCity: json["departureCity"] ?? "",
      food: json["food"] == null
          ? []
          : List<String>.from(json["food"]!.map((x) => x)),
      singleFoodPreferred: json["singleFoodPreferred"] ?? false,
      modeOfTransport: json["modeOfTransport"] == null
          ? []
          : List<String>.from(json["modeOfTransport"]!.map((x) => x)),
      customText: json["customText"] ?? "",
      accommodationType: json["accommodationType"] == null
          ? []
          : List<String>.from(json["accommodationType"]!.map((x) => x)),
      hotelCategory: json["hotelCategory"] ?? 0,
      travelingWithKid: json["travelingWithKid"] ?? false,
      addLocalEvents: json["addLocalEvents"] ?? false,
      activityPreferences: json["activityPreferences"] == null
          ? []
          : List<String>.from(json["activityPreferences"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "destinations": destinations.map((x) => x).toList(),
        "tripType": tripType,
        "budget": budget,
        "startDate": startDate,
        "endDate": endDate,
        "originCity": originCity,
        "departureCity": departureCity,
        "food": food.map((x) => x).toList(),
        "singleFoodPreferred": singleFoodPreferred,
        "modeOfTransport": modeOfTransport.map((x) => x).toList(),
        "customText": customText,
        // New fields
        "accommodationType": accommodationType.map((x) => x).toList(),
        "hotelCategory": hotelCategory,
        "travelingWithKid": travelingWithKid,
        "addLocalEvents": addLocalEvents,
        "activityPreferences": activityPreferences.map((x) => x).toList(),
      };

  @override
  String toString() {
    return 'ItineraryRequest{destinations: $destinations, tripType: $tripType, budget: $budget, startDate: $startDate, endDate: $endDate, originCity: $originCity, departureCity: $departureCity, food: $food, singleFoodPreferred: $singleFoodPreferred, modeOfTransport: $modeOfTransport, customText: $customText, accommodationType: $accommodationType, hotelCategory: $hotelCategory, travelingWithKid: $travelingWithKid, addLocalEvents: $addLocalEvents, activityPreferences: $activityPreferences}';
  }
}
