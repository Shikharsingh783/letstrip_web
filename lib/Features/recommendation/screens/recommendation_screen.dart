import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:letstrip/Features/itinerary/widgets/responsive_appbar.dart';
import 'package:letstrip/Features/recommendation/widgets/main_container.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(ItineraryRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ResponsiveAppBar(),
      body: const MainContainer(),
    );
  }
}
