import 'package:flutter/material.dart';

import 'package:letstrip/Features/itinerary/widgets/chip_container.dart';
import 'package:letstrip/Features/itinerary/widgets/itinerary_result_container.dart';
import 'package:letstrip/common_widgets/budget_container.dart';
import 'package:letstrip/common_widgets/check_box.dart';
import 'package:letstrip/common_widgets/chip_multi_select.dart';
import 'package:letstrip/common_widgets/continent_selector.dart';
import 'package:letstrip/common_widgets/custom_toggle.dart';
import 'package:letstrip/common_widgets/date_range_selector.dart';
import 'package:letstrip/common_widgets/star_rating.dart';
import 'package:letstrip/models/recommendation_request.dart';
import 'package:letstrip/utils/size_config.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RecommandationContainer extends StatefulWidget {
  const RecommandationContainer({super.key});

  @override
  State<RecommandationContainer> createState() =>
      _RecommandationContainerState();
}

double _rating = 3;
bool isSwitch1On = false;
bool isSwitch2On = false;
bool isSwitch3On = false;
String budget = '';
String dateRange = '';
List<String> destinations = [];
String tripType = '';
String endDate = '';
String startDate = '';
bool isInternational = false;
int _peopleNumber = 2;

final items = [
  'Family vacation',
  'Cultural Exploration',
  'Honeymoon',
  'Party and Night life',
  'Relaxed gateway'
];

final activityPreference = [
  'Sightseeing and CulturalExploration',
  'Adventure and Outdoor Activities',
  'Nature and wildlife',
  'Relaxation and wellness',
  'Food & Drink Experiences',
  'Nightlife & Entertainment',
  'Shopping & Local Market',
  'Religioud and Spiritual',
];

final flightClass = [
  'Economy',
  'Economy Premium',
  'Business',
  'Firt Class',
];

final accomodationPreference = [
  'Hotel',
  'Hostel',
  'Homestay',
];

final climate = [
  'Very Cold',
  'Cold',
  'Moderate',
  'Hot',
];
final landscape = [
  'Mountains',
  'Beach',
  'Desert',
];

final purpose = [
  'Honeymoon',
  'Family vacation',
  'Party and night life',
  'Cultural exploration',
  'Relaxed getaway',
];

// Sample data for the selected continents
List<String> selectedContinents = [
  'Asia',
  'Europe'
]; // Default selected continents

// Sample continent data for ContinentSelector widget
List<String> allContinents = [
  'Africa',
  'Asia',
  'Europe',
  'North America',
  'South America',
  'Antarctica',
  'Australia'
];

