import 'package:letstrip/models/recommandation_response.dart';
import 'package:letstrip/models/recommendation_request.dart';

extension RecommendationRequetExtensions on RecommendationRequest {
  bool get isDomestic {
    return typeOfTravel == 'Domestic';
  }
}

extension RecommendationResponseExtensions on RecommendationResponse {
  List<String> getDestinations(RecommendationRequest request) {
    String name = request.isDomestic ? destinationName : countryName;
    if (name.contains("[") && name.contains("]")) {
      name = name.substring(1, name.length - 1);
    }
    List<String> destinations = name.split(',').map((e) => e.trim()).toList();
    return destinations;
  }
}
