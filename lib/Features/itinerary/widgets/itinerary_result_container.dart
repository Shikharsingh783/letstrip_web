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
import 'package:letstrip/repositories/auth_repo.dart';
import 'package:letstrip/repositories/itinerary_controller.dart';
import 'package:letstrip/repositories/itinerary_repo.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/constants.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';
import 'package:letstrip/utils/toast.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'dart:js' as js;

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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late String pusherApiKey = '608da2e342ab52f4751c';
  late String pusherClusterName = "ap2";
  late String pusherChannelName = "streaming";
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

    // Delay initialization until after the first build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize only if widget.result is null
      if (widget.result == null) {
        controller.getItinerary(widget.request);

        // Setup a listener on `controller.eventId` to initialize Pusher
        ever(controller.eventId, (value) {
          if (value != null) {
            setupPusher(value);
          }
        });
      } else {
        // Update the list with image URLs from the result
        for (ItineraryResultModel model in widget.result!) {
          controller.updateListWithImageUrl(model);
        }
      }

      // Initialize fields with request data if available
      if (widget.request != null) {
        // Ensure no direct `setState()` calls are happening here
        // Instead, initialize properties for later use
        budget = widget.request.budget.toString();
        destinations = widget.request.destinations;
        tripType = widget.request.tripType;
        endDate = widget.request.endDate!;
        startDate = widget.request.startDate!;
      }
    });
  }

  void setupPusher(String eventId) async {
    try {
      // Check if the eventId is null or empty
      if (eventId == null || eventId.isEmpty) {
        debugPrint("Error: eventId is null or empty");
        showErrorToast("Event ID is missing.");
        return; // Exit the function if eventId is null or empty
      }

      // Log the eventId for debugging
      debugPrint("Using eventId: $eventId");

      // Ensure pusherChannelName is not null or empty
      if (pusherChannelName == null || pusherChannelName.isEmpty) {
        debugPrint("Error: pusherChannelName is null or empty");
        showErrorToast("Channel name is missing.");
        return; // Exit if the channel name is missing
      }

      // Debugging the availability of the method
      debugPrint(
          "subscribeToChannel method: ${js.context['subscribeToChannel']}");

      // Initialize Pusher with JavaScript interop
      js.context.callMethod('subscribeToChannel', [
        pusherChannelName, // Pusher channel name
        js.allowInterop((eventData) {
          // Null check on eventData before processing
          if (eventData == null) {
            debugPrint("Error: eventData is null");
            return; // Exit if eventData is null
          }

          debugPrint("Raw Event Data: $eventData");

          // Check if the eventData is a Map and contains the 'data' key
          if (eventData is Map) {
            debugPrint("Event Data Keys: ${eventData.keys}");
            if (eventData.containsKey('data')) {
              debugPrint("Event data received: ${eventData['data']}");
            } else {
              debugPrint("No 'data' key in event data.");
            }
          } else {
            debugPrint("Unexpected event data format: $eventData");
          }

          // Trigger the callback to process the event data
          onPusherEventTrigger(eventData);
        })
      ]);

      debugPrint("Pusher setup completed successfully.");
    } catch (e) {
      // Catch any errors during the setup
      debugPrint("Error in Pusher setup: $e");
      showErrorToast("Pusher initialization failed.");
    }
  }

  void onPusherEventTrigger(dynamic data) {
    setState(() {
      // If data is present, process the event
      if (data != null) {
        var decodedData = jsonDecode(data['data']);
        debugPrint("Event data received: ${decodedData.toString()}");

        // Check for the necessary fields or event identifiers in the data
        if (decodedData.containsKey('eventId')) {
          controller.updateListWithImageUrl(
              ItineraryResultModel.fromJson(decodedData));
        } else {
          // Handle other types of events or data here
          debugPrint("Unhandled event data: $decodedData");
        }
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
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      drawer: FilterDrawer(
        controller.itineraryRequest.value,
        performFilter: (request) {
          print('Performing filter logic');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            print('Updating state after build');
            controller.getItinerary(request);
            controller.tripList.clear();
            setupPusher(controller.eventId.value);
          });
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
          scaffoldKey.currentState!.openDrawer();
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
                    onTap: () {
                      // setState(() {
                      //   isHowToReachExpended = !isHowToReachExpended;
                      // });
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
            // Obx(
            //         () => controller.tripList.isEmpty
            //             ? const Center(child: CircularProgressIndicator())
            //             : Expanded(
            //                 child: ListView.builder(
            //                   itemCount: controller.tripList.length,
            //                   itemBuilder: (c, index) => ItineraryTile(
            //                     itineraryData: controller.tripList[index],
            //                   ),
            //                 ),
            //               ),
            //       ),

            const Center(
              child: Text('Data here'),
            ),

            if (!isHowToReachExpended)
              Divider(color: Theme.of(context).colorScheme.outline),
          ],
        ),
      ),
    );
  }

  Widget DesktopContainer() {
    debugPrint("Building Container widget...");
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
                              preCheckedItems: const [
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
                              initialValue: widget.request.budget.toString(),
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
