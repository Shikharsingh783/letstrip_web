import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';
import 'package:letstrip/utils/utilities.dart';

Widget vector(String asset,
    {double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: SvgPicture.asset(asset,
        width: width, height: height, fit: fit, color: color),
  );
}

AppBar appBar(BuildContext context, String text,
    {bool isSmallFont = false,
    bool automaticallyImplyLeading = true,
    bool showProfileIcon = true,
    bool showBottomDivider = true}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    backgroundColor: Theme.of(context).colorScheme.background,
    title: Text(text,
        style: AppTextTheme.heading25BoldRH900Style.copyWith(
            fontSize: ScreenUtil().setSp(isSmallFont ? 16.sp : 22.sp))),
    centerTitle: false,
    actions: [
      showProfileIcon ? profileIcon(context) : const SizedBox.shrink(),
      boxW16()
    ],
    bottom: showBottomDivider ? greenBottomBar(context) : null,
  );
}

PreferredSizeWidget greenBottomBar(BuildContext context,
    {Color? bottomDividerColor}) {
  return PreferredSize(
    preferredSize: Size(screenWidth(), ScreenUtil().setHeight(16)),
    child: Padding(
      padding: padSym(horizontal: 16),
      child: Divider(
          color: bottomDividerColor ??
              Theme.of(context).colorScheme.secondaryContainer,
          thickness: 3),
    ),
  );
}

Widget profileIcon(BuildContext context, {int radius = 20}) {
  return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const ProfileOptionsScreen(),
        //   ),
        // );
      },
      child: CircleAvatar(
        radius: radius.r,
        backgroundImage: const NetworkImage(
            'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
      ));
}

Widget textWithIcon(BuildContext context, String icon, String text) {
  return Container(
      padding: padSym(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().radius(24)),
          border: Border.all(color: Theme.of(context).colorScheme.outline)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          vector(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          boxW8(),
          Text(text, style: AppTextTheme.labelMedium13SpStyle)
        ],
      ));
}

Widget loadImage(String imageUrl,
    {double? width, double? height, BoxFit fit = BoxFit.cover, String? tag}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: width,
    height: height,
    fit: fit,
    placeholder: (context, url) => Center(
      child: SizedBox(
          height: ScreenUtil().setHeight(30),
          width: ScreenUtil().setWidth(30),
          child: const CircularProgressIndicator()),
    ),
    errorWidget: (context, url, error) {
      if (imageUrl.endsWith("svg")) {
        return vectorNetwork(imageUrl);
      } else {
        return Image.asset(Assets.assetsImgPlaceholder, fit: BoxFit.cover);
      }
    },
  );
}

Widget loadImageWithThumbnail(String thumb, String imageUrl,
    {double? width, double? height, BoxFit fit = BoxFit.cover, String? tag}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: width,
    height: height,
    fit: fit,
    placeholder: (context, url) => Center(
      child: loadImage(thumb, fit: BoxFit.fitWidth),
    ),
    errorWidget: (context, url, error) {
      if (imageUrl.endsWith("svg")) {
        return vectorNetwork(imageUrl);
      } else {
        return Image.asset(Assets.assetsImgPlaceholder, fit: BoxFit.cover);
      }
    },
  );
}

Widget vectorNetwork(String asset,
    {double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color}) {
  return SvgPicture.network(asset,
      width: width, height: height, fit: fit, color: color);
}
