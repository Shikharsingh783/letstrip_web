import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/lets_trip_app.dart';
import 'package:letstrip/utils/padding_helper.dart';

Widget buildButton(String text,
    {required VoidCallback onPressed,
    EdgeInsets? padding,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor}) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: padding ?? padAll(value: 25),
            backgroundColor: const Color.fromRGBO(57, 185, 111, 1),
            shape: RoundedRectangleBorder(
                side: borderColor != null
                    ? BorderSide(color: borderColor)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(8.sp)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Raleway',
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
