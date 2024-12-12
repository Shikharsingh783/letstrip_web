import 'package:flutter/material.dart';
import 'package:letstrip/Features/itinerary/widgets/responsive_appBar_2.dart';
import 'package:letstrip/Features/recommendation/widgets/recommandation_container.dart';
import 'package:letstrip/models/itinerary_request.dart';

class RecommandationResultScreen extends StatefulWidget {
  final ItineraryRequest request;
  const RecommandationResultScreen({super.key, required this.request});

  @override
  State<RecommandationResultScreen> createState() =>
      _RecommandationResultScreenState();
}

class _RecommandationResultScreenState
    extends State<RecommandationResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar2(),
      body: const RecommandationContainer(),
    );
  }
}
