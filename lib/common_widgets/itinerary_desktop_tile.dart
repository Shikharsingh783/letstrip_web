import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/generated/I10n.dart';
import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/models/itninerary_result_model.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';
import 'package:letstrip/utils/utilities.dart';

class ItineraryDesktopTile extends StatefulWidget {
  final ItineraryResultModel itineraryData;
  const ItineraryDesktopTile({super.key, required this.itineraryData});

  @override
  State<ItineraryDesktopTile> createState() => _ItineraryDesktopTileState();
}

class _ItineraryDesktopTileState extends State<ItineraryDesktopTile> {
  bool isHowToReachExpended = false;
  bool isEveningExpended = false;
  bool isLunchExpended = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text("Day ${widget.itineraryData.day}",
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(57, 185, 111, 1),
                fontFamily: 'Raleway')),
        boxH16(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsIHome, width: 48.w, height: 48.h),
              SizedBox(
                height: isHowToReachExpended ? 200.w : 185.w,
                child: const VerticalDivider(
                    color: Color.fromRGBO(57, 185, 111, 1)),
              )
            ]),
            boxW16(),
            Expanded(child: detailContainer(morningCard(widget.itineraryData)))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsIcoFood, width: 48.w, height: 48.h),
              SizedBox(
                height: 185.w,
                child: const VerticalDivider(
                    color: Color.fromRGBO(57, 185, 111, 1)),
              )
            ]),
            boxW16(),
            Expanded(child: detailContainer(lunchCard(widget.itineraryData)))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        boxH16(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsIcoFood, width: 48.w, height: 48.h),
              SizedBox(
                height: isEveningExpended ? 200.w : 185.w,
                child: const VerticalDivider(
                    color: Color.fromRGBO(57, 185, 111, 1)),
              )
            ]),
            boxW16(),
            Expanded(
              child: detailContainer(eveningCard(widget.itineraryData)),
            )
          ],
        ),
        boxH16(),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsDinner, width: 48.w, height: 48.h),
              SizedBox(
                height: 185.w,
                child: const VerticalDivider(
                    color: Color.fromRGBO(57, 185, 111, 1)),
              )
            ]),
            boxW16(),
            Expanded(child: detailContainer(dinnerCard(widget.itineraryData)))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsDinner, width: 48.w, height: 48.h),
              SizedBox(
                height: 185.w,
                child: const VerticalDivider(
                    color: Color.fromRGBO(57, 185, 111, 1)),
              )
            ]),
            boxW16(),
            Expanded(child: detailContainer(stayCard(widget.itineraryData)))
          ],
        ),
      ],
    );
  }

  Widget detailContainer(Widget child) {
    final w = MediaQuery.of(context).size.width;
    return Container(
        padding: padAll(value: 8),
        height: w * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
            border:
                Border.all(color: const Color.fromRGBO(102, 102, 102, 0.15))),
        child: child);
  }

  //* morning

  Widget morningCard(ItineraryResultModel data) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left content
          Expanded(
            flex: 2, // Adjust flex to balance space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.time ?? "Morning",
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(176, 176, 176, 1),
                  ),
                ),
                boxH4(),
                Text(
                  data.activityName ?? "Visit the Eiffel Tower, Paris, France",
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                boxH4(),
                SizedBox(
                  width: w * 0.4,
                  child: Text(
                    data.reason ??
                        "Since it was built and opened to the public in 1889, the Eiffel Tower instantly gained international fame, as it was then the tallest building in the world.",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(102, 102, 102, 1),
                    ),
                    // maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                boxH16(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (data.ticketLink != null) {
                          launchURL(data.ticketLink!);
                        }
                      },
                      child: Container(
                        padding: padSym(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(223, 246, 234, 1),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(4)),
                        ),
                        child: const Text(
                          'buy tickets',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(57, 185, 111, 1),
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ),
                    boxW8(),
                    Expanded(
                      child: Text(
                        data.ticketCost ?? "300-400",
                        style: AppTextTheme.caption9SpStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                boxH16(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isHowToReachExpended = !isHowToReachExpended;
                    });
                  },
                  child: Container(
                    width: w * 0.4,
                    padding: padSym(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(4)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            vector(Assets.assetsReach),
                            boxW8(),
                            Text(
                              'How to Reach',
                              style: AppTextTheme.labelBoldStyle,
                            ),
                            const Spacer(),
                            Icon(
                              isHowToReachExpended
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                        if (isHowToReachExpended)
                          Text(
                            data.howToReach ?? "Go straight",
                            style: AppTextTheme.caption8SpStyle,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Image Section
          Flexible(
            flex: 1, // Adjust space allocation
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                  child: SizedBox(
                    width: double.infinity, // Full width for alignment
                    height: 180.0, // Height spans from top to bottom
                    child: data.imageUrl?.isNotEmpty == true
                        ? loadImageWithThumbnail(
                            data.imageUrl![0]['photo'].urls.thumb.toString(),
                            data.imageUrl![0]['photo'].urls.full.toString(),
                          )
                        : loadImage("", height: 180.0, fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFDB146),
                        size: 16,
                      ),
                      boxW4(),
                      Text(
                        "4.5",
                        style: AppTextTheme.bodyBoldStyle
                            .copyWith(color: const Color(0xFFFDB146)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //* lunch

  Widget lunchCard(ItineraryResultModel data) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left content
          Expanded(
            flex: 2, // Adjust flex to balance space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.timeLunch ?? "Morning",
                  style: GoogleFonts.raleway(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(176, 176, 176, 1),
                  ),
                ),
                boxH4(),
                Text(
                  data.lunch ?? "Visit the Eiffel Tower, Paris, France",
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                boxH4(),
                SizedBox(
                  width: w * 0.4,
                  child: Text(
                    data.lunchReason ??
                        "Since it was built and opened to the public in 1889, the Eiffel Tower instantly gained international fame, as it was then the tallest building in the world.",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(102, 102, 102, 1),
                    ),
                    // maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                boxH16(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (data.ticketLink != null) {
                          launchURL(data.ticketLink!);
                        }
                      },
                      child: Container(
                        padding: padSym(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(223, 246, 234, 1),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(4)),
                        ),
                        child: const Text(
                          'Reserve',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(57, 185, 111, 1),
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ),
                    boxW8(),
                    Expanded(
                      child: Text(
                        data.ticketCost ?? "300-400",
                        style: AppTextTheme.caption9SpStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                boxH16(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isHowToReachExpended = !isHowToReachExpended;
                    });
                  },
                  child: Container(
                    width: w * 0.4,
                    padding: padSym(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(4)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            vector(Assets.assetsReach),
                            boxW8(),
                            Text(
                              'How to Reach',
                              style: AppTextTheme.labelBoldStyle,
                            ),
                            const Spacer(),
                            Icon(
                              isHowToReachExpended
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                        if (isHowToReachExpended)
                          Text(
                            data.howToReach ?? "Go straight",
                            style: AppTextTheme.caption8SpStyle,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Image Section
          Flexible(
            flex: 1, // Adjust space allocation
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                  child: SizedBox(
                    width: double.infinity, // Full width for alignment
                    height: 180.0, // Height spans from top to bottom
                    child: data.foodImages?.isNotEmpty == true
                        ? loadImageWithThumbnail(
                            data.foodImages![0]['photo'].urls.thumb.toString(),
                            data.foodImages![0]['photo'].urls.full.toString(),
                          )
                        : loadImage("", height: 180.0, fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFDB146),
                        size: 16,
                      ),
                      boxW4(),
                      Text(
                        "4.5",
                        style: AppTextTheme.bodyBoldStyle
                            .copyWith(color: const Color(0xFFFDB146)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget eveningCard(ItineraryResultModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text(
          "Evening",
          style: GoogleFonts.raleway(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(176, 176, 176, 1)),
        ),
        boxH4(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.activityNameLunch ??
                        "Visit Musee d'Orsay, Paris, France", // Fallback value for activity name
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  boxH4(),
                  Text(
                    data.reasonLunch ??
                        "The Musée d'Orsay is a world-renowned museum in Paris, France, located on the Left Bank of the Seine. It's housed in the former Gare d'Orsay, a Beaux-Arts railway station built from 1898 to 1900. The grand building itself is a piece of art.", // Fallback for reason description
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(102, 102, 102, 1)),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 75.w,
                  height: 75.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                    child: (data.imageUrl != null && data.imageUrl!.isNotEmpty)
                        ? loadImageWithThumbnail(
                            data.imageUrl![1]['photo'].urls.thumb.toString(),
                            data.imageUrl![1]['photo'].urls.full.toString(),
                          )
                        : loadImage("",
                            height: 100.h,
                            fit: BoxFit.cover), // Fallback for image
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFFDB146), size: 16.w),
                    boxW4(),
                    Text(
                      data.ratingLunch ?? "", // Fallback for rating
                      style: AppTextTheme.bodyBoldStyle
                          .copyWith(color: const Color(0xFFFDB146)),
                    )
                  ],
                )
              ],
            ),
            boxH8()
          ],
        ),
        boxH8(),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (data.ticketLinkLunch != null) {
                  launchURL(
                      data.ticketLinkLunch!); // Null check for ticket link
                }
              },
              child: Container(
                padding: padSym(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(223, 246, 234, 1),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(4))),
                child: const Text('Reserve',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(57, 185, 111, 1),
                        fontFamily: 'Raleway')),
              ),
            ),
            boxW8(),
            Expanded(
                child: Text(
              data.ticketCostLunch ?? "350-490", // Fallback for ticket cost
              style: AppTextTheme.caption9SpStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ))
          ],
        ),
        boxH16(),
        Container(
          padding: padSym(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isEveningExpended = !isEveningExpended;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    vector(Assets.assetsReach),
                    boxW8(),
                    Text(
                      "How to Reach",
                      style: AppTextTheme.labelBoldStyle,
                    ),
                    const Spacer(),
                    Icon(
                      isEveningExpended
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
                if (isEveningExpended)
                  Text(
                    data.howToReachLunch ??
                        "Turn Right", // Fallback for how to reach
                    style: AppTextTheme.caption8SpStyle,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dinnerCard(ItineraryResultModel data) {
    print("data.dinner : ${data.dinner}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text(
          "Dinner",
          style: GoogleFonts.raleway(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(176, 176, 176, 1)),
        ),
        boxH4(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.dinner ??
                        '''Ambassade d’Auvergne, Paris, France''', // Fallback for dinner name
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  boxH4(),
                  Text(
                    data.dinnerReason ??
                        "The Ambassade d'Auvergne isn't an actual embassy, but a restaurant in Paris!  It's a well-regarded spot known for serving traditional cuisine from the Auvergne region of France. They have a cozy atmosphere with exposed rafters and vintage posters.", // Fallback for reason
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(102, 102, 102, 1)),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 75.w,
                  height: 75.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                    child: (data.foodImages != null &&
                            data.foodImages!.isNotEmpty)
                        ? loadImageWithThumbnail(
                            data.foodImages![1]['photo'].urls.thumb.toString(),
                            data.foodImages![1]['photo'].urls.full.toString(),
                          )
                        : loadImage("",
                            height: 100.h,
                            fit: BoxFit.cover), // Fallback for image
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFFDB146),
                      size: 16.w,
                    ),
                    boxW4(),
                    Text(
                      data.dinnerRating ?? "4.7", // Fallback for rating
                      style: AppTextTheme.bodyBoldStyle
                          .copyWith(color: const Color(0xFFFDB146)),
                    ),
                  ],
                )
              ],
            ),
            boxW8()
          ],
        ),
        boxH8(),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (data.dinnerLink != null) {
                  launchURL(data.dinnerLink!); // Null check for link
                }
              },
              child: Container(
                padding: padSym(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(223, 246, 234, 1),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(4))),
                child: const Text('Reserve',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(57, 185, 111, 1),
                        fontFamily: 'Raleway')),
              ),
            ),
            boxW8(),
            Expanded(
              child: Text(
                data.dinnerCost ?? "900", // Fallback for cost
                style: AppTextTheme.caption9SpStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget stayCard(ItineraryResultModel data) {
    print("data.stay: ${data.stay}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text(
          "Stay",
          style: AppTextTheme.labelBoldStyle
              .copyWith(color: Theme.of(context).colorScheme.scrim),
        ),
        boxH4(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.stay ?? "Taj Mahal Hotel", // Fallback for stay name
                    style: AppTextTheme.subtitleBoldStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  boxH4(),
                  Text(
                    data.stayCost ?? "5.0", // Fallback for cost
                    style: AppTextTheme.captionStyle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 75.w,
                  height: 75.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                    child: (data.stayImage != null &&
                            data.stayImage!.isNotEmpty)
                        ? loadImageWithThumbnail(
                            data.stayImage![0]['photo'].urls.thumb.toString(),
                            data.stayImage![0]['photo'].urls.full.toString(),
                          )
                        : loadImage("",
                            height: 100.h,
                            fit: BoxFit.cover), // Fallback for image
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFFDB146),
                      size: 16.w,
                    ),
                    boxW4(),
                    Text(
                      data.stayRating ?? "", // Fallback for rating
                      style: AppTextTheme.bodyBoldStyle
                          .copyWith(color: const Color(0xFFFDB146)),
                    ),
                  ],
                )
              ],
            ),
            boxW8()
          ],
        ),
        boxH8(),
        GestureDetector(
          onTap: () {
            if (data.stayLink != null) {
              launchURL(data.stayLink!); // Null check for link
            }
          },
          child: Container(
            padding: padSym(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(223, 246, 234, 1),
                borderRadius: BorderRadius.circular(ScreenUtil().radius(4))),
            child: const Text('Reserve',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(57, 185, 111, 1),
                    fontFamily: 'Raleway')),
          ),
        ),
      ],
    );
  }
}
