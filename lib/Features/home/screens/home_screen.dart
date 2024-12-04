import 'package:flutter/material.dart';
import 'package:letstrip/Features/home/widgets/home_container.dart';
import 'package:letstrip/Features/itinerary/widgets/responsive_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: ResponsiveAppBar(),
      body: HomeContainer(),
    );
  }
}
