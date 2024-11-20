import 'package:letstrip/models/itninerary_result_model.dart';
import 'itinerary_request.dart';

class SavedItineraryModel {
  SavedItineraryModel(
      {required this.userPreferences,
      required this.response,
      required this.createdAt});

  final ItineraryRequest? userPreferences;
  final List<ItineraryResultModel> response;
  DateTime createdAt;

  factory SavedItineraryModel.fromJson(Map<String, dynamic> json) {
    return SavedItineraryModel(
      userPreferences: json['userPreferences'] != null
          ? ItineraryRequest.fromJson(json['userPreferences'])
          : null,
      response: List<ItineraryResultModel>.from(
          json['response'].map((x) => ItineraryResultModel.fromJson(x))),
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
