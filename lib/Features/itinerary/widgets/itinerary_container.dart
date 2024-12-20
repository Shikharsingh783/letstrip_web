import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:letstrip/Features/itinerary/screen/itinerary_result_screen.dart';

import 'package:letstrip/common_widgets/budget_container.dart';
import 'package:letstrip/common_widgets/build_button.dart';
import 'package:letstrip/common_widgets/date_range_selector.dart';

import 'package:letstrip/common_widgets/helper_widget.dart';

import 'package:letstrip/common_widgets/multi_option_dropdown.dart';

import 'package:letstrip/common_widgets/multi_select_dropdown.dart';
import 'package:letstrip/common_widgets/textfeild.dart';

import 'package:letstrip/generated/assets.dart';

import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/models/location_model.dart';

import 'package:letstrip/repositories/auth_repo.dart';

import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:letstrip/repositories/search_location_controller.dart';

import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';

import 'package:letstrip/utils/utilities.dart';

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
  String selectedTripTypes = '';
  var itineraryRequest = ItineraryRequest();

  final itineraryTrips = [
    'Honeymoon',
    'Family vacation',
    'Party and night life',
    'Cultural exploration',
    'Relaxed getaway',
    'Adventure',
  ];

  final itineraryTrip = [
    DropdownType('Honeymoon', Assets.assetsHoneymoon),
    DropdownType('Family vacation', Assets.assetsFamityVacation),
    DropdownType('Party and night life', Assets.assetsPartyLife),
    DropdownType('Cultural exploration', Assets.assetsCulture),
    DropdownType('Relaxed getaway', Assets.assetsRelex),
    DropdownType('Adventure', Assets.assetsRelex),
  ];
  List<LocationModel> _suggestions = [];
  List<LocationModel> _selectedPlaces = [];
  List<String> destinations = [];
  String tripType = '';

  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      var result = await authService.searchPlaces(query);
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

  final AuthService authService = AuthService();
  Widget _dialogContent = Container();

  @override
  void initState() {
    super.initState();
    Get.put(SearchLocationController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCustomWelcomeDialog();
    });
  }

  void _showCustomWelcomeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final double width = MediaQuery.of(context).size.width;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.transparent,
          child: width < 950 ? mobileDialog() : desktopDialog(),
        );
      },
    );
  }

  Widget mobileDialog() {
    return Container(
      height: 337,
      width: 285,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.none, // Ensure poppers are not clipped
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Stack(
                children: [
                  Image.asset(
                    'assets/Group 1000008021.png',
                    height: 131,
                    width: 280,
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        'assets/Group 1000008019.png',
                        height: 66,
                      )),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Image.asset(
                        'assets/Group (1).png',
                        height: 66,
                      )),
                  Positioned(
                      top: 30,
                      right: 10,
                      child: Image.asset(
                        'assets/Group 1000008020.png',
                        height: 66,
                      )),
                  Positioned(
                      top: 50,
                      left: 10,
                      child: Image.asset(
                        'assets/Group (2).png',
                        height: 66,
                      )),
                ],
              ),
              Text(
                "Congratulations",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    color: const Color.fromRGBO(57, 185, 111, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 21),
              ),
              const SizedBox(height: 12),
              Text(
                "You have 3 months subscription\n has begun!!",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    color: const Color.fromRGBO(102, 102, 102, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(57, 185, 111, 1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    "Lets's Go",
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/Group 1000008017.png')))
        ],
      ),
    );
  }

  Widget desktopDialog() {
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: w * 0.31,
      width: w * 0.5,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.none, // Ensure poppers are not clipped
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              //left
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.03),
                        child: Image.asset(
                          'assets/Group 1000008026.png',
                          height: w * 0.1,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: w * 0.02,
                      ),
                      Image.asset(
                        'assets/Group (3).png',
                        height: w * 0.03,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),

                  //center
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.02),
                    child: Image.asset(
                      'assets/Group 1000008024.png',
                      height: w * 0.13,
                      width: w * 0.15,
                      fit: BoxFit.fill,
                    ),
                  ),

                  //right
                  Row(
                    children: [
                      Image.asset(
                        'assets/Group (4).png',
                        height: w * 0.03,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: w * 0.02, top: 35),
                        child: Image.asset(
                          'assets/Group 1000008025.png',
                          height: w * 0.1,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "Congratulations",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    color: const Color.fromRGBO(57, 185, 111, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.02),
              ),
              SizedBox(height: w * 0.001),
              Text(
                "You have 3 months subscription has begun!!",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    color: const Color.fromRGBO(111, 108, 144, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: w * 0.016),
              ),
              const SizedBox(height: 15),
              Container(
                width: w * 0.5,
                height: w * 0.035,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(57, 185, 111, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Let's Go",
                    style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/Group 1000008017.png')))
        ],
      ),
    );
  }

  // final url = 'https://itinerary.letstrip.world/api/v1/production/itinerary';

  // final token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmJhNTNhYzJkZjdlY2ZiMGMyYjQzNCIsImVtYWlsIjoic2hpa2hhcnMzNjlAZ21haWwuY29tIiwiYWN0aXZlIjp0cnVlLCJjdXJyZW5jeSI6eyJjb3VudHJ5IjoiTmV3IFplYWxhbmQgRG9sbGFyIiwic3ltYm9sIjoiJCIsImNvZGUiOiJOWkQifSwicm9sZSI6InVzZXIiLCJkZWxldGVkIjpmYWxzZSwiaWF0IjoxNzMxNzQ3Mjk3LCJleHAiOjE3MzQzMzkyOTd9.FPMHcum4v0kROuOpJQkl2C5ac8K7XtSJWORw1C6WNaY';
  // final String baseUrl = Environment.itineraryBaseUrl;
  // static const int maxAttempts = 3;

  // Future<BaseResponse<DummyResponseModel>> getItinerary(
  //     Map<String, dynamic> data) async {
  //   var attempt = 1;

  //   while (attempt <= maxAttempts) {
  //     try {
  //       // Log the data being sent
  //       print("Sending data to API: $data");

  //       final response = await http.post(
  //         Uri.parse('$baseUrl/itinerary'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization':
  //               'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3MmJhNTNhYzJkZjdlY2ZiMGMyYjQzNCIsImVtYWlsIjoic2hpa2hhcnMzNjlAZ21haWwuY29tIiwiYWN0aXZlIjp0cnVlLCJjdXJyZW5jeSI6eyJjb3VudHJ5IjoiTmV3IFplYWxhbmQgRG9sbGFyIiwic3ltYm9sIjoiJCIsImNvZGUiOiJOWkQifSwicm9sZSI6InVzZXIiLCJkZWxldGVkIjpmYWxzZSwiaWF0IjoxNzMxNzQ3Mjk3LCJleHAiOjE3MzQzMzkyOTd9.FPMHcum4v0kROuOpJQkl2C5ac8K7XtSJWORw1C6WNaY',
  //         },
  //         body: json.encode(data),
  //       );

  //       // Log the raw response
  //       print("Raw Response: ${response.body}");

  //       if (response.statusCode >= 200 && response.statusCode < 300) {
  //         final responseData = json.decode(response.body);
  //         print("Decoded response data: $responseData");

  //         return BaseResponse.fromJson(
  //           responseData,
  //           (json) => DummyResponseModel.fromJson(json),
  //         );
  //       } else {
  //         print("Error: ${response.statusCode}");
  //         throw BaseApiException(
  //             'Failed to load itinerary', response.statusCode);
  //       }
  //     } catch (e) {
  //       print("Error occurred: $e");
  //       if (attempt == maxAttempts) {
  //         rethrow;
  //       }
  //       attempt++;
  //     }
  //   }
  //   throw BaseApiException("Max attempts reached", 0);
  // }

  @override
  Widget build(BuildContext context) {
    // Correctly assign height and width
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScreenTypeLayout.builder(
      desktop: (context) => DesktopContainer(),
      mobile: (context) =>
          phoneContainer(width), // Pass width to phoneContainer
      // tablet: (context) => tabletContainer(),
    );
  }

  Widget phoneContainer(double width) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: padAll(),
            child: Column(
              children: [
                const Divider(
                  color: Color.fromRGBO(57, 185, 111, 1),
                  thickness: 3,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  onChanged: _onSearchChanged,
                  hintText: 'Where are you planning to go',
                  prefixIcon: Image.asset(
                    'assets/Vector (4).png',
                    height: 15,
                  ),
                  focusBorderColor: const Color.fromRGBO(228, 228, 228, 1),
                  selectedPlaces: _selectedPlaces,
                  onPlaceSelected: (String) {},
                ),
                const SizedBox(height: 10),
                if (_suggestions.isNotEmpty)
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_suggestions[index].cityWithCountry),
                          onTap: () {
                            _onPlaceSelected(
                                _suggestions[index]); // Select the place
                          },
                        );
                      },
                    ),
                  ),
                MultiOptionDropdown(
                    hint: 'Choose your trip type',
                    leadingIcon: Assets.assetsTripType,
                    items: itineraryTrip,
                    onItemSelected: (items) {
                      tripType = items.join(", ");
                    }),
                boxH8(),
                BudgetContainer(onValueUpdate: (value) {
                  budget = value;
                }),
                boxH8(),
                DateRangeSelector(onDateRangeSelect: (range) {
                  dateRange = range;
                }),
                boxH8(),
                vector(Assets.assetsItineraryHome,
                    fit: BoxFit.fitWidth, height: width * 0.7),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white, // Set the background color to white
        child: Padding(
          padding: padSym(horizontal: 16, vertical: 32),
          child: buildButton("Next", onPressed: () {
            ItineraryRequest request = ItineraryRequest(
                destinations: ["Lucknow"],
                tripType: "Family vacation",
                budget: 404000,
                startDate: "Nov 29, 2024",
                endDate: "Nov 30, 2024",
                originCity: "",
                departureCity: "",
                food: [],
                singleFoodPreferred: false,
                modeOfTransport: [],
                customText: "",
                accommodationType: [],
                hotelCategory: 0,
                travelingWithKid: false,
                addLocalEvents: false,
                activityPreferences: []);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItineraryResultScreen(
                          request: request,
                        )));
          }),
        ),
      ),
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
                              selectedTripTypes = selected
                                  .join(', '); // Update selected trip types
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
                            ItineraryRequest request = ItineraryRequest(
                                destinations: ["Lucknow"],
                                tripType: "Family vacation",
                                budget: 404000,
                                startDate: "Nov 29, 2024",
                                endDate: "Nov 30, 2024",
                                originCity: "",
                                departureCity: "",
                                food: [],
                                singleFoodPreferred: false,
                                modeOfTransport: [],
                                customText: "",
                                accommodationType: [],
                                hotelCategory: 0,
                                travelingWithKid: false,
                                addLocalEvents: false,
                                activityPreferences: []);
                            // itineraryRepository.getItinerary(request.toJson());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItineraryResultScreen(
                                          request: request,
                                        )));
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

class BaseApiException implements Exception {
  final String message;
  final int code;

  BaseApiException(this.message, this.code);

  @override
  String toString() => 'Error $code: $message';
}
