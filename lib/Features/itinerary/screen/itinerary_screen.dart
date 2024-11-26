import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure the full GetX package is imported
import 'package:letstrip/Features/itinerary/widgets/custom_app_bar.dart';
import 'package:letstrip/Features/itinerary/widgets/itinerary_container.dart';
import 'package:letstrip/Features/itinerary/widgets/responsive_appbar.dart';
import 'package:letstrip/repositories/auth_repo.dart';
import 'package:letstrip/repositories/search_location_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize your dependencies here
    // Get.put(SearchLocationController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ResponsiveAppBar(), // Custom AppBar widget
      body: const ItineraryContainer(), // ItineraryContainer widget
    );
  }
}
