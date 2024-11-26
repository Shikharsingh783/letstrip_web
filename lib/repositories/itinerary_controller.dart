import 'package:get/get.dart';
import 'package:letstrip/models/base_response.dart';
import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/models/itninerary_result_model.dart';
import 'package:letstrip/models/saved_itinerary.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:letstrip/repositories/unsplash_repo.dart';

class ItineraryController extends GetxController {
  final _repository = Get.find<ItineraryRepository>();
  final isImageLoading = false.obs;
  var isLoading = false.obs;
  var savedItineraries = <SavedItineraryModel>[].obs;
  var eventId = ''.obs;
  var itineraryRequest = ItineraryRequest().obs;

  final tripList = <ItineraryResultModel>[].obs;

  Future<void> getItinerary(ItineraryRequest recommendationRequest) async {
    itineraryRequest.value = recommendationRequest;
    var res = await _repository.getItinerary(recommendationRequest.toJson());
    eventId.value = res.data?.requestId ?? "";
  }

  void updateListWithImageUrl(ItineraryResultModel recommendation) async {
    ItineraryResultModel recommendation0 = recommendation;
    recommendation0.imageUrl = await UnsplashRepo()
        .searchItineraryImages(recommendation.activityName ?? "Travel");
    recommendation0.foodImages = await UnsplashRepo().searchFoodImages("Food");
    recommendation0.stayImage =
        await UnsplashRepo().searchHotelImages(recommendation.stay ?? "Hotel");
    tripList.add(recommendation0);
    getSortedList();
  }

  void getAllItineraries() async {
    isLoading.value = true;
    try {
      BaseResponse<List<SavedItineraryModel>> apiResult =
          await _repository.getAllItineraries();
      List<SavedItineraryModel> reversedList =
          apiResult.data?.reversed.toList() ?? [];
      savedItineraries.value = reversedList;
    } finally {
      isLoading.value = false;
    }
  }

  void getSortedList() {
    tripList.sort((a, b) {
      int dayA = int.tryParse(a.day ?? '') ?? 0;
      int dayB = int.tryParse(b.day ?? '') ?? 0;
      return dayA.compareTo(dayB);
    });
    tripList.toSet().toList();
  }
}
