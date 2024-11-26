import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:letstrip/Features/itinerary/widgets/custom_app_bar.dart';
import 'package:letstrip/Features/itinerary/widgets/itinerary_result_container.dart';
import 'package:letstrip/Features/itinerary/widgets/responsive_appBar_2.dart';
import 'package:letstrip/Features/itinerary/widgets/responsive_appbar.dart';
import 'package:letstrip/models/dummy_response_model.dart';
import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/repositories/itinerary_controller.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:letstrip/repositories/search_location_controller.dart';

class ItineraryResultScreen extends StatefulWidget {
  final ItineraryRequest request;
  const ItineraryResultScreen({
    super.key,
    required this.request,
    DummyResponseModel? itineraryList,
  });

  @override
  State<ItineraryResultScreen> createState() => _ItineraryResultScreenState();
}

class _ItineraryResultScreenState extends State<ItineraryResultScreen> {
  @override
  void initState() {
    super.initState();
    // Register the ItineraryRepository and ItineraryController
    Get.put(ItineraryRepository()); // Register ItineraryRepository
    Get.put(ItineraryController()); // Register ItineraryController
    // Get.put(SearchLocationController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ResponsiveAppBar2(),
      body: ItineraryResultContainer(
        request: widget.request,
      ),
    );
  }
}
