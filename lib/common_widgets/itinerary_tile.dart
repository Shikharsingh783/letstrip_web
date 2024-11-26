import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/generated/I10n.dart';
import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/models/itninerary_result_model.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';
import 'package:letstrip/utils/utilities.dart';

class ItineraryTile extends StatefulWidget {
  final ItineraryResultModel itineraryData;

  const ItineraryTile({super.key, required this.itineraryData});

  @override
  ItineraryTileState createState() => ItineraryTileState();
}

class ItineraryTileState extends State<ItineraryTile> {
  bool isHowToReachExpended = false;
  bool isEveningExpended = false;
  bool isLunchExpended = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text("${widget.itineraryData.day}",
            style: AppTextTheme.subHeadingBoldStyle
                .copyWith(color: Theme.of(context).colorScheme.inversePrimary)),
        boxH16(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsIHome, width: 48.w, height: 48.h),
              SizedBox(
                height: isHowToReachExpended ? 200.h : 185.h,
                child: VerticalDivider(
                    color: Theme.of(context).colorScheme.primary),
              )
            ]),
            boxW16(),
            Expanded(child: detailContainer(morningCard(widget.itineraryData)))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsIcoFood, width: 48.w, height: 48.h),
              SizedBox(
                height: 145.h,
                child: VerticalDivider(
                    color: Theme.of(context).colorScheme.primary),
              )
            ]),
            boxW16(),
            Expanded(child: detailContainer(lunchCard(widget.itineraryData)))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsIcoFood, width: 48.w, height: 48.h),
              SizedBox(
                height: isEveningExpended ? 180.h : 165.h,
                child: VerticalDivider(
                    color: Theme.of(context).colorScheme.primary),
              )
            ]),
            boxW16(),
            Expanded(
              child: detailContainer(eveningCard(widget.itineraryData)),
            )
          ],
        ),
        boxH16(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsDinner, width: 48.w, height: 48.h),
              SizedBox(
                height: 145.h,
                child: VerticalDivider(
                    color: Theme.of(context).colorScheme.primary),
              )
            ]),
            boxW16(),
            Expanded(child: detailContainer(dinnerCard(widget.itineraryData)))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [
              vector(Assets.assetsDinner, width: 48.w, height: 48.h),
              SizedBox(
                height: 145.h,
                child: VerticalDivider(
                    color: Theme.of(context).colorScheme.primary),
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
    return Container(
        padding: padAll(value: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
            border: Border.all(color: Theme.of(context).colorScheme.outline)),
        child: child);
  }

  Widget morningCard(ItineraryResultModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text(data.time ?? "Morning",
            style: AppTextTheme.labelBoldStyle
                .copyWith(color: Theme.of(context).colorScheme.scrim)),
        boxH4(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.activityName ?? "",
                      style: AppTextTheme.subtitleBoldStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  boxH4(),
                  Text(data.reason ?? "",
                      style: AppTextTheme.captionStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
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
                    child: data.imageUrl!.isNotEmpty
                        ? loadImageWithThumbnail(
                            data.imageUrl![0].urls.thumb.toString(),
                            data.imageUrl![0].urls.full.toString(),
                          )
                        : loadImage("", height: 100.h, fit: BoxFit.cover),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFFDB146), size: 16.w),
                    boxW4(),
                    Text("4.5 ",
                        style: AppTextTheme.bodyBoldStyle
                            .copyWith(color: const Color(0xFFFDB146)))
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
                launchURL(data.ticketLink);
              },
              child: Container(
                padding: padSym(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(4))),
                child: Text(S.of(context).buyTickets,
                    style: AppTextTheme.labelBoldStyle.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            boxW8(),
            Expanded(
                child: Text(data.ticketCost ?? "",
                    style: AppTextTheme.caption9SpStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis))
          ],
        ),
        boxH16(),
        Container(
            padding: padSym(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(ScreenUtil().radius(4))),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isHowToReachExpended = !isHowToReachExpended;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      vector(Assets.assetsReach),
                      boxW8(),
                      Text(S.of(context).howToReach,
                          style: AppTextTheme.labelBoldStyle),
                      const Spacer(),
                      Icon(isHowToReachExpended
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    ],
                  ),
                  if (isHowToReachExpended)
                    Text(data.howToReach ?? "",
                        style: AppTextTheme.caption8SpStyle)
                ],
              ),
            ))
      ],
    );
  }

  Widget lunchCard(ItineraryResultModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text(data.timeLunch ?? "Afternoon",
            style: AppTextTheme.labelBoldStyle
                .copyWith(color: Theme.of(context).colorScheme.scrim)),
        boxH4(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.lunch ?? "",
                      style: AppTextTheme.subtitleBoldStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  boxH4(),
                  Text(data.lunchReason ?? "",
                      style: AppTextTheme.captionStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
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
                    child: data.foodImages!.isNotEmpty
                        ? loadImageWithThumbnail(
                            data.foodImages![0].urls.thumb.toString(),
                            data.foodImages![0].urls.full.toString(),
                          )
                        : loadImage("", height: 100.h, fit: BoxFit.cover),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFFDB146), size: 16.w),
                    boxW4(),
                    Text(data.lunchRating ?? "",
                        style: AppTextTheme.bodyBoldStyle
                            .copyWith(color: const Color(0xFFFDB146)))
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
                launchURL(data.lunchLink);
              },
              child: Container(
                padding: padSym(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(4))),
                child: Text(S.of(context).reserve,
                    style: AppTextTheme.labelBoldStyle.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            boxW8(),
            Expanded(
                child: Text(data.lunchCost ?? "",
                    style: AppTextTheme.caption9SpStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis))
          ],
        ),
      ],
    );
  }

  Widget eveningCard(ItineraryResultModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text("Evening",
            style: AppTextTheme.labelBoldStyle
                .copyWith(color: Theme.of(context).colorScheme.scrim)),
        boxH4(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.activityNameLunch ?? "",
                      style: AppTextTheme.subtitleBoldStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  boxH4(),
                  Text(data.reasonLunch ?? "",
                      style: AppTextTheme.captionStyle,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis),
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
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(4)),
                      child: data.imageUrl!.isNotEmpty
                          ? loadImageWithThumbnail(
                              data.imageUrl![1].urls.thumb.toString(),
                              data.imageUrl![1].urls.full.toString(),
                            )
                          : loadImage("", height: 100.h, fit: BoxFit.cover)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFFDB146), size: 16.w),
                    boxW4(),
                    Text(data.ratingLunch ?? "",
                        style: AppTextTheme.bodyBoldStyle
                            .copyWith(color: const Color(0xFFFDB146)))
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
                launchURL(data.ticketLinkLunch);
              },
              child: Container(
                padding: padSym(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(4))),
                child: Text(S.of(context).reserve,
                    style: AppTextTheme.labelBoldStyle.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            boxW8(),
            Expanded(
                child: Text(data.ticketCostLunch ?? "",
                    style: AppTextTheme.caption9SpStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis))
          ],
        ),
        boxH16(),
        Container(
            padding: padSym(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(ScreenUtil().radius(4))),
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
                      Text(S.of(context).howToReach,
                          style: AppTextTheme.labelBoldStyle),
                      const Spacer(),
                      Icon(isEveningExpended
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    ],
                  ),
                  if (isEveningExpended)
                    Text(data.howToReachLunch ?? "",
                        style: AppTextTheme.caption8SpStyle)
                ],
              ),
            )),
      ],
    );
  }

  Widget dinnerCard(ItineraryResultModel data) {
    print("data.dinner : ${data.dinner}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boxH8(),
        Text("Dinner",
            style: AppTextTheme.labelBoldStyle
                .copyWith(color: Theme.of(context).colorScheme.scrim)),
        boxH4(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.dinner ?? "",
                      style: AppTextTheme.subtitleBoldStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  boxH4(),
                  Text(data.dinnerReason ?? "",
                      style: AppTextTheme.captionStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
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
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(4)),
                      child: data.foodImages!.isNotEmpty
                          ? loadImageWithThumbnail(
                              data.foodImages![1].urls.thumb.toString(),
                              data.foodImages![1].urls.full.toString(),
                            )
                          : loadImage("", height: 100.h, fit: BoxFit.cover)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFFDB146), size: 16.w),
                    boxW4(),
                    Text(data.dinnerRating ?? "",
                        style: AppTextTheme.bodyBoldStyle
                            .copyWith(color: const Color(0xFFFDB146)))
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
                launchURL(data.dinnerLink);
              },
              child: Container(
                padding: padSym(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(4))),
                child: Text(S.of(context).reserve,
                    style: AppTextTheme.labelBoldStyle.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
            boxW8(),
            Expanded(
                child: Text(data.dinnerCost ?? "",
                    style: AppTextTheme.caption9SpStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis))
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
        Text("Stay",
            style: AppTextTheme.labelBoldStyle
                .copyWith(color: Theme.of(context).colorScheme.scrim)),
        boxH4(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.stay ?? "",
                      style: AppTextTheme.subtitleBoldStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  boxH4(),
                  Text(data.stayCost ?? "",
                      style: AppTextTheme.captionStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
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
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(4)),
                      child: data.foodImages!.isNotEmpty
                          ? loadImageWithThumbnail(
                              data.stayImage![0].urls.thumb.toString(),
                              data.stayImage![0].urls.full.toString(),
                            )
                          : loadImage("", height: 100.h, fit: BoxFit.cover)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded,
                        color: const Color(0xFFFDB146), size: 16.w),
                    boxW4(),
                    Text(data.stayRating ?? "",
                        style: AppTextTheme.bodyBoldStyle
                            .copyWith(color: const Color(0xFFFDB146)))
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
            launchURL(data.stayLink);
          },
          child: Container(
            padding: padSym(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(ScreenUtil().radius(4))),
            child: Text(S.of(context).reserve,
                style: AppTextTheme.labelBoldStyle
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
          ),
        )
      ],
    );
  }
}
