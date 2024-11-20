class LocationModel {
  final String cityWithCountry;

  LocationModel({
    required this.cityWithCountry,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    print("Incoming JSON: $json");

    String cityWithCountry = "";

    // Assign place_name directly to cityWithCountry
    if (json["place_name"] != null) {
      cityWithCountry = json["place_name"];
    }

    print("Extracted cityWithCountry: $cityWithCountry");

    return LocationModel(
      cityWithCountry: cityWithCountry,
    );
  }

  // static List<LocationModel> filterAndSortSuggestions(
  //     List<LocationModel> suggestions, String query) {
  //   query = query.trim().toLowerCase();

  //   // Filter locations based on the query, case-insensitive
  //   List<LocationModel> filtered = suggestions.where((location) {
  //     return location.cityWithCountry.toLowerCase().contains(query);
  //   }).toList();

  //   print(
  //       "Filtered locations: ${filtered.map((e) => e.cityWithCountry).toList()}");

  //   // Sort filtered locations alphabetically by cityWithCountry
  //   filtered.sort((a, b) => a.cityWithCountry.compareTo(b.cityWithCountry));

  //   return filtered;
  // }

  @override
  String toString() => 'Location: $cityWithCountry';
}
