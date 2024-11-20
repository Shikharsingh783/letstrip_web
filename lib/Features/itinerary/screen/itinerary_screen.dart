import 'package:flutter/material.dart';
import 'package:letstrip/Features/itinerary/widgets/custom_app_bar.dart';
import 'package:letstrip/Features/itinerary/widgets/itinerary_container.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(), //custom AppBar widget
      body: ItineraryContainer(), //ItineraryContainer widget
    );
  }
}
