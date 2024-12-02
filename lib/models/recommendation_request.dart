import 'dart:convert';

String recommendationRequestToJson(RecommendationRequest data) =>
    json.encode(data.toJson());

class RecommendationRequest {
  RecommendationRequest({
    this.continent = const [],
    this.numOfDays = 0,
    this.month = "",
    this.purpose = "",
    this.recommendOffBeat = false,
    this.typeOfTravel = "",
    this.originCity = "",
    this.flightClass = "",
    this.climate = const [],
    this.landscape = const [],
    this.modeOfTravel = const [],
    this.travelDuration = '',
    this.budget = 0,
    this.numOfCountries = 1,
    this.numOfPeople = 0,
    this.accommodationType = const [],
    this.hotelCategory = "",
    this.includeSpecificCountry = "",
  });

  int numOfDays;
  String month;
  String purpose;
  bool recommendOffBeat;
  String typeOfTravel;
  String originCity;
  String flightClass;
  List<String> climate;
  List<String> continent;
  List<String> modeOfTravel;
  String travelDuration;
  List<String> landscape;
  int budget;
  int numOfCountries;
  int numOfPeople;
  List<String> accommodationType;
  String hotelCategory;
  String includeSpecificCountry;

  Map<dynamic, dynamic> toJson() => {
        "continent": continent.map((x) => x).toList(),
        "numOfDays": numOfDays,
        "month": month,
        "purpose": purpose,
        "recommendOffBeat": recommendOffBeat,
        "typeOfTravel": typeOfTravel,
        "originCity": originCity,
        "flightClass": flightClass,
        "climate": climate.map((x) => x).toList(),
        "landscape": landscape.map((x) => x).toList(),
        "budget": budget,
        "travelDuration": travelDuration,
        "modeOfTravel": modeOfTravel.map((x) => x).toList(),
        "numOfCountries": numOfCountries,
        "numOfPeople": numOfPeople,
        "accommodationType": accommodationType.map((x) => x).toList(),
        "hotelCategory": hotelCategory,
        "includeSpecificCountry": includeSpecificCountry,
      };

  @override
  String toString() {
    return 'RecommendationRequest{numOfDays: $numOfDays, month: $month, purpose: $purpose, recommendOffBeat: $recommendOffBeat, typeOfTravel: $typeOfTravel, originCity: $originCity, flightClass: $flightClass, climate: $climate, continent: $continent, modeOfTravel: $modeOfTravel, travelDuration: $travelDuration, landscape: $landscape, budget: $budget}, numOfCountries: $numOfCountries, numOfPeople: $numOfPeople, accommodationType: $accommodationType, hotelCategory: $hotelCategory, includeSpecificCountry: $includeSpecificCountry}';
  }

  RecommendationRequest copyWith({
    int? numOfDays,
    String? month,
    String? purpose,
    bool? recommendOffBeat,
    String? typeOfTravel,
    String? originCity,
    String? flightClass,
    List<String>? climate,
    List<String>? continent,
    List<String>? modeOfTravel,
    String? travelDuration,
    List<String>? landscape,
    int? budget,
    int? numOfCountries,
    int? numOfPeople,
    List<String>? accommodationType,
    String? hotelCategory,
    String? includeSpecificCountry,
  }) =>
      RecommendationRequest(
        continent: continent ?? this.continent.toList(),
        numOfDays: numOfDays ?? this.numOfDays,
        month: month ?? this.month,
        purpose: purpose ?? this.purpose,
        recommendOffBeat: recommendOffBeat ?? this.recommendOffBeat,
        typeOfTravel: typeOfTravel ?? this.typeOfTravel,
        originCity: originCity ?? this.originCity,
        flightClass: flightClass ?? this.flightClass,
        climate: climate ?? this.climate.toList(),
        landscape: landscape ?? this.landscape.toList(),
        modeOfTravel: modeOfTravel ?? this.modeOfTravel.toList(),
        travelDuration: travelDuration ?? this.travelDuration,
        budget: budget ?? this.budget,
        numOfCountries: numOfCountries ?? this.numOfCountries,
        numOfPeople: numOfPeople ?? this.numOfPeople,
        accommodationType: accommodationType ?? this.accommodationType.toList(),
        hotelCategory: hotelCategory ?? this.hotelCategory,
        includeSpecificCountry:
            includeSpecificCountry ?? this.includeSpecificCountry,
      );
}
