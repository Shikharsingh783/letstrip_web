import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:letstrip/models/user_model.dart';
import 'package:letstrip/utils/constants.dart';
import 'package:letstrip/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'shared_pref.dart';

class DropdownType {
  String value;
  String iconPath;
  bool isPng;

  DropdownType(this.value, this.iconPath, {this.isPng = false});
}

extension Separation on List<Widget> {
  ///add vertical gap between widgets
  List<Widget> separateVertically(double gap) {
    final separatedWidgets = <Widget>[];

    for (var i = 0; i < length; i++) {
      separatedWidgets.add(this[i]);
      if (i < length - 1) {
        separatedWidgets.add(SizedBox(height: gap));
      }
    }

    return separatedWidgets;
  }

  ///add horizontal gap between widgets
  List<Widget> separateHorizontally(double gap) {
    final separatedWidgets = <Widget>[];

    for (var i = 0; i < length; i++) {
      separatedWidgets.add(this[i]);
      if (i < length - 1) {
        separatedWidgets.add(SizedBox(width: gap));
      }
    }

    return separatedWidgets;
  }
}

// getUser() {
//   Map<String, dynamic>? userData = SharedPref.getObject(user);
//   if (userData != null) {
//     return User.fromJson(userData);
//   } else {
//     return null;
//   }
// }

bool isEmailValid(String? email) {
  if (email == null || email.isEmpty) {
    return false;
  }
  RegExp regex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return regex.hasMatch(email);
}

// void cropImage(
//     {required BuildContext context,
//     required File file,
//     required Function(CroppedFile croppedFile) onImageCropped,
//     bool isDoc = false}) async {
//   final croppedFile = await ImageCropper()
//       .cropImage(sourcePath: file.path, aspectRatioPresets: [
//     isDoc ? CropAspectRatioPreset.ratio16x9 : CropAspectRatioPreset.square,
//   ], uiSettings: [
//     AndroidUiSettings(
//         toolbarTitle: "Crop Image",
//         toolbarColor: Theme.of(context).colorScheme.primary,
//         toolbarWidgetColor: Colors.white,
//         initAspectRatio: CropAspectRatioPreset.original,
//         lockAspectRatio: true),
//     IOSUiSettings(title: "Crop Image")
//   ]);
//   if (croppedFile != null) {
//     imageCache.clear();
//     onImageCropped(croppedFile);
//   }
// }

bool isDigitOnly(String str) {
  RegExp regex = RegExp(r'^[0-9]+$');
  return regex.hasMatch(str);
}

String formatDate2(String inputDate) {
  List<String> dateTimeParts = inputDate.split('T');
  String datePart = dateTimeParts[0];
  List<String> dateParts = datePart.split('-');
  String formattedDate = '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';
  return formattedDate;
}

String formatDate(DateTime date) {
  final String day = date.day < 10 ? '0${date.day}' : '${date.day}';
  return '${_getMonthName(date.month)} $day, ${date.year}';
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}

String getCurrentTimeFormatted() {
  DateTime now = DateTime.now();
  String formattedDate = formatDate(now);

  // Get AM/PM
  String period = now.hour < 12 ? 'AM' : 'PM';

  // Convert hour to 12-hour format
  int hour12 = now.hour > 12 ? now.hour - 12 : now.hour;
  if (hour12 == 0) hour12 = 12;
  String formattedTime =
      '$hour12:${now.minute.toString().padLeft(2, '0')} $period';

  return '$formattedDate: $formattedTime';
}

enum HistoryDescriptionColor { RED, GREEN }

final List<String> expensesList = [
  "Food",
  "Drinks",
  "Hotel",
  "Transport",
  "Travel",
  "Leisure",
  "Cigarettes",
  "Groceries",
  "Others"
];

String removeINR(String price) {
  return price.replaceAll("INR", '');
}

Future<void> launchURL(String? url) async {
  if (url == null) {
    showErrorToast('Could not launch $url');
    return;
  }
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    showErrorToast('Could not launch $url');
    throw 'Could not launch $url';
  }
}
