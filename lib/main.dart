import 'package:flutter/material.dart';
import 'package:letstrip/Features/itinerary/screen/itinerary_result_screen.dart';
import 'package:letstrip/Features/itinerary/screen/itinerary_screen.dart';
import 'package:letstrip/Features/login/screen/login_screen.dart';
import 'package:letstrip/repositories/itinerary_controller.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ItineraryProvider(ItineraryRepository()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ItineraryScreen(),
    );
  }
}
