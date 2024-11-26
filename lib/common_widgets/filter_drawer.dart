import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:letstrip/common_widgets/budget_container.dart';
import 'package:letstrip/common_widgets/build_button.dart';
import 'package:letstrip/common_widgets/custom-switch.dart';

import 'package:letstrip/common_widgets/date_range_selector.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/common_widgets/multi_search_dropdown.dart';
import 'package:letstrip/common_widgets/searchable_drop_down.dart';
import 'package:letstrip/common_widgets/star_rating.dart';

import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/repositories/preference_controller.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/categories.dart';
import 'package:letstrip/utils/navigation.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';

class FilterDrawer extends StatefulWidget {
  final accommodationController = Get.put(AccommodationPreferenceController());
  final foodPreferenceController = Get.put(FoodPreferenceController());
  final travelPreferenceController = Get.put(TravelPreferenceController());
  final activityPreferenceController = Get.put(ActivityPreferenceController());

  final ItineraryRequest request;
  final Function(ItineraryRequest) performFilter;

  FilterDrawer(this.request, {required this.performFilter, super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  final textController = TextEditingController();
  late ItineraryRequest filterRequest;
  final KidController kidController = Get.put(KidController());
  final SwitchController controller = Get.put(SwitchController());
  final SingleFoodPrefController _foodPrefController =
      Get.put(SingleFoodPrefController());
  final RatingController starController = Get.put(RatingController());

  late String budget;
  String dateRange = "";
  List<String> destinations = [];
  double _rating = 3;
  late String originCity;
  late String departureCity;
  String tripType = '';
  List<String> foods = [];
  List<String> travel = [];
  bool singleFoodPref = false;
  bool kid = false;
  bool localEvents = false;
  List<String> activityPref = [];

  @override
  void initState() {
    super.initState();
    filterRequest = widget.request;
    budget = widget.request.budget.toString();
    dateRange = "${widget.request.startDate}\u2192${widget.request.endDate}";
    destinations = widget.request.destinations;
    foods = widget.request.food;
    tripType = widget.request.tripType;
    travel = widget.request.modeOfTransport;
    singleFoodPref = widget.request.singleFoodPreferred;
    textController.text = widget.request.customText;
    originCity = widget.request.originCity;
    departureCity = widget.request.departureCity;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: padAll(value: 16),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text("Personalize\nyour trip",
                            style: AppTextTheme.headingW900RHStyle)),
                    GestureDetector(
                        onTap: () {
                          backToPrevious();
                        },
                        child: const Icon(Icons.clear)),
                  ],
                ),
                boxH16(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(8)),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline)),
                  child: ExpansionTileCard(
                    baseColor: Colors.white,
                    elevation: 0,
                    initiallyExpanded: true,
                    expandedColor: Colors.white,
                    title: const Text(
                      "Basic",
                      style: TextStyle(
                          color: Color.fromRGBO(57, 185, 111, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Raleway'),
                    ),
                    children: [
                      SizedBox(
                        width: screenWidth(),
                        child: Padding(
                          padding: padAll(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Select Destinations*",
                                style: TextStyle(
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                              boxH8(),
                              Wrap(
                                runAlignment: WrapAlignment.start,
                                runSpacing: 8,
                                children: [
                                  ...destinations.map((e) => Container(
                                        padding:
                                            padSym(horizontal: 12, vertical: 8),
                                        margin: padOnly(right: 12),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                ScreenUtil().radius(24)),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(e,
                                                style: AppTextTheme.labelStyle
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .background)),
                                            boxW8(),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (widget
                                                      .request.destinations
                                                      .contains(e)) return;
                                                  destinations.remove(e);
                                                });
                                              },
                                              child: Icon(Icons.clear,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            )
                                          ],
                                        ),
                                      )),
                                  GestureDetector(
                                      onTap: _showBottomSheet,
                                      child: Transform.translate(
                                          offset: const Offset(0, -12),
                                          child: vector(Assets.assetsAddIcon,
                                              width: 56.w, height: 56.w)))
                                ],
                              ),
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              ExpansionTileCard(
                                elevation: 0,
                                baseColor: Colors.white,
                                expandedColor: Colors.white,
                                title: const Text(
                                  "Choose your trip type",
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                children: [
                                  SizedBox(
                                    width: screenWidth(),
                                    child: Padding(
                                      padding: padAll(),
                                      child: Wrap(
                                        runSpacing: 8,
                                        spacing: 8,
                                        children: [
                                          ...itineraryTrips.map((e) =>
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    // Check if the item is already in the tripType string
                                                    if (tripType
                                                        .contains(e.value)) {
                                                      // If the value is already in tripType, remove it
                                                      tripType = tripType
                                                          .replaceAll(
                                                              '${e.value} | ',
                                                              '')
                                                          .replaceAll(
                                                              ' | ${e.value}',
                                                              '')
                                                          .replaceAll(
                                                              '${e.value}', '');
                                                    } else {
                                                      // If it's not in tripType, add it
                                                      tripType = tripType
                                                              .isEmpty
                                                          ? e.value
                                                          : '$tripType | ${e.value}';
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                    padding: padSym(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color: tripType.contains(e.value)
                                                            ? const Color.fromRGBO(
                                                                57, 185, 111, 1)
                                                            : Colors.white,
                                                        borderRadius: BorderRadius.circular(
                                                            ScreenUtil()
                                                                .radius(24)),
                                                        border: Border.all(
                                                            color: tripType.contains(e.value)
                                                                ? Colors
                                                                    .transparent
                                                                : Theme.of(context)
                                                                    .colorScheme
                                                                    .outline)),
                                                    child: Text(e.value, style: AppTextTheme.labelStyle.copyWith(color: tripType.contains(e.value) ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.onSurface))),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              BudgetContainer(
                                  showBorder: false,
                                  initialValue: budget,
                                  onValueUpdate: (value) {
                                    budget = value;
                                  }),
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              DateRangeSelector(
                                  initialValue: dateRange,
                                  isSmallText: true,
                                  onDateRangeSelect: (range) {
                                    dateRange = range;
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                boxH16(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(8)),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline)),
                  child: ExpansionTileCard(
                    baseColor: Colors.white,
                    elevation: 0,
                    expandedColor: Colors.white,
                    title: Text("Advance",
                        style: AppTextTheme.titleBoldStyle
                            .copyWith(color: Color.fromRGBO(57, 185, 111, 1))),
                    children: [
                      SizedBox(
                        width: screenWidth(),
                        child: Padding(
                          padding: padAll(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start your trip from a specific city?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                              boxH8(),
                              originCity == ""
                                  ? GestureDetector(
                                      onTap: _originCityBottomSheet,
                                      child: Transform.translate(
                                          offset: const Offset(0, -12),
                                          child: vector(Assets.assetsAddIcon,
                                              width: 56.w, height: 56.w)))
                                  : Container(
                                      padding:
                                          padSym(horizontal: 12, vertical: 8),
                                      margin: padOnly(right: 12),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().radius(24)),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text(originCity,
                                                style: AppTextTheme.labelStyle
                                                    .copyWith(
                                                        color: Colors.white)),
                                          ),
                                          boxW8(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                //departureCity = "";
                                              });
                                            },
                                            child: Icon(Icons.clear,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              Text("End your trip in a specific city?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                              boxH8(),
                              departureCity == ""
                                  ? GestureDetector(
                                      onTap: _departureCityBottomSheet,
                                      child: Transform.translate(
                                          offset: const Offset(0, -12),
                                          child: vector(Assets.assetsAddIcon,
                                              width: 56.w, height: 56.w)))
                                  : Container(
                                      padding:
                                          padSym(horizontal: 12, vertical: 8),
                                      margin: padOnly(right: 12),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().radius(24)),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text(departureCity,
                                                style: AppTextTheme.labelStyle
                                                    .copyWith(
                                                        color: Colors.white)),
                                          ),
                                          boxW8(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                //departureCity = "";
                                              });
                                            },
                                            child: Icon(Icons.clear,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                          )
                                        ],
                                      ),
                                    ),

                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              ExpansionTileCard(
                                baseColor: Colors.white,
                                elevation: 0,
                                expandedColor: Colors.white,
                                title: const Text(
                                  "Activity Preferences",
                                  style: TextStyle(
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                children: [
                                  SizedBox(
                                    width: screenWidth(),
                                    child: Padding(
                                      padding: padAll(),
                                      child: Wrap(
                                        runSpacing: 8,
                                        spacing: 8,
                                        children: [
                                          ...itineraryActivity.map(
                                            (e) => GestureDetector(
                                              onTap: () {
                                                final controller = Get.find<
                                                    ActivityPreferenceController>();
                                                controller
                                                    .toggleActivity(e.value);
                                              },
                                              child: Obx(() {
                                                final controller = Get.find<
                                                    ActivityPreferenceController>();
                                                final isSelected = controller
                                                    .selectedActivities
                                                    .contains(e.value);

                                                return Container(
                                                  padding: padSym(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Color.fromRGBO(
                                                            57, 185, 111, 1)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      ScreenUtil().radius(24),
                                                    ),
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .outline,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    e.value,
                                                    style: TextStyle(
                                                      color: isSelected
                                                          ? Colors.white
                                                          : const Color
                                                              .fromRGBO(
                                                              102, 102, 102, 1),
                                                      fontFamily: 'Raleway',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //accomocadation
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              ExpansionTileCard(
                                baseColor: Colors.white,
                                elevation: 0,
                                expandedColor: Colors.white,
                                title: const Text(
                                  "Accommodation Preferences",
                                  style: TextStyle(
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                children: [
                                  SizedBox(
                                    width: screenWidth(),
                                    child: Padding(
                                      padding: padAll(),
                                      child: Wrap(
                                        runSpacing: 8,
                                        spacing: 8,
                                        children: [
                                          ...accommodations.map((e) =>
                                              GestureDetector(
                                                onTap: () {
                                                  final controller = Get.find<
                                                      AccommodationPreferenceController>();
                                                  controller.toggleItem(e);
                                                },
                                                child: Obx(() {
                                                  final controller = Get.find<
                                                      AccommodationPreferenceController>();
                                                  final isSelected = controller
                                                      .stay
                                                      .contains(e);
                                                  return Container(
                                                    padding: padSym(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: isSelected
                                                          ? Color.fromRGBO(
                                                              57, 185, 111, 1)
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              ScreenUtil()
                                                                  .radius(24)),
                                                      border: Border.all(
                                                        color: isSelected
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .primary
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .outline,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      e,
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : const Color
                                                                .fromRGBO(102,
                                                                102, 102, 1),
                                                        fontFamily: 'Raleway',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'Hotel Star Rating',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Raleway'),
                                    ),
                                  ),
                                ],
                              ),
                              boxH8(),
                              //hotel start rating
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Obx(() {
                                  return StarRating(
                                    rating: starController.rating
                                        .value, // Bind the rating with controller
                                    onRatingUpdate: (rating) {
                                      starController.updateRating(
                                          rating); // Update the rating in controller
                                    },
                                  );
                                }),
                              ),

                              //**food preference */
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              ExpansionTileCard(
                                baseColor: Colors.white,
                                elevation: 0,
                                expandedColor: Colors.white,
                                title: const Text(
                                  "Food Preference",
                                  style: TextStyle(
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                children: [
                                  SizedBox(
                                    width: screenWidth(),
                                    child: Padding(
                                      padding: padAll(),
                                      child: Wrap(
                                        runSpacing: 8,
                                        spacing: 8,
                                        children: [
                                          ...itineraryFood.map(
                                            (e) => GestureDetector(
                                              onTap: () {
                                                final controller = Get.find<
                                                    FoodPreferenceController>();
                                                controller.toggleFood(e.value);
                                              },
                                              child: Obx(() {
                                                final controller = Get.find<
                                                    FoodPreferenceController>();
                                                final isSelected = controller
                                                    .foods
                                                    .contains(e.value);
                                                return Container(
                                                  padding: padSym(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Color.fromARGB(
                                                            57, 185, 111, 1)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            ScreenUtil()
                                                                .radius(24)),
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .outline,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    e.value,
                                                    style: TextStyle(
                                                      color: isSelected
                                                          ? Colors.white
                                                          : const Color
                                                              .fromRGBO(
                                                              102, 102, 102, 1),
                                                      fontFamily: 'Raleway',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              const Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child: Text(
                                  'Want to have these food throughout your trip?',
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Raleway'),
                                ),
                              ),
                              boxH8(),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Obx(() {
                                  return CustomSwitch(
                                    initialValue: _foodPrefController
                                        .singleFoodPref
                                        .value, // Use .value to access the bool
                                    onToggle: (value) {
                                      _foodPrefController.toggleSingleFoodPref(
                                          value); // Update the state
                                    },
                                  );
                                }),
                              ),
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              ExpansionTileCard(
                                elevation: 0,
                                expandedColor: Colors.white,
                                baseColor: Colors.white,
                                title: const Text(
                                  "Transportation Preferences",
                                  style: TextStyle(
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                children: [
                                  SizedBox(
                                    width: screenWidth(),
                                    child: Padding(
                                      padding: padAll(),
                                      child: Wrap(
                                        runSpacing: 8,
                                        spacing: 8,
                                        children: [
                                          ...itineraryTravel.map(
                                            (e) => GestureDetector(
                                              onTap: () {
                                                final controller = Get.find<
                                                    TravelPreferenceController>();
                                                controller
                                                    .toggleTravel(e.value);
                                              },
                                              child: Obx(() {
                                                final controller = Get.find<
                                                    TravelPreferenceController>();
                                                final isSelected = controller
                                                    .travels
                                                    .contains(e.value);
                                                return Container(
                                                  padding: padSym(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Color.fromRGBO(
                                                            57, 185, 111, 1)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      ScreenUtil().radius(24),
                                                    ),
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .primary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .outline,
                                                    ),
                                                  ),
                                                  child: Text(e.value,
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : const Color
                                                                .fromRGBO(102,
                                                                102, 102, 1),
                                                        fontFamily: 'Raleway',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              boxH4(),
                              const Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child: Text(
                                  'Travelling with a kid?',
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              boxH8(),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Obx(() {
                                  // Using Obx to reactively listen to changes in kid
                                  return CustomSwitch(
                                    initialValue: kidController.kid.value,
                                    onToggle: (value) {
                                      kidController
                                          .toggleKid(value); // Toggle the state
                                    },
                                  );
                                }),
                              ),
                              boxH8(),
                              Divider(
                                  color: Theme.of(context).colorScheme.outline),
                              boxH4(),
                              const Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child: Text(
                                  'Add local events and festivals in yout itinerary?',
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 102, 102, 1),
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              boxH8(),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Obx(() {
                                  return CustomSwitch(
                                    initialValue: controller.localEvents
                                        .value, // Use .value to get the bool
                                    onToggle: (value) {
                                      controller.toggleLocalEvents(
                                          value); // Toggle the value
                                    },
                                  );
                                }),
                              ),
                              boxH8(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: padSym(horizontal: 16, vertical: 48),
          child: buildButton("Explore \u2192", onPressed: () {
            final controller = Get.find<AccommodationPreferenceController>();
            final controller2 = Get.find<FoodPreferenceController>();
            final controller3 = Get.find<TravelPreferenceController>();
            final controller4 = Get.find<ActivityPreferenceController>();
            final controller5 = Get.find<KidController>();
            final controller6 = Get.find<SwitchController>();
            final controller7 = Get.find<SingleFoodPrefController>();
            final controller8 = Get.find<RatingController>();
            filterRequest = ItineraryRequest(
                destinations: destinations,
                tripType: tripType,
                budget: num.parse(budget),
                startDate: dateRange.split('\u2192')[0],
                endDate: dateRange.split('\u2192')[1],
                originCity: originCity,
                departureCity: departureCity,
                food: controller2.foods,
                singleFoodPreferred: controller7.singleFoodPref.value,
                modeOfTransport: controller3.travels,
                customText: textController.text,
                travelingWithKid: controller5.kid.value,
                addLocalEvents: controller6.localEvents.value,
                activityPreferences: controller4.selectedActivities,
                accommodationType: controller.stay,
                hotelCategory: controller8.rating.toInt());

            widget.performFilter(filterRequest);
            backToPrevious();
          }),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: padAll(),
              child: Column(
                children: [
                  boxH8(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Search Destinations",
                          style: AppTextTheme.subtitleBoldStyle),
                      GestureDetector(
                          onTap: () {
                            backToPrevious();
                          },
                          child: const Icon(Icons.clear)),
                    ],
                  ),
                  boxH16(),
                  MultiSearchableDropdown(
                    initialItems: widget.request.destinations,
                    leadingIcon: Assets.assetsCumpass,
                    (location) {
                      setState(() {
                        destinations = location;
                      });
                    },
                    onValueUpdate: (location) {},
                  ),
                  boxH16(),
                  buildButton("Done", onPressed: () {
                    backToPrevious();
                  }),
                  boxH32()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _originCityBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: padAll(),
              child: Column(
                children: [
                  boxH8(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Search Location",
                          style: AppTextTheme.subtitleBoldStyle),
                      GestureDetector(
                          onTap: () {
                            backToPrevious();
                          },
                          child: const Icon(Icons.clear)),
                    ],
                  ),
                  boxH16(),
                  SearchableDropdown(
                      hint: "Search Location",
                      initialValue: originCity != "" ? originCity : null,
                      (location) {
                    setState(() {
                      originCity = location;
                    });
                  }),
                  boxH16(),
                  buildButton("Done", onPressed: () {
                    backToPrevious();
                  }),
                  boxH32()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _departureCityBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: padAll(),
              child: Column(
                children: [
                  boxH8(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Search Location",
                          style: AppTextTheme.subtitleBoldStyle),
                      GestureDetector(
                          onTap: () {
                            backToPrevious();
                          },
                          child: const Icon(Icons.clear)),
                    ],
                  ),
                  boxH16(),
                  SearchableDropdown(
                      hint: "Search Location",
                      initialValue: departureCity != "" ? departureCity : null,
                      (location) {
                    setState(() {
                      departureCity = location;
                    });
                  }),
                  boxH16(),
                  buildButton("Done", onPressed: () {
                    backToPrevious();
                  }),
                  boxH32()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
