import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
