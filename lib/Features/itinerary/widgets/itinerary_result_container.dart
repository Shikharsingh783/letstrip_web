import 'package:flutter/material.dart';
import 'package:letstrip/Features/itinerary/widgets/chip_container.dart';
import 'package:letstrip/common_widgets/budget_container.dart';
import 'package:letstrip/common_widgets/check_box.dart';
import 'package:letstrip/common_widgets/chip_multi_select.dart';
import 'package:letstrip/common_widgets/custom_toggle.dart';
import 'package:letstrip/common_widgets/date_range_selector.dart';
import 'package:letstrip/common_widgets/star_rating.dart';
import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/repositories/itinerary_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ItineraryResultContainer extends StatefulWidget {
  final ItineraryRequest request;
  const ItineraryResultContainer({super.key, required this.request});

  @override
  State<ItineraryResultContainer> createState() =>
      _ItineraryResultContainerState();
}

class _ItineraryResultContainerState extends State<ItineraryResultContainer> {
  double _rating = 3;
  bool isSwitch1On = false;
  bool isSwitch2On = false;
  bool isSwitch3On = false;
  String budget = '';
  String dateRange = '';
  List<String> destinations = [];
  List<String> tripType = [];
  String endDate = '';
  String startDate = '';

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

  final accomodationPreference = [
    'Hotel',
    'Hostel',
    'Homestay',
  ];

  final foodPreferences = [
    'Best Local Cuisine',
    'Vegetarian',
    'Seafood',
    'Gluten Free',
    'Italian',
    'Indian',
    'Chinese',
    'American',
    'Mexican',
    'Japanese',
    'French',
    'Thai',
  ];

  final transportationPreferences = [
    'Flight',
    'Train',
    'Bus',
    'Car rental',
    'Bike rental',
    'Public Transport Only',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize the fields with data from the request
    budget = widget.request.budget.toString();
    destinations = widget.request.destinations;
    tripType = widget.request.tripType;
    endDate = widget.request.endDate!;
    startDate = widget.request.startDate!;
  }

  @override
  Widget build(BuildContext context) {
    final itineraryProvider = Provider.of<ItineraryProvider>(context);
    return ScreenTypeLayout.builder(
      desktop: (context) => DesktopContainer(),
    );
  }

  Widget DesktopContainer() {
    String Date = '$startDate → $endDate';

    return Column(
      children: [
        // Header Container
        Container(
          height: 140,
          width: double.infinity,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(57, 185, 111, 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 100, top: 25),
                child: Text(
                  'Unique attraction based on your interest',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'redHat',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90, top: 10),
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(53, 176, 105, 1),
                  ),
                ),
              )
            ],
          ),
        ),

        // Main Content
        Expanded(
          child: Row(
            children: [
              // Left Panel (Scrollable)
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(left: 40, right: 30, top: 30),
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
                        const CustomTextWithPadding(
                          text: 'Choose your trip here',
                          spacing: 20,
                          spacing2: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CustomCheckboxList(
                              items: items,
                              preCheckedItems: [
                                'Family vacation',
                                'Cultural Exploration',
                                'Honeymoon',
                              ],
                              onChanged: (value) {}),
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
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Origin city',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(102, 102, 102, 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Destination city',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(102, 102, 102, 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        const CustomTextWithPadding(
                          text: 'Activity Preferences',
                          spacing: 0,
                          spacing2: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: CustomCheckboxList(
                              items: activityPreference,
                              preCheckedItems: [],
                              onChanged: (value) {}),
                        ),
                        const CustomTextWithPadding(
                          text: 'Accomodation Preferences',
                          spacing: 30,
                          spacing2: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: ChipMultiSelect(
                            items: accomodationPreference,
                            onSelectionChanged: (value) {},
                          ),
                        ),
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
                        const CustomTextWithPadding(
                          text: 'Food Preferences',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: CustomCheckboxList(
                              items: foodPreferences,
                              preCheckedItems: [],
                              onChanged: (value) {}),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Want to have these food througout your trip?',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(102, 102, 102, 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: CustomToggleSwitch(
                            value: isSwitch1On,
                            onChanged: (bool value) {
                              setState(() {
                                isSwitch1On = value;
                              });
                            },
                          ),
                        ),
                        const CustomTextWithPadding(
                          text: 'Transportation Preferences',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: CustomCheckboxList(
                              items: transportationPreferences,
                              preCheckedItems: [],
                              onChanged: (value) {}),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Travelling with a kid?',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(102, 102, 102, 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: CustomToggleSwitch(
                            value: isSwitch2On,
                            onChanged: (bool value) {
                              setState(() {
                                isSwitch2On = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Add local events and festivals in your itinerary?',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(102, 102, 102, 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: CustomToggleSwitch(
                            value: isSwitch3On,
                            onChanged: (bool value) {
                              setState(() {
                                isSwitch3On = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Do you want to add specific things?',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Raleway',
                                color: Color.fromRGBO(102, 102, 102, 1)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(228, 228, 228, 1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(228, 228, 228, 1)),
                                )),
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
                        )
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
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.accessibility,
                          size: 50,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Accessibility Settings',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Additional content for the right panel goes here.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTextWithPadding extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final double spacing2;

  const CustomTextWithPadding({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.fontFamily = 'Raleway',
    this.color = const Color.fromRGBO(102, 102, 102, 1),
    this.padding = const EdgeInsets.only(left: 20),
    this.spacing = 30,
    this.spacing2 = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: spacing),
        Padding(
          padding: padding,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
              color: color,
            ),
          ),
        ),
        SizedBox(height: spacing2),
      ],
    );
  }
}
