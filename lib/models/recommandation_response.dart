import 'package:unsplash_client/unsplash_client.dart';

class RecommendationResponse {
  RecommendationResponse({
    this.visaFees = "",
    this.imageUrl = const [],
    this.costOfInternalTransport = "",
    this.miscExpenses = "",
    this.costOfHotel = "",
    this.destinationName = "",
    this.reasonToVisit = "",
    this.costOfFood = "",
    this.countryName = "",
    this.costOfFlight = "",
    this.costofTravel = "",
    this.timeToReach = "",
    this.totalCostOfJourney = "",
    this.modeofTravelCountry1 = "",
    this.modeofTravelCountry2 = "",
    this.modeofTravelCountry3 = "",
    this.modeofTravelCountry0 = "",
    this.costofTravelCountry1 = "",
    this.costofTravelCountry2 = "",
    this.costofTravelCountry3 = "",
    this.costofTravelCountry0 = "",
    this.costofHotelCountry1 = "",
    this.costofHotelCountry2 = "",
    this.costofHotelCountry3 = "",
  });

  String visaFees;
  List<Photo> imageUrl;
  String costOfInternalTransport;
  String miscExpenses;
  String costOfHotel;
  String destinationName;
  String reasonToVisit;
  String costOfFood;
  String countryName;
  String costOfFlight;
  String costofTravel;
  String totalCostOfJourney;
  String timeToReach;
  String modeofTravelCountry1;
  String modeofTravelCountry2;
  String modeofTravelCountry3;
  String modeofTravelCountry0;
  String costofTravelCountry1;
  String costofTravelCountry2;
  String costofTravelCountry3;
  String costofTravelCountry0;
  String costofHotelCountry1;
  String costofHotelCountry2;
  String costofHotelCountry3;

  factory RecommendationResponse.fromJson(Map<dynamic, dynamic> json) =>
      RecommendationResponse(
        visaFees: json["visaFees"].toString(),
        costOfInternalTransport: json["costOfInternalTransport"].toString(),
        miscExpenses: json["miscExpenses"].toString(),
        costOfHotel: json["costOfHotel"].toString(),
        destinationName: json["destinationName"] ?? "",
        reasonToVisit: json["reasonToVisit"] ?? "",
        costOfFood: json["costOfFood"].toString(),
        countryName: json["countryName"].toString(),
        costOfFlight: json["costOfFlight"].toString(),
        costofTravel: json["costofTravel"].toString(),
        timeToReach: json["timeToReach"].toString(),
        totalCostOfJourney: json["totalCostOfJourney"].toString(),
        modeofTravelCountry1: json["modeofTravelCountry1"].toString(),
        modeofTravelCountry2: json["modeofTravelCountry2"].toString(),
        modeofTravelCountry3: json["modeofTravelCountry3"].toString(),
        modeofTravelCountry0: json["modeofTravelCountry0"].toString(),
        costofTravelCountry1: json["costofTravelCountry1"].toString(),
        costofTravelCountry2: json["costofTravelCountry2"].toString(),
        costofTravelCountry3: json["costofTravelCountry3"].toString(),
        costofTravelCountry0: json["costofTravelCountry0"].toString(),
        costofHotelCountry1: json["costofHotelCountry1"].toString(),
        costofHotelCountry2: json["costofHotelCountry2"].toString(),
        costofHotelCountry3: json["costofHotelCountry3"].toString(),
      );
}
