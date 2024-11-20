import 'package:flutter/foundation.dart';
import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/models/itninerary_result_model.dart';
import 'package:letstrip/models/saved_itinerary.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:letstrip/repositories/unsplash_repo.dart';

class ItineraryProvider extends ChangeNotifier {
  final ItineraryRepository _repository;

  ItineraryProvider(this._repository);

  bool _isImageLoading = false;
  bool get isImageLoading => _isImageLoading;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SavedItineraryModel> _savedItineraries = [];
  List<SavedItineraryModel> get savedItineraries => _savedItineraries;

  String _eventId = '';
  String get eventId => _eventId;

  ItineraryRequest? _itineraryRequest;
  ItineraryRequest? get itineraryRequest => _itineraryRequest;

  List<ItineraryResultModel> _tripList = [];
  List<ItineraryResultModel> get tripList => _tripList;

  Future<void> getItinerary(ItineraryRequest recommendationRequest) async {
    _itineraryRequest = recommendationRequest;
    notifyListeners();

    final res = await _repository.getItinerary(recommendationRequest);
    _eventId = res.data?.requestId ?? "";
    notifyListeners();
  }

  Future<void> updateListWithImageUrl(ItineraryResultModel recommendation) async {
    _isImageLoading = true;
    notifyListeners();

    final updatedRecommendation = recommendation.copyWith(
      imageUrl: await UnsplashRepo().searchItineraryImages(recommendation.activityName ?? "Travel"),
      foodImages: await UnsplashRepo().searchFoodImages("Food"),
      stayImage: await UnsplashRepo().searchHotelImages(recommendation.stay ?? "Hotel"),
    );

    _tripList.add(updatedRecommendation);
    getSortedList();

    _isImageLoading = false;
    notifyListeners();
  }

  Future<void> getAllItineraries() async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiResult = await _repository.getAllItineraries();
      _savedItineraries = apiResult.data?.reversed.toList() ?? [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void getSortedList() {
    _tripList.sort((a, b) {
      int dayA = int.tryParse(a.day ?? '') ?? 0;
      int dayB = int.tryParse(b.day ?? '') ?? 0;
      return dayA.compareTo(dayB);
    });

    _tripList = _tripList.toSet().toList();
    notifyListeners();
  }
}
