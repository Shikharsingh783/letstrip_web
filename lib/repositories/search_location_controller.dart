import 'package:get/get.dart';
import 'package:letstrip/models/base_response.dart';
import 'package:letstrip/models/location_model.dart';
import 'package:letstrip/repositories/auth_repo.dart';

class SearchLocationController extends GetxController {
  var loadingState = false.obs;
  var places = <String>[].obs;

  final AuthService _repository = AuthService();

  Future<void> searchPlaces(String query) async {
    loadingState.value = true;
    try {
      // Convert the query to lowercase for case-insensitive search
      query = query.trim().toLowerCase();

      // Initialize a list to hold combined suggestions
      List<String> combinedPlaces = [];

      // Fetch additional data from the API (e.g., cities)
      BaseResponse<List<LocationModel>> apiResult =
          await _repository.searchPlaces(query);

      if (apiResult.data != null && apiResult.data!.isNotEmpty) {
        // Organize API results by "City, Country" format
        List<String> organizedPlaces = apiResult.data!
            .where((location) => location.cityWithCountry.isNotEmpty)
            .map((location) => location.cityWithCountry)
            .toList();

        // Add the sorted API results to the combined list
        combinedPlaces.addAll(organizedPlaces);
      }

      // Remove duplicates and ensure all results are unique

      places.value = combinedPlaces.toSet().toList();
      print(combinedPlaces);

      // Handle case where no results are found from either source
      if (combinedPlaces.isEmpty) {
        combinedPlaces.add("No results found");
      }

      // Update observable with the organized and combined results
      places.value = combinedPlaces;
    } catch (e) {
      print("Error in searchPlaces: $e");
      places.value = ["Error retrieving places"];
    } finally {
      loadingState.value = false; // Stop loading indicator
    }
  }
}