class _RecommandationContainerState extends State<RecommandationContainer> {
  // late RecommendationRequest filterRequest;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => recommandationDesktop(),
      mobile: (context) => reommendationMobile(),
    );
  }

  Widget reommendationMobile() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Widget recommandationDesktop() {
    String Date = '$startDate → $endDate';
    double Width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 40, right: 30, top: 30),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'FILTER',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Divider(
                            thickness: 0.7,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'BASIC',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(57, 185, 111, 1)),
                          ),
                          const CustomTextWithPadding(
                            text: 'Select Destination',
                            spacing: 20,
                            spacing2: 0,
                          ),
                          const ChipContainer(
                            items: [
                              'Delhi,india',
                              'Lucknow,india',
                              'shimla,india',
                              'Rajasthan'
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        'International',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontSize: 14,
                                            fontWeight: isInternational
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1)),
                                      ),
                                      const SizedBox(
                                          width:
                                              5), // Space between checkbox and text
                                      Checkbox(
                                        value: isInternational,
                                        activeColor: const Color.fromRGBO(
                                            57, 185, 111, 1),
                                        onChanged: (value) {
                                          setState(() {
                                            isInternational = !isInternational;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                //domestic box
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        'Domestic',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontSize: 14,
                                            fontWeight: !isInternational
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1)),
                                      ),
                                      const SizedBox(
                                          width:
                                              5), // Space between checkbox and text
                                      Checkbox(
                                        value: !isInternational,
                                        activeColor: const Color.fromRGBO(
                                            57, 185, 111, 1),
                                        onChanged: (value) {
                                          setState(() {
                                            isInternational = !isInternational;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CustomTextWithPadding(
                                text: 'Number of people',
                              ),
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
                            ],
                          ),
                          const CustomTextWithPadding(
                            text: 'Budget',
                            spacing: 20,
                            spacing2: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: BudgetContainer(
                                initialValue: budget,
                                onValueUpdate: (value) {
                                  budget = value;
                                }),
                          ),
                          const CustomTextWithPadding(
                            text: 'Date',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: DateRangeSelector(
                                initialValue: Date,
                                onDateRangeSelect: (range) {
                                  dateRange = range;
                                }),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Divider(
                            thickness: 0.7,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Advance',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(57, 185, 111, 1)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          const CustomTextWithPadding(
                            text: 'Purpose of trip',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: CustomCheckboxList(
                                items: purpose,
                                preCheckedItems: [],
                                onChanged: (value) {}),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          const CustomTextWithPadding(
                            text: 'Preferable climate',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: CustomCheckboxList(
                                items: climate,
                                preCheckedItems: [],
                                onChanged: (value) {}),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          const CustomTextWithPadding(
                            text: 'Preferable landscape',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: CustomCheckboxList(
                                items: landscape,
                                preCheckedItems: [],
                                onChanged: (value) {}),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          const CustomTextWithPadding(
                            text: 'Preferable flight class',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: CustomCheckboxList(
                                items: flightClass,
                                preCheckedItems: [],
                                onChanged: (value) {}),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //continent
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: ContinentSelector(
                              (selectedList) {
                                setState(() {
                                  // Update the selected continents when the user selects from the ContinentSelector
                                  selectedContinents =
                                      selectedList; // selectedContinents is a local variable
                                });
                              },
                              width: Width * 0.27,
                              height: Width * 0.2,
                              selectedContinents:
                                  selectedContinents, // This is the local state variable
                              showTitle: true,
                            ),
                          ),

                          //accomodation
                          const CustomTextWithPadding(
                            text: 'Accomodation Preference',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ChipMultiSelect(
                                hint: '',
                                items: accomodationPreference,
                                onSelectionChanged: (value) {}),
                          ),

                          //star rating
                          const CustomTextWithPadding(
                            text: 'Hotel Star Rating',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: StarRating(
                              rating: _rating,
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _rating = rating;
                                });
                              },
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, bottom: 20),
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(57, 185, 111, 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Text(
                                'Apply Changes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Raleway'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ** verticle divider
                const VerticalDivider(
                  width: 1,
                  thickness: 0.7,
                  color: Color.fromRGBO(228, 228, 228, 1),
                  indent: 50,
                  endIndent: 50,
                ),

                //** right container */
                Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        // Background Layer
                        Container(
                          color: Colors.white, // Background color
                        ),
                        // Scrollable Content
                        const SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 50.0,
                                top: 16), // Optional padding for spacing
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align content to the left
                              children: [
                                Text('Top Destinations',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Raleway')),
                                SizedBox(height: 10), // Spacer between elements
                                Text(
                                    'Based on your budget, travel time, and other preferences, the destinations below suit you the best.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromRGBO(102, 102, 102, 102),
                                        fontFamily: 'Raleway'))
                                // Add more content here...
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          //*bottom bar
          // Container(
          //   height: 300,
          //   decoration:
          //       const BoxDecoration(color: Color.fromRGBO(8, 48, 25, 1)),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 20.0),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             const SizedBox(
          //               height: 40,
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(right: 30.0),
          //               child: Image.asset(
          //                 'assets/Let’s Trip.png',
          //                 height: 50,
          //               ),
          //             ),
          //             const SizedBox(
          //               height: 20,
          //             ),
          //             Image.asset(
          //               'assets/Book your trip in minute, get full Control for much longer..png',
          //               height: 50,
          //             )
          //           ],
          //         ),
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.only(top: 50.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Company',
          //               style: TextStyle(
          //                   fontSize: 24,
          //                   fontWeight: FontWeight.w700,
          //                   fontFamily: 'redHat',
          //                   color: Colors.white),
          //             ),
          //             SizedBox(
          //               height: 50,
          //             ),
          //             Text(
          //               'About',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontFamily: 'Raleway',
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //             SizedBox(
          //               height: 20,
          //             ),
          //             Text(
          //               'Carrers',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontFamily: 'Raleway',
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ],
          //         ),
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.only(top: 50.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'Quick Links',
          //               style: TextStyle(
          //                   fontSize: 24,
          //                   fontWeight: FontWeight.w700,
          //                   fontFamily: 'redHat',
          //                   color: Colors.white),
          //             ),
          //             SizedBox(
          //               height: 50,
          //             ),
          //             Text(
          //               'Help/FAQ',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontFamily: 'Raleway',
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //             SizedBox(
          //               height: 20,
          //             ),
          //             Text(
          //               'Press',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontFamily: 'Raleway',
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //             SizedBox(
          //               height: 20,
          //             ),
          //             Text(
          //               'Affilates',
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontFamily: 'Raleway',
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 50.0, right: 20),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Image.asset(
          //               'assets/Outbound.png',
          //               height: 120,
          //             ),
          //             const SizedBox(
          //               height: 15,
          //             ),
          //             Image.asset(
          //               'assets/Group 1000002102.png',
          //               height: 45,
          //             )
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class ChipMultiSelect extends StatefulWidget {
  final String hint;
  final List<String> items;
  final Function(List<String>) onSelectionChanged;
  final List<String> preSelectedItems; // Added this parameter for pre-selection

  const ChipMultiSelect({
    required this.hint,
    required this.items,
    required this.onSelectionChanged,
    this.preSelectedItems = const [], // Default value if no pre-selected items
    Key? key,
  }) : super(key: key);

  @override
  _ChipMultiSelectState createState() => _ChipMultiSelectState();
}

class _ChipMultiSelectState extends State<ChipMultiSelect> {
  late List<String> selectedItems;

  @override
  void initState() {
    super.initState();
    // Initialize selectedItems with pre-selected items if provided
    selectedItems = List.from(widget.preSelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hint.isNotEmpty) ...[
          Text(
            widget.hint,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
            ),
          ),
        ],
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.items.map((item) {
            final isSelected = selectedItems.contains(item);
            return FilterChip(
              showCheckmark: false,
              label: Text(
                item,
                style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color.fromRGBO(102, 102, 102, 1),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Raleway'),
              ),
              backgroundColor: Colors.white, // White background by default
              selectedColor: const Color.fromRGBO(
                  57, 185, 111, 1), // Green background when selected
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18), // Border radius of 16
                side: isSelected
                    ? const BorderSide(color: Colors.transparent)
                    : const BorderSide(
                        color: Colors.grey, width: 1), // Optional: border color
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedItems.add(item);
                  } else {
                    selectedItems.remove(item);
                  }
                  widget.onSelectionChanged(selectedItems);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
