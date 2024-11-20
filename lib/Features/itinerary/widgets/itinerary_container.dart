import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:letstrip/Features/itinerary/screen/itinerary_result_screen.dart';
import 'package:letstrip/common_widgets/budget_container.dart';
import 'package:letstrip/common_widgets/date_range_selector.dart';
import 'package:letstrip/common_widgets/multi_select_dropdown.dart';
import 'package:letstrip/common_widgets/textfeild.dart';
import 'package:letstrip/models/base_response.dart';
import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/models/location_model.dart';
import 'package:letstrip/repositories/auth_repo.dart';
import 'package:letstrip/repositories/itinerary_controller.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ItineraryContainer extends StatefulWidget {
  const ItineraryContainer({super.key});

  @override
  State<ItineraryContainer> createState() => _ItineraryContainerState();
}

class _ItineraryContainerState extends State<ItineraryContainer> {
  ItineraryRepository itineraryRepository = ItineraryRepository();
  String budget = '50000';
  String dateRange = '';
  List<String> selectedTripTypes = [];

  final itineraryTrips = [
    'Honeymoon',
    'Family vacation',
    'Party and night life',
    'Cultural exploration',
    'Relaxed getaway',
    'Adventure',
  ];
  List<LocationModel> _suggestions = [];
  List<LocationModel> _selectedPlaces = [];

  final AuthService authService = AuthService();

  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      BaseResponse<List<LocationModel>> result =
          await authService.searchPlaces(query);
      if (result.success) {
        setState(() {
          _suggestions = result.data!;
        });
      }
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  void _onPlaceSelected(LocationModel place) {
    setState(() {
      _selectedPlaces.add(place); // Add selected place to the list
      _suggestions = []; // Clear suggestions after selection
    });
  }

  @override
  Widget build(BuildContext context) {
    final itineraryProvider = Provider.of<ItineraryProvider>(context);
    return ScreenTypeLayout.builder(
      desktop: (context) => DesktopContainer(),
    );
  }

  Widget DesktopContainer() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top Row with TextField and Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/Group 262.png',
                          height: 40,
                          width: 344,
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          onChanged: _onSearchChanged,
                          hintText: 'Where are you planning to go',
                          prefixIcon: Image.asset(
                            'assets/Vector (4).png',
                            height: 15,
                          ),
                          focusBorderColor:
                              const Color.fromRGBO(228, 228, 228, 1),
                          selectedPlaces: _selectedPlaces,
                          onPlaceSelected: (String) {},
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(
                          height: 10,
                        ),
                        // Suggestions List
                        if (_suggestions.isNotEmpty)
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _suggestions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title:
                                      Text(_suggestions[index].cityWithCountry),
                                  onTap: () {
                                    _onPlaceSelected(_suggestions[
                                        index]); // Select the place
                                  },
                                );
                              },
                            ),
                          ),

                        MultiSelectDropdown(
                          options: itineraryTrips,
                          hintText: "Choose your trip type",
                          onSelectionChanged: (selected) {
                            setState(() {
                              selectedTripTypes =
                                  selected; // Update selected trip types
                              print(selectedTripTypes);
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BudgetContainer(onValueUpdate: (value) {
                          budget = value;
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        DateRangeSelector(onDateRangeSelect: (range) {
                          dateRange = range;
                        }),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // if (_selectedPlaces.isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content: Text('Please select a place')),
                            //   );
                            //   return;
                            // }
                            // if (dateRange.isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content:
                            //             Text('Please select a date range')),
                            //   );
                            //   return;
                            // }
                            // if (selectedTripTypes.isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content: Text('Please select a trip type')),
                            //   );
                            //   return;
                            // }
                            // ItineraryRequest request = ItineraryRequest(
                            //     destinations: _selectedPlaces
                            //         .map((place) => place.cityWithCountry)
                            //         .toList(),
                            //     tripType: selectedTripTypes,
                            //     budget: num.parse(budget),
                            //     startDate: dateRange.split('\u2192')[0],
                            //     endDate: dateRange.split('\u2192')[1]);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ItineraryResultScreen(
                            //               request: request,
                            //             )));

                            final ItineraryRequest request = ItineraryRequest(
                              originCity: "New York",
                              destinations: ["Los Angeles", "San Francisco"],
                              startDate: dateRange.split('\u2192')[0],
                              endDate: dateRange.split('\u2192')[1],
                              tripType: selectedTripTypes,
                              budget: int.parse(budget),
                              food: ["Italian", "Mexican"],
                              modeOfTransport: ["Car", "Plane"],
                            );

                            final response =
                                await itineraryRepository.getItinerary(request);

                            if (response.success) {
                              final itineraryList = response.data;
                              print('itineraryList : $itineraryList');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ItineraryResultScreen(
                                            itineraryList: itineraryList,
                                            request: request,
                                          )));
                            } else {
                              log(response.message!);
                            }
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromRGBO(235, 248, 241, 1)),
                            child: const Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(177, 177, 177, 1)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: 400,
                      width: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/Group 1000001996.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //**middle container */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Container(
                height: 955,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(57, 185, 111, 1),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/Text.png',
                      height: 65,
                      width: 800,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'assets/Text (1).png',
                      height: 65,
                      width: 800,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'assets/Group 1000002102.png',
                      height: 65,
                      width: 800,
                    ),
                    Image.asset(
                      'assets/Mask group.png',
                      height: 650,
                      width: 800,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            //** bottom bar */
            Container(
              height: 300,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(8, 48, 25, 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Image.asset(
                            'assets/Let’s Trip.png',
                            height: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/Book your trip in minute, get full Control for much longer..png',
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'redHat',
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'About',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Carrers',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Links',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'redHat',
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Help/FAQ',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Press',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Affilates',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/Outbound.png',
                          height: 120,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Image.asset(
                          'assets/Group 1000002102.png',
                          height: 45,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
