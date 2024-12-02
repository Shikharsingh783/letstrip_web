import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import 'package:letstrip/Features/recommendation/screens/recommandation_result_screen.dart';
import 'package:letstrip/Features/recommendation/widgets/recommandation_container.dart';
import 'package:letstrip/common_widgets/budget_container.dart';
import 'package:letstrip/common_widgets/date_range_selector.dart';
import 'package:letstrip/common_widgets/dropdown.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/common_widgets/multi_select_dropdown.dart';
import 'package:letstrip/common_widgets/textfeild.dart';
import 'package:letstrip/generated/I10n.dart';
import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/models/location_model.dart';
import 'package:letstrip/repositories/auth_repo.dart';
import 'package:letstrip/repositories/itinerary_controller.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:letstrip/repositories/search_location_controller.dart';
import 'package:letstrip/utils/categories.dart';
import 'package:letstrip/utils/navigation.dart';
import 'package:letstrip/utils/utilities.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final AuthService authService = AuthService();
  TextEditingController cityController = TextEditingController();

  bool _isInternational = false;
  int _peopleNumber = 2;
  int days = 0;
  String budget = '50000';
  String month = "";
  String selectedTripTypes = '';
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

  @override
  void initState() {
    super.initState();
    Get.put(SearchLocationController());
    // Get.put(SearchLocationController());
    Get.put(ItineraryController());
    Get.put(ItineraryRepository());
  }

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
      _selectedPlaces.add(place);
      _suggestions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => desktopContainer(),
      mobile: (context) => mobileContainer(),
    );
  }

  Widget mobileContainer() {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                controller: cityController,
                onChanged: _onSearchChanged,
                hintText: 'From which city you would be travelling',
                prefixIcon: Image.asset(
                  'assets/Vector (4).png',
                  height: 15,
                ),
                focusBorderColor: const Color.fromRGBO(228, 228, 228, 1),
                selectedPlaces: _selectedPlaces,
                onPlaceSelected: (String) {},
              ),
              const SizedBox(height: 10),
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
                        title: Text(_suggestions[index].cityWithCountry),
                        onTap: () {
                          cityController.clear();
                          _onPlaceSelected(
                              _suggestions[index]); // Select the place
                        },
                      );
                    },
                  ),
                ),

              // const SizedBox(
              //   height: 10,
              // ),
              //*internation and domestic

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isInternational = !_isInternational;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: _isInternational
                                ? const Color.fromRGBO(223, 246, 234, 1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: _isInternational
                                ? Border.all(
                                    color:
                                        const Color.fromRGBO(57, 185, 111, 1),
                                    width: 1.2)
                                : Border.all(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    width: 0.3)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset('assets/Group 170.png', height: 13),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'International',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 15,
                                  color: _isInternational
                                      ? const Color.fromRGBO(57, 185, 111, 1)
                                      : const Color.fromRGBO(102, 102, 102, 1),
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isInternational = !_isInternational;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: !_isInternational
                                ? const Color.fromRGBO(223, 246, 234, 1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: !_isInternational
                                ? Border.all(
                                    color:
                                        const Color.fromRGBO(57, 185, 111, 1),
                                    width: 1.2)
                                : Border.all(
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                    width: 0.3)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset('assets/Vector (5).png', height: 13),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Domestic',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 15,
                                  color: !_isInternational
                                      ? const Color.fromRGBO(57, 185, 111, 1)
                                      : const Color.fromRGBO(102, 102, 102, 1),
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //*days and month
              Row(
                children: [
                  //days
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color(0xFFE4E4E4), width: 1)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          vector(Assets.assetsDays),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            days == 0
                                ? 'Days' // Default text
                                : '$days ${days == 1 ? "Day" : "Days"}',
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 15,
                                color: Color.fromRGBO(102, 102, 102, 1),
                                fontWeight: FontWeight.w400),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (days > 1) {
                                  days--;
                                }
                              });
                            },
                            child: Image.asset('assets/Group 1000001955.png',
                                height: 43),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                days++;
                              });
                            },
                            child: Image.asset('assets/Group 1000001954.png',
                                height: 43),
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //months
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: CustomDropdown(
                        height: 50,
                        items: months,
                        label: 'Month',
                        onItemSelected: (String? value) {
                          setState(() {
                            month = value ?? "";
                          });
                        },
                        prefixIcon: Transform.scale(
                          scale: 1.0,
                          child: vector(Assets.assetsMonths),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              //* person count
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: const Color(0xFFE4E4E4), width: 1)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Image.asset('assets/Group.png', height: 13),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Number of people',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 15,
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_peopleNumber > 1) {
                            _peopleNumber--;
                          }
                        });
                      },
                      child: Image.asset('assets/Group 1000001955.png',
                          height: 43),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(235, 248, 241, 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          _peopleNumber.toString(),
                          style: const TextStyle(
                              color: Color.fromRGBO(
                                57,
                                185,
                                111,
                                1,
                              ),
                              fontFamily: 'Raleway',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _peopleNumber++;
                        });
                      },
                      child: Image.asset('assets/Group 1000001954.png',
                          height: 43),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //*budget

              BudgetContainer(
                  initialValue: budget,
                  onValueUpdate: (value) {
                    budget = value;
                  }),

              const SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/Group 1000001942.png',
                height: 250,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: GestureDetector(
                  onTap: () {
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            RecommandationResultScreen(request: request)));
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(223, 246, 234, 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text('Next',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(177, 177, 177, 1))),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget desktopContainer() {
    final width = MediaQuery.of(context).size.width;
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
                          'assets/Recommendation.png',
                          height: 40,
                          width: 344,
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          controller: cityController,
                          onChanged: _onSearchChanged,
                          hintText: 'From which city you would be travelling',
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
                                    cityController.clear();
                                    _onPlaceSelected(_suggestions[
                                        index]); // Select the place
                                  },
                                );
                              },
                            ),
                          ),

                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isInternational = !_isInternational;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: _isInternational
                                          ? const Color.fromRGBO(
                                              223, 246, 234, 1)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: _isInternational
                                          ? Border.all(
                                              color: const Color.fromRGBO(
                                                  57, 185, 111, 1),
                                              width: 1.2)
                                          : Border.all(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              width: 0.3)),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Image.asset('assets/Group 170.png',
                                          height: 13),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'International',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontSize: 15,
                                            color: _isInternational
                                                ? const Color.fromRGBO(
                                                    57, 185, 111, 1)
                                                : const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isInternational = !_isInternational;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: !_isInternational
                                          ? const Color.fromRGBO(
                                              223, 246, 234, 1)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: !_isInternational
                                          ? Border.all(
                                              color: const Color.fromRGBO(
                                                  57, 185, 111, 1),
                                              width: 1.2)
                                          : Border.all(
                                              color: const Color.fromRGBO(
                                                  102, 102, 102, 1),
                                              width: 0.3)),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Image.asset('assets/Vector (5).png',
                                          height: 13),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Domestic',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontSize: 15,
                                            color: !_isInternational
                                                ? const Color.fromRGBO(
                                                    57, 185, 111, 1)
                                                : const Color.fromRGBO(
                                                    102, 102, 102, 1),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //* person count
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color.fromRGBO(102, 102, 102, 1),
                                  width: 0.3)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset('assets/Group.png', height: 13),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Number of people',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 15,
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_peopleNumber > 1) {
                                      _peopleNumber--;
                                    }
                                  });
                                },
                                child: Image.asset(
                                    'assets/Group 1000001955.png',
                                    height: 43),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(235, 248, 241, 1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    _peopleNumber.toString(),
                                    style: const TextStyle(
                                        color: Color.fromRGBO(
                                          57,
                                          185,
                                          111,
                                          1,
                                        ),
                                        fontFamily: 'Raleway',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _peopleNumber++;
                                  });
                                },
                                child: Image.asset(
                                    'assets/Group 1000001954.png',
                                    height: 43),
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //* day and months
                        Row(
                          children: [
                            //days
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFFE4E4E4),
                                        width: 1)),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    vector(Assets.assetsDays),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      days == 0
                                          ? 'Days' // Default text
                                          : '$days ${days == 1 ? "Day" : "Days"}',
                                      style: const TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (days > 1) {
                                            days--;
                                          }
                                        });
                                      },
                                      child: Image.asset(
                                          'assets/Group 1000001955.png',
                                          height: 43),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          days++;
                                        });
                                      },
                                      child: Image.asset(
                                          'assets/Group 1000001954.png',
                                          height: 43),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //months
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: CustomDropdown(
                                  height: 50,
                                  items: months,
                                  label: 'Month',
                                  onItemSelected: (String? value) {
                                    setState(() {
                                      month = value ?? "";
                                    });
                                  },
                                  prefixIcon: Transform.scale(
                                    scale: 1.0,
                                    child: vector(Assets.assetsMonths),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //budget
                        BudgetContainer(
                            initialValue: budget,
                            onValueUpdate: (value) {
                              budget = value;
                            }),

                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecommandationContainer()));
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
                  SizedBox(
                    width: width * 0.08,
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: 500,
                      width: 500,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/Group 1000001942.png',
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
