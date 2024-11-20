import 'dart:convert';

String recommendationRequestToJson(ItineraryRequest data) =>
    json.encode(data.toJson());

class ItineraryRequest {
  ItineraryRequest(
      {this.destinations = const [],
      this.tripType = const [],
      this.budget = 0,
      this.startDate = '',
      this.endDate = '',
      this.originCity = '',
      this.departureCity = '',
      this.food = const [],
      this.singleFoodPreferred = false,
      this.modeOfTransport = const [],
      this.customText = ''});

  List<String> destinations;
  List<String> tripType;
  num budget;
  String? startDate;
  String? endDate;
  String originCity;
  String departureCity;
  List<String> food;
  bool singleFoodPreferred;
  List<String> modeOfTransport;
  String customText;

  factory ItineraryRequest.fromJson(Map<String, dynamic> json) {
    return ItineraryRequest(
      destinations: json["destinations"] == null
          ? []
          : List<String>.from(json["destinations"]!.map((x) => x)),
      tripType: json["tripType"] == null
          ? []
          : List<String>.from(json["tripType"]!.map((x) => x)),
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
    );
  }

  Map<String, dynamic> toJson() => {
        "destinations": destinations.map((x) => x).toList(),
        "tripType": tripType.map((x) => x).toList(),
        "budget": budget,
        "startDate": startDate,
        "endDate": endDate,
        "originCity": originCity,
        "departureCity": departureCity,
        "food": food.map((x) => x).toList(),
        "singleFoodPreferred": singleFoodPreferred,
        "modeOfTransport": modeOfTransport.map((x) => x).toList(),
        "customText": customText,
      };

  @override
  String toString() {
    return 'ItineraryRequest{destinations: $destinations, tripType: $tripType, budget: $budget, startDate: $startDate, endDate: $endDate, originCity: $originCity, departureCity: $departureCity, food: $food, singleFoodPreferred: $singleFoodPreferred, modeOfTransport: $modeOfTransport, customText: $customText}';
  }
}
