import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import the GetX package
import 'package:letstrip/Features/itinerary/screen/itinerary_screen.dart';
import 'package:letstrip/Features/recommendation/screens/recommendation_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size.width > 600
          ? const Size(834, 1112) // iPad (7th gen) design size
          : const Size(375, 812), // Mobile design size
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: RecommendationScreen(),
        );
      },
    );
  }
}
