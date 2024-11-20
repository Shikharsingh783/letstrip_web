import 'package:flutter/material.dart';
import 'package:letstrip/Features/itinerary/widgets/custom_app_bar.dart';
import 'package:letstrip/Features/itinerary/widgets/itinerary_result_container.dart';
import 'package:letstrip/models/dummy_response_model.dart';
import 'package:letstrip/models/itinerary_request.dart';

class ItineraryResultScreen extends StatefulWidget {
  final ItineraryRequest request;
  const ItineraryResultScreen(
      {super.key, required this.request, DummyResponseModel? itineraryList});

  @override
  State<ItineraryResultScreen> createState() => _ItineraryResultScreenState();
}

class _ItineraryResultScreenState extends State<ItineraryResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: ItineraryResultContainer(
        request: widget.request,
      ),
    );
  }
}
