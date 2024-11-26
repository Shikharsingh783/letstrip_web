import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:letstrip/Features/itinerary/widgets/chip_container.dart';
import 'package:letstrip/common_widgets/budget_container.dart';
import 'package:letstrip/common_widgets/check_box.dart';
import 'package:letstrip/common_widgets/chip_multi_select.dart';
import 'package:letstrip/common_widgets/custom_toggle.dart';
import 'package:letstrip/common_widgets/date_range_selector.dart';
import 'package:letstrip/common_widgets/filter_drawer.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/common_widgets/itinerary_tile.dart';
import 'package:letstrip/common_widgets/star_rating.dart';
import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/models/itinerary_request.dart';
import 'package:letstrip/models/itninerary_result_model.dart';
import 'package:letstrip/network/environment.dart';
import 'package:letstrip/repositories/auth_repo.dart';
import 'package:letstrip/repositories/itinerary_controller.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:letstrip/theme/text_style.dart';

import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ItineraryResultContainer extends StatefulWidget {
  final ItineraryRequest request;
  final List<ItineraryResultModel>? result;
  const ItineraryResultContainer(
      {super.key, this.result, required this.request});

  @override
  State<ItineraryResultContainer> createState() =>
      _ItineraryResultContainerState();
}

ItineraryRepository itineraryRepository = ItineraryRepository();

class _ItineraryResultContainerState extends State<ItineraryResultContainer> {
  final String baseUrl = 'https://identity.letstrip.world/api/v1/production';
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

  final controller = Get.find<ItineraryController>();
  late PusherChannelsFlutter pusher;
  late AuthService authService;

  @override
  void initState() {
    super.initState();

    // Delay initialization to ensure Flutter bindings are ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.result != null && widget.result!.isNotEmpty) {
        for (ItineraryResultModel model in widget.result!) {
          controller.updateListWithImageUrl(model);
        }
      } else {
        controller.getItinerary(widget.request);
        ever(controller.eventId, (value) {
          startPollingForUpdates(
              value); // Use polling or replace with setupPusher
        });
      }

      // Initialize fields from request
      budget = widget.request.budget.toString();
      destinations = widget.request.destinations;
      tripType = widget.request.tripType;
      endDate = widget.request.endDate!;
      startDate = widget.request.startDate!;
    });
  }

  Timer? pollingTimer;

  void startPollingForUpdates(String eventId) {
    pollingTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/itinerary/$eventId'),
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9eyJpZCI6IjY3MmJhNTNhYzJkZjdlY2ZiMGMyYjQzNCIsImVtYWlsIjoic2hpa2hhcnMzNjlAZ21haWwuY29tIiwiYWN0aXZlIjp0cnVlLCJjdXJyZW5jeSI6eyJjb3VdHJ5IjoiTmV3IFplYWxhbmQgRG9sbGFyIiwic3ltYm9sIjoiJCIsImNvZGUiOiJOWkQifSwicm9sZSI6InVzZXIiLCJkZWxldGVkIjpmYWxzZSwiaWF0IjoxNzMxNzQ3Mjk3LCJleHAiOjE3MzQzMzkyOTd9FPMHcum4v0kROuOpJQkl2C5ac8K7XtSJWORw1C6WNaY',
          },
        );
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          debugPrint("Raw Response: ${response.body}");
          debugPrint("Decoded response data: $data");
          if (data['status'] == 'Processing') {
            debugPrint(
                "Itinerary is still being generated. Polling will continue...");
          } else if (data['status'] == 'Completed') {
            debugPrint("Itinerary generation completed!");
            controller
                .updateListWithImageUrl(ItineraryResultModel.fromJson(data));
            pollingTimer?.cancel(); // Stop polling once the itinerary is ready
          } else {
            debugPrint("Unhandled status: ${data['status']}");
            pollingTimer?.cancel(); // Stop polling for unexpected status
          }
        } else {
          debugPrint("Polling failed with status code: ${response.statusCode}");
        }
      } catch (e) {
        debugPrint("Error during polling: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => DesktopContainer(),
      mobile: (context) => mobileContainer(),
    );
  }

  Widget mobileContainer() {
    bool isHowToReachExpended = true;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: FilterDrawer(
        controller.itineraryRequest.value,
        performFilter: (request) {
          controller.getItinerary(request);
          controller.tripList.clear();
          // setupPusher(controller.eventId.value);
        },
      ),
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   leading: GestureDetector(
      //     onTap: () {
      //       backToPrevious();
      //     },
      //     child: const Icon(Icons.arrow_back),
      //   ),
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         // moveTo(screenName: const ProfileScreen());
      //       },
      //       child: CircleAvatar(
      //         radius: ScreenUtil().radius(20),
      //         // backgroundImage: NetworkImage(
      //         //   getUser().pictureUrl == ""
      //         //       ? 'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'
      //         //       : getUser().pictureUrl,
      //         // ),
      //       ),
      //     ),
      //     boxW16(),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: const Color.fromRGBO(57, 185, 111, 1),
        elevation: 0,
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          child: Row(
            children: [
              const Text(
                'Customize',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white),
              ),
              boxW4(),
              const Icon(
                Icons.edit,
                color: Colors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: padAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth(percentage: 80),
              child: Text(
                'Unique attractions based on your interest',
                style: AppTextTheme.headingW900RHStyle,
              ),
            ),
            Divider(color: Theme.of(context).colorScheme.outline),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      '${widget.request.originCity.split(',')[0]}  \u2192 ${widget.request.destinations.join(', ')}',
                      style: AppTextTheme.bodyBoldStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(isHowToReachExpended
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up),
                    onTap: () {
                      setState(() {
                        isHowToReachExpended = !isHowToReachExpended;
                      });
                    },
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     _scaffoldKey.currentState?.openDrawer();
                //   },
                //   child: vector(Assets.assetsFilterIcon),
                // ),
                boxW16(),
              ],
            ),
            Divider(color: Theme.of(context).colorScheme.outline),
            isHowToReachExpended
                ? Obx(
                    () => controller.tripList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView.builder(
                              itemCount: controller.tripList.length,
                              itemBuilder: (c, index) => ItineraryTile(
                                itineraryData: controller.tripList[index],
                              ),
                            ),
                          ),
                  )
                : Wrap(
                    runSpacing: 8.h,
                    spacing: 8.w,
                    children: [
                      textWithIcon(context, Assets.assetsCumpass,
                          widget.request.destinations.join(' | ')),
                      textWithIcon(context, Assets.assetsDate,
                          widget.request.startDate.toString().substring(0, 10)),
                      textWithIcon(context, Assets.assetsDate,
                          widget.request.endDate.toString().substring(0, 10)),
                      textWithIcon(context, Assets.assetsFamityVacation,
                          [widget.request.tripType].join(' | ')),
                      textWithIcon(context, Assets.assetsAmount,
                          "${widget.request.budget}"),
                      textWithIcon(context, Assets.assetsThaiFood,
                          widget.request.food.join(' | ')),
                      textWithIcon(context, Assets.assetsCar,
                          widget.request.modeOfTransport.join(' | ')),
                    ],
                  ),
            if (!isHowToReachExpended)
              Divider(color: Theme.of(context).colorScheme.outline),
          ],
        ),
      ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.request.originCity.split(',')[0]}  \u2192 ${widget.request.destinations.join(', ')}',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
